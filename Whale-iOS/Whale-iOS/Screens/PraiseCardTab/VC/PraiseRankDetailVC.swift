//
//  PraiseRankDetailVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/16.
//

import UIKit

class PraiseRankDetailVC: UIViewController {
    
    var priasedName: String? {
        didSet {
            praiseDetailService(priasedName!)
        }
    }
    var detailRankCollectionData: [CollectionPraise] = []
    var navigationBarView = UIView()
    var backBtn = UIButton()
    var nicknameLabel = UILabel()
    var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""
    var praiseCardLabel = UILabel()
    var yellowLineView = UIView()
    var roundPraisedPersonNameView = UIView()
    var praisedPersonNameLabel = UILabel()
    var cardBoxImageView = UIImageView()
    
    lazy var praiseDetailCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20 // cell사이의 간격 설정
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.scrollIndicatorInsets = .zero
        view.backgroundColor = .clear
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        registerCell()
    }
    
    // 대리자 위임
    private func setupDelegate() {
        praiseDetailCV.delegate = self
        praiseDetailCV.dataSource = self
    }
    
    // 셀 등록
    private func registerCell() {
        praiseDetailCV.register(PraiseCardCVCell.self, forCellWithReuseIdentifier: PraiseCardCVCell.id)
    }
    
    
    //MARK: - 칭찬카드 상단부 View 생성(UILabel, RoundNicknameView)
    func makeTopView() {
        
        self.view.backgroundColor = .yellow_2
        self.view.addSubview(navigationBarView)
        navigationBarView.backgroundColor = .yellow_2
        navigationBarView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(39)
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(view.snp.trailing).offset(0)
            make.height.equalTo(48)
            make.width.equalTo(view.snp.width)
        }
        
        self.navigationBarView.addSubview(backBtn)
        backBtn.setImage(UIImage(named: "btnBack"), for: .normal)
        backBtn.addTarget(self, action: #selector(backToRankVC), for: .touchUpInside)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.top).offset(0)
            make.leading.equalTo(navigationBarView.snp.leading).offset(0)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        //create: nicknameLabel 생성 -> '~님의'
        self.view.addSubview(nicknameLabel)
        nicknameLabel.text = nickName + "님의"
        nicknameLabel.textColor = .brown_2
        nicknameLabel.font = .AppleSDGothicR(size: 16)
        nicknameLabel.letterSpacing = -0.8
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom).offset(0)
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
        
        //create - praisedPerson Name Label 생성
        self.view.addSubview(roundPraisedPersonNameView)
        self.view.addSubview(praisedPersonNameLabel)
        
        praisedPersonNameLabel.text = priasedName
        praisedPersonNameLabel.textColor = .black
        praisedPersonNameLabel.font = .AppleSDGothicR(size: 17)
        praisedPersonNameLabel.letterSpacing = -0.85
        
        praisedPersonNameLabel.snp.makeConstraints { make in
            make.top.equalTo(yellowLineView.snp.bottom).offset(48)
            make.height.equalTo(22)
            make.centerX.equalTo(yellowLineView)
        }
        
        //create - praisedPerson Round View 생성
        roundPraisedPersonNameView.backgroundColor = .white
        roundPraisedPersonNameView.layer.cornerRadius = 25
        roundPraisedPersonNameView.layer.borderWidth = 2
        roundPraisedPersonNameView.layer.borderColor = UIColor.yellow_3.cgColor
    
        roundPraisedPersonNameView.snp.makeConstraints { make in
            make.top.equalTo(praisedPersonNameLabel.snp.bottom).offset(34)
            make.height.equalTo(51)
            make.width.equalTo(praisedPersonNameLabel.snp.width).offset(54)
            make.centerX.equalTo(praisedPersonNameLabel)
            make.centerY.equalTo(praisedPersonNameLabel)
        }
    }
    
    //func - 카드랭킹 상세보기 View 생성 (CollectionView)
    func cardRankDetailMakeBottomView(_ praiseDetailData: PraiseDetailData) {
        
        //create - Yellow box View 생성
        makeYellowCardBox()
        
        let praiseCountLabel = UILabel()
        let praiseCountText = "\(praiseDetailData.praiseCount)번의 칭찬"
        let range1 = "\(praiseDetailData.praiseCount)번"
        
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
        
        self.view.addSubview(praiseDetailCV)
        praiseDetailCV.snp.makeConstraints { make in
            make.top.equalTo(praiseCountLabel.snp.bottom).offset(20)
            make.leading.equalTo(cardBoxImageView.snp.leading).offset(0)
            make.trailing.equalTo(cardBoxImageView.snp.trailing).offset(0)
            make.height.equalTo(350)
        }
        
        praiseDetailCV.reloadData()
    }
    
    @objc func backToRankVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Network 통신
extension PraiseRankDetailVC {
    func praiseDetailService(_ nickname: String) {
        PraiseService.shared.praiseDetailService(nickName: nickname) { [self](networkResult) -> (Void) in
            switch networkResult {
            case .success(let data):
                if let detailRankData = data as? PraiseDetailData {
                    detailRankCollectionData = detailRankData.collectionPraise
                    print(detailRankData)
                    makeTopView()
                    cardRankDetailMakeBottomView(detailRankData)
                }
                
            case .requestErr(let msg):
                if msg is String {
                    print(msg)
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

// UI
extension PraiseRankDetailVC {
    //create - yellowCardBoxImageView 생성
    func makeYellowCardBox() {
        self.view.addSubview(cardBoxImageView)
        cardBoxImageView.image = UIImage(named: "cardBoxBg")
        cardBoxImageView.snp.makeConstraints { make in
            make.top.equalTo(roundPraisedPersonNameView.snp.bottom).offset(28)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
            make.centerX.equalTo(roundPraisedPersonNameView)
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PraiseRankDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailRankCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = praiseDetailCV.dequeueReusableCell(withReuseIdentifier: PraiseCardCVCell.id, for: indexPath)
        if let cell = cell as? PraiseCardCVCell {
            cell.toPraisePersonText = detailRankCollectionData[indexPath.item].praisedName
            cell.praisedDateText = detailRankCollectionData[indexPath.item].createdAt
            cell.praiseContentText = detailRankCollectionData[indexPath.item].todayPraise
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PraiseRankDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 291, height: 340)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 42)
    }
}
