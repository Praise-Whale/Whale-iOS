//
//  PraiseCardVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit
import SnapKit

class PraiseCardVC: UIViewController {
    
    //MARK: - 정의 변수
    var nicknameLabel = UILabel()
    var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""
    var praiseCardLabel = UILabel()
    var yellowBoxView = UIView()
    var cardBoxImageView = UIImageView()
    var emptyImageView = UIImageView()
    let date = Date()
    let calendar = Calendar.current
    var currentYear: String = ""
    
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
        praiseCardService(currentYear, "0")
    }
    
    func getCurrentYearMonth() {
        let components = calendar.dateComponents([.year, .month], from: date)
        currentYear =  String(describing: components.year)
    }
    
    //MARK: - 오토레이아웃 적용 함수
    func setAutoLayout() {
        //screenSize에 따라 달라질 동적 width, height
        roundSegmentView.frameWidth = 225
        roundSegmentView.frameHeight = 51
    }
    
    func makeYellowBox() {
        //create - cardBoxImageView 생성
        self.view.addSubview(cardBoxImageView)
        cardBoxImageView.image = UIImage(named: "cardBoxBg")
        cardBoxImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(roundSegmentView.snp.bottom).offset(28)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
            make.centerX.equalTo(roundSegmentView)
        }
    }
    
    //MARK: - 칭찬카드 상단부 View 생성(UILabel, RoundSegmentControl)
    func makeTopView() {
        //create: nicknameLabel 생성 -> '~님의'
        self.view.addSubview(nicknameLabel)
        nicknameLabel.text = nickName + "님의"
        nicknameLabel.textColor = .brown_2
        nicknameLabel.font = .AppleSDGothicR(size: 16)
        nicknameLabel.letterSpacing = -0.8
        nicknameLabel.snp.makeConstraints { (make) -> Void in
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
        praiseCardLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(2)
            make.height.equalTo(32)
            make.centerX.equalTo(nicknameLabel)
        }
        
        //create - Yellow box View 생성
        self.view.addSubview(yellowBoxView)
        yellowBoxView.backgroundColor = .yellow_1
        yellowBoxView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(praiseCardLabel.snp.bottom).offset(6)
            make.height.equalTo(2)
            make.width.equalTo(81)
            make.centerX.equalTo(praiseCardLabel)
        }
        
        //set snp - segmentView 레이아웃 세팅
        roundSegmentView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(yellowBoxView.snp.bottom).offset(34)
            make.height.equalTo(51)
            make.width.equalTo(225)
            make.centerX.equalTo(yellowBoxView)
        }
        
        //create - cardBoxImageView 생성
        makeYellowBox()
    }
    
    //func - 카드서랍에 데이터가 없을 때 실행되는 함수 + 칭찬카드 하단부 View 생성
    func noDataInCardDrawerMakeBottomView() {
        makeYellowBox()
        
        self.view.addSubview(emptyImageView)
        emptyImageView.image = UIImage(named: "emptyImgWhale")
        emptyImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cardBoxImageView).offset(122)
            make.height.equalTo(113)
            make.width.equalTo(133)
            make.centerX.equalTo(yellowBoxView)
        }
        let noPraiseBoldLabel = UILabel()
        self.view.addSubview(noPraiseBoldLabel)
        noPraiseBoldLabel.font = .AppleSDGothicB(size: 21)
        noPraiseBoldLabel.text = "아직 칭찬을 하지 않았어요!"
        noPraiseBoldLabel.letterSpacing = -1.05
        noPraiseBoldLabel.textColor = UIColor(red: 61/255, green: 53/255, blue: 44/255, alpha: 0.7)
        noPraiseBoldLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(emptyImageView.snp.bottom).offset(14)
            make.height.equalTo(29)
            make.centerX.equalTo(emptyImageView)
        }
        
        let subLabel1 = UILabel()
        self.view.addSubview(subLabel1)
        subLabel1.font = .AppleSDGothicR(size: 17)
        subLabel1.text = "칭찬 미션을 완료하고"
        subLabel1.letterSpacing = -0.85
        subLabel1.textColor = UIColor(red: 61/255, green: 53/255, blue: 44/255, alpha: 0.7)
        subLabel1.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(noPraiseBoldLabel.snp.bottom).offset(6)
            make.height.equalTo(22)
            make.centerX.equalTo(noPraiseBoldLabel)
        }
        
        
        let subLabel2 = UILabel()
        self.view.addSubview(subLabel2)
        subLabel2.font = .AppleSDGothicR(size: 17)
        subLabel2.text = "칭찬 카드를 모아봐요!"
        subLabel2.letterSpacing = -0.85
        subLabel2.textColor = UIColor(red: 61/255, green: 53/255, blue: 44/255, alpha: 0.7)
        subLabel2.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(subLabel1.snp.bottom).offset(1)
            make.height.equalTo(22)
            make.centerX.equalTo(noPraiseBoldLabel)
        }
    }
    
    //func - 카드서랍에 데이터가 있을 때 실행되는 함수 + 칭찬카드 하단부 View 생성 (CollectionView, datePopUp)
    func yesDataInCardDrawerMakeBottomView() {
        
    }
    
    func makeLankingBottomView() {
        makeYellowBox()
        let praiseCountLabel = UILabel()
        self.view.addSubview(praiseCountLabel)
        praiseCountLabel.font = .AppleSDGothicB(size: 22)
        praiseCountLabel.text = "7명에게 칭찬"
        praiseCountLabel.letterSpacing = -1.1
        praiseCountLabel.textColor = .brown_1
            praiseCountLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(cardBoxImageView.snp.top).offset(28)
                make.leading.equalTo(cardBoxImageView.snp.leading).offset(42)
            make.height.equalTo(31)
        }
    }
}
//MARK: - set defualt superView layout
extension PraiseCardVC {
    
    func setSuperViewLayout() {
        self.view.backgroundColor = .yellow_2
        self.roundSegmentView.backgroundColor = .clear
    }
}

//MARK: - notifiication
extension PraiseCardVC {
    func notificationAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(whenPushedCardDrawer), name: .pushedCardDrawer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(whenPushedPraiseLank), name: .pushedPraiseLank, object: nil)
    }
    
    @objc func whenPushedCardDrawer() {
        
        print("CardDrawer")
        praiseCardService(currentYear, "0")
    }
    
    @objc func whenPushedPraiseLank() {
        
        print("PraiseLank")
        makeLankingBottomView()
    }
}

//MARK: - network Service
extension PraiseCardVC {
    func praiseCardService(_ year: String, _ month: String) {
        PraiseService.shared.praiseDateService(year: year, month: month) { [self](networkResult) -> (Void) in
            switch networkResult {
            case .success(let data):
                if let praiseData = data as? PraiseData {
                    print("firstDate", praiseData.firstDate)
                    print("praiseCount", praiseData.praiseCount)
                    yesDataInCardDrawerMakeBottomView()
                }
                
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
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
