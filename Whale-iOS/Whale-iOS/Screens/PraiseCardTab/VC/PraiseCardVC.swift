//
//  PraiseCardVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit
import SnapKit
import Then

class PraiseCardVC: UIViewController {
    
    //MARK: - 정의 변수
    var nicknameLabel = UILabel()
    var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""
    var praiseCardLabel = UILabel()
    var yellowLineView = UIView()
    var cardBoxImageView = UIImageView()
    var emptyImageView = UIImageView()
    let date = Date()
    let calendar = Calendar.current
    var praiseDataArray: [CollectionPraise] = []
    lazy var praiseCV: UICollectionView = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 20 // cell사이의 간격 설정
            let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
            view.backgroundColor = .clear

            return view
        }()
    var currentYear: String = ""
    var currentMonth: String = ""
    var selectedYear: String = ""
    var selectedMonth: String = ""
    var whiteCardButtonTitle = ""
    
    //MARK: - IBOutlet
    @IBOutlet var roundSegmentView: RoundSegmentView!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentYearMonth()
        notificationAddObserver()
        setAutoLayout()
        setSuperViewLayout()
        makeTopView()
        setupDelegate()
        registerCell()
    }
    
    func getCurrentYearMonth() {
        let components = calendar.dateComponents([.year, .month], from: date)
        currentYear = (components.year ?? 0).toString()
        currentMonth = (components.month ?? 0).toString()
        //칭찬카드 첫 진입 시 현재년도 전체로 표기하기 위해 파라미터로 현재년도와 0 보냄
        praiseCardService(currentYear, "0")
        selectedYear = currentYear
        selectedMonth = "0"
    }
    
    //MARK: - 오토레이아웃 적용 함수
    func setAutoLayout() {
        //screenSize에 따라 달라질 동적 width, height
        roundSegmentView.frameWidth = 225
        roundSegmentView.frameHeight = 51
    }
    
    //MARK: - 칭찬카드 상단부 View 생성(UILabel, RoundSegmentControl)
    func makeTopView() {
        
        //create: nicknameLabel 생성 -> '~님의'
        self.view.addSubview(nicknameLabel)
        nicknameLabel.text = nickName + "님의"
        nicknameLabel.textColor = .brown_2
        nicknameLabel.font = .AppleSDGothicR(size: 16)
        nicknameLabel.letterSpacing = -0.8
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(85)
            make.height.equalTo(21)
            make.centerX.equalTo(self.view)
        }
        
        //create: praiseLabel 생성 -> '칭찬카드'
        self.view.addSubview(praiseCardLabel)
        praiseCardLabel.text = "칭찬 카드"
        praiseCardLabel.textColor = .brown_2
        praiseCardLabel.font = .AppleSDGothicB(size: 23)
        praiseCardLabel.letterSpacing = -1.15
        praiseCardLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(2)
            make.height.equalTo(32)
            make.centerX.equalTo(nicknameLabel)
        }
        
        //create - Yellow line View 생성
        self.view.addSubview(yellowLineView)
        yellowLineView.backgroundColor = .yellow_1
        yellowLineView.snp.makeConstraints { make in
            make.top.equalTo(praiseCardLabel.snp.bottom).offset(6)
            make.height.equalTo(2)
            make.width.equalTo(81)
            make.centerX.equalTo(praiseCardLabel)
        }
        
        //set snp - segmentView 레이아웃 세팅
        roundSegmentView.snp.makeConstraints { make in
            make.top.equalTo(yellowLineView.snp.bottom).offset(34)
            make.height.equalTo(51)
            make.width.equalTo(225)
            make.centerX.equalTo(yellowLineView)
        }
    }
    
    //func - 카드서랍에 데이터가 없을 때 실행되는 함수 + 칭찬카드 하단부 View 생성
    func noDataInCardDrawerMakeBottomView() {
        makeYellowCardBox()
        noDataTemplateLayout("아직 칭찬을 하지 않았어요!", sub1LabelText: "칭찬 미션을 완료하고", sub2LabelText: "칭찬 카드를 모아봐요!")
    }
    
    //func - 카드서랍에 데이터가 있을 때 실행되는 함수 + 칭찬카드 하단부 View 생성 (CollectionView, datePopUp)
    func yesDataInCardDrawerMakeBottomView(_ praiseData: PraiseData) {
        
        //create - Yellow box View 생성
        makeYellowCardBox()
        
        //create - whiteCardbutton 생성
        makeWhiteDateButton()
        
        let praiseCountLabel = UILabel()
        let praiseCountText = "\(praiseData.praiseCount)번의 칭찬"
        let range1 = "\(praiseData.praiseCount)번"
        
        let praiseCountLabelAttributedString = NSMutableAttributedString(string: praiseCountText, attributes: [
                                                                            .font: UIFont.AppleSDGothicR(size: 22),
                                                                            .foregroundColor: UIColor.brown_1,
                                                                            .kern: -1.1 ])
        praiseCountLabelAttributedString.addAttribute(.font, value: UIFont.AppleSDGothicB(size: 22), range: (praiseCountText as NSString).range(of: range1))
        praiseCountLabel.attributedText = praiseCountLabelAttributedString
        
        
        self.view.addSubview(praiseCountLabel)
        praiseCountLabel.snp.makeConstraints { make in
            make.top.equalTo(cardBoxImageView.snp.top).offset(28)
            make.leading.equalTo(cardBoxImageView.snp.leading).offset(42)
        }
        
        self.view.addSubview(praiseCV)
        praiseCV.snp.makeConstraints { make in
            make.top.equalTo(praiseCountLabel.snp.bottom).offset(20)
            make.leading.equalTo(cardBoxImageView.snp.leading).offset(0)
            make.trailing.equalTo(cardBoxImageView.snp.trailing).offset(0)
            make.height.equalTo(350)
        }
        
        praiseCV.reloadData()
    }
    
    private func setupDelegate() {
        praiseCV.delegate = self
        praiseCV.dataSource = self
    }
    
    private func registerCell() {
        praiseCV.register(PraiseCardCVCell.self, forCellWithReuseIdentifier: PraiseCardCVCell.id)
      }
    
    //func - 선택된 달에 칭찬기록이 없을 때 UI를 구성하는 함수
    func noPraiseInThisMonth() {
        //create - Yellow box View 생성
        makeYellowCardBox()
        
        //create - whiteCardbutton 생성
        makeWhiteDateButton()
        
        //create - 데이터가 없을 때 empty뷰 생성
        noDataTemplateLayout("이 달에 완료한 칭찬이 없어요!", sub1LabelText: "앞으로 더 꾸준한", sub2LabelText: "칭찬 습관을 길러봐요!")
    }
    
    //func - whiteBtn을 눌렀을 때 datePicker를 띄우는 액션함수
    @objc func popUpCustomDatePicker() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerPopUpVC") as? DatePickerPopUpVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func makeLankingBottomView() {
        makeYellowCardBox()
        let praiseCountLabel = UILabel()
        self.view.addSubview(praiseCountLabel)
        praiseCountLabel.font = .AppleSDGothicB(size: 22)
        praiseCountLabel.text = "7명에게 칭찬"
        praiseCountLabel.letterSpacing = -1.1
        praiseCountLabel.textColor = .brown_1
        praiseCountLabel.snp.makeConstraints { make in
            make.top.equalTo(cardBoxImageView.snp.top).offset(28)
            make.leading.equalTo(cardBoxImageView.snp.leading).offset(42)
            make.height.equalTo(31)
        }
    }
}

//MARK: - defualt superView layout
extension PraiseCardVC {
    
    func setSuperViewLayout() {
        self.view.backgroundColor = .yellow_2
        self.roundSegmentView.backgroundColor = .clear
    }
}

//MARK: - picker에서 선택된 year, month 데이터를 넘겨주는 Protocol 채택
extension PraiseCardVC: selectYearMonthFromPicker {
    
    //datePicker로 선택된 year, month
    func setYearMonth(_ year: Int, _ month: Int) {
        selectedYear = year.toString()
        selectedMonth = month.toString()
        praiseCardService(selectedYear, selectedMonth)
    }
}

extension PraiseCardVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return praiseDataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = praiseCV.dequeueReusableCell(withReuseIdentifier: PraiseCardCVCell.id, for: indexPath)
        if let cell = cell as? PraiseCardCVCell {
            cell.toPraisePersonText = praiseDataArray[indexPath.item].praisedName
            cell.praisedDateText = praiseDataArray[indexPath.item].createdAt
            cell.praiseContentText = praiseDataArray[indexPath.item].todayPraise
        }

        return cell
    }
}

extension PraiseCardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 291, height: 340)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 42)
    }
}

//MARK: - Notifiication
extension PraiseCardVC {
    func notificationAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(whenPushedCardDrawer), name: .pushedCardDrawer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(whenPushedPraiseLank), name: .pushedPraiseLank, object: nil)
    }
    
    @objc func whenPushedCardDrawer() {
        
        print("CardDrawer")
        praiseCardService(selectedYear, selectedMonth)
    }
    
    @objc func whenPushedPraiseLank() {
        
        print("PraiseLank")
        makeLankingBottomView()
    }
}

//MARK: - Network Service
extension PraiseCardVC {
    func praiseCardService(_ year: String, _ month: String) {
        PraiseService.shared.praiseDateService(year: year, month: "0" + month) { [self](networkResult) -> (Void) in
            switch networkResult {
            case .success(let data):
                if let praiseData = data as? PraiseData {
                    praiseDataArray = praiseData.collectionPraise
                    if UserDefaults.standard.string(forKey: "praiseFirstDate") == nil {
                        UserDefaults.standard.set( praiseData.firstDate.createdAt.split(separator: "T")[0], forKey: "praiseFirstDate")
                    }
                    
                    if praiseData.praiseCount == 0 {
                        noPraiseInThisMonth()
                    }
                    else {
                        yesDataInCardDrawerMakeBottomView(praiseData)
                    }
                }
                
            case .requestErr(let msg):
                if msg is String {
                    noDataInCardDrawerMakeBottomView()
                }
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

//MARK: - 공용 UI
extension PraiseCardVC {
    
    //create - yellowCardBoxImageView 생성
    func makeYellowCardBox() {
        self.view.addSubview(cardBoxImageView)
        cardBoxImageView.image = UIImage(named: "cardBoxBg")
        cardBoxImageView.snp.makeConstraints { make in
            make.top.equalTo(roundSegmentView.snp.bottom).offset(28)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
            make.centerX.equalTo(roundSegmentView)
        }
    }
    
    //create - 날짜 설정하는 흰색 버튼 생성
    func makeWhiteDateButton() {
        let whiteCardbutton = UIButton()
        let selectButtonImageView = UIImageView()
        self.view.addSubview(whiteCardbutton)
        
        if selectedMonth == "0" {
            whiteCardButtonTitle = "\(selectedYear)년 전체  "
        } else {
            whiteCardButtonTitle = "\(selectedYear)년 \(selectedMonth)월  "
        }
        
        whiteCardbutton.setTitle(whiteCardButtonTitle, for: .normal)
        whiteCardbutton.setTitleColor(.brown_1, for: .normal)
        whiteCardbutton.titleLabel?.font = .AppleSDGothicR(size: 13)
        whiteCardbutton.titleLabel?.letterSpacing = -0.65
        whiteCardbutton.backgroundColor = .white
        whiteCardbutton.layer.cornerRadius = 10
        whiteCardbutton.addTarget(self, action: #selector(popUpCustomDatePicker), for: .touchUpInside)
        
        whiteCardbutton.snp.makeConstraints { make in
            make.top.equalTo(cardBoxImageView.snp.top).offset(28)
            make.trailing.equalTo(cardBoxImageView.snp.trailing).offset(-42)
            make.height.equalTo(33)
            make.width.equalTo(103)
        }
        
        self.view.addSubview(selectButtonImageView)
        selectButtonImageView.image = UIImage(named: "cardIcMonth")
        
        selectButtonImageView.snp.makeConstraints { make in
            make.trailing.equalTo(whiteCardbutton.snp.trailing).offset(-15)
            make.centerY.equalTo(whiteCardbutton)
        }
    }
    
    //create - 선택된 달에 데이터가 없을 경우 UI를 구성하는 템플릿
    func noDataTemplateLayout(_ boldLabelText: String, sub1LabelText: String, sub2LabelText: String) {
        self.view.addSubview(emptyImageView)
        emptyImageView.image = UIImage(named: "emptyImgWhale")
        emptyImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cardBoxImageView).offset(122)
            make.height.equalTo(113)
            make.width.equalTo(133)
            make.centerX.equalTo(cardBoxImageView)
        }
        let noPraiseBoldLabel = UILabel()
        self.view.addSubview(noPraiseBoldLabel)
        noPraiseBoldLabel.font = .AppleSDGothicB(size: 21)
        noPraiseBoldLabel.text = boldLabelText
        noPraiseBoldLabel.letterSpacing = -1.05
        noPraiseBoldLabel.textColor = UIColor(red: 61/255, green: 53/255, blue: 44/255, alpha: 0.7)
        noPraiseBoldLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(14)
            make.height.equalTo(29)
            make.centerX.equalTo(emptyImageView)
        }
        
        let subLabel1 = UILabel()
        self.view.addSubview(subLabel1)
        subLabel1.font = .AppleSDGothicR(size: 17)
        subLabel1.text = sub1LabelText
        subLabel1.letterSpacing = -0.85
        subLabel1.textColor = UIColor(red: 61/255, green: 53/255, blue: 44/255, alpha: 0.7)
        subLabel1.snp.makeConstraints { make in
            make.top.equalTo(noPraiseBoldLabel.snp.bottom).offset(6)
            make.height.equalTo(22)
            make.centerX.equalTo(noPraiseBoldLabel)
        }
        
        let subLabel2 = UILabel()
        self.view.addSubview(subLabel2)
        subLabel2.font = .AppleSDGothicR(size: 17)
        subLabel2.text = sub2LabelText
        subLabel2.letterSpacing = -0.85
        subLabel2.textColor = UIColor(red: 61/255, green: 53/255, blue: 44/255, alpha: 0.7)
        subLabel2.snp.makeConstraints { make in
            make.top.equalTo(subLabel1.snp.bottom).offset(1)
            make.height.equalTo(22)
            make.centerX.equalTo(noPraiseBoldLabel)
        }
    }
    
}
