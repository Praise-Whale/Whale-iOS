//
//  LevelVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit
import SnapKit

class LevelVC: UIViewController {
    
    var levelInfoBtn = UIButton()
    var nicknameLabel = UILabel()
    var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""
    var whaleNameLabel = UILabel()
    var yellowLineView = UIView()
    var cardBoxImageView = UIImageView()
    var progressView: CircularGradientProgressBar = CircularGradientProgressBar()
    var whaleImageView = UIImageView()
    var levelImageView = UIImageView()
    var roundLevelDescView = UIView()
    var levelDescLabel = UILabel()
    var praiseCountLabel = UILabel()
    var yellowLineView2 = UIView()
    var nextLevelGuideLabel = UILabel()
    
    
    var countFired: CGFloat = 0
    var userLevel: CGFloat = 0
    var whaleName: String = ""
    var praiseCnt: CGFloat = 0
    var levelUpNeedCount: Int = 0
    var goal: Int = 0
    var levelImageName: String = ""
    var whaleImageName: String = ""
    var levelDescText: String = ""
    var nextLavelGuideText: String = ""
    var whaleImageFrame: CGSize?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWhaleLevelService()
    }
    
    //MARK: - 칭찬카드 상단부 View 생성(UILabel, RoundNicknameView)
    func makeTopView(level: CGFloat, praiseCnt: CGFloat) {
        
        self.view.backgroundColor = .yellow_2
        
        self.view.addSubview(levelInfoBtn)
        levelInfoBtn.setImage(UIImage(named: "lvBtnInfo"), for: .normal)
        levelInfoBtn.addTarget(self, action: #selector(touchUpToLevelInfoBtn), for: .touchUpInside)
        levelInfoBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(39)
            make.trailing.equalTo(self.view.snp.trailing).offset(-6)
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
            make.top.equalTo(self.view).offset(85)
            make.height.equalTo(21)
            make.centerX.equalTo(self.view)
        }
        
        //create: whaleLabel 생성
        self.view.addSubview(whaleNameLabel)
        whaleNameLabel.text = whaleName
        whaleNameLabel.textColor = .brown_2
        whaleNameLabel.font = .AppleSDGothicB(size: 23)
        whaleNameLabel.letterSpacing = -1.15
        
        whaleNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(2)
            make.height.equalTo(32)
            make.centerX.equalTo(nicknameLabel)
        }
        
        //create - Yellow line View 생성
        self.view.addSubview(yellowLineView)
        yellowLineView.backgroundColor = .yellow_1
        
        yellowLineView.snp.makeConstraints { make in
            make.top.equalTo(whaleNameLabel.snp.bottom).offset(6)
            make.height.equalTo(2)
            make.width.equalTo(whaleNameLabel.snp.width)
            make.centerX.equalTo(whaleNameLabel)
        }
        
        //create - round Gradient ProgressView 생성
        self.view.addSubview(progressView)
        progressView.backgroundCircleColor = UIColor(red: 255/255, green: 238/255, blue: 195/255, alpha: 1.0)
        progressView.startGradientColor = UIColor(red: 255/255, green: 223/255, blue: 136/255, alpha: 1.0)
        progressView.endGradientColor = UIColor(red: 255/255, green: 186/255, blue: 0, alpha: 1.0)
        progressView.layer.backgroundColor = .none
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(yellowLineView.snp.bottom).offset(47)
            make.height.equalTo(301)
            make.width.equalTo(301)
            make.centerX.equalTo(yellowLineView)
        }
        showCase(level: level, praiseCnt: praiseCnt)
        
        
        self.view.addSubview(whaleImageView)
        whaleImageView.image = UIImage(named: whaleImageName)
        whaleImageView.frame.size = whaleImageFrame ?? CGSize()
        whaleImageView.snp.makeConstraints { make in
            make.centerX.equalTo(progressView)
            make.centerY.equalTo(progressView)
        }
        
        self.view.addSubview(roundLevelDescView)
        roundLevelDescView.backgroundColor = .white
        roundLevelDescView.layer.borderWidth = 2
        roundLevelDescView.layer.borderColor = UIColor.yellow_3.cgColor
        roundLevelDescView.layer.cornerRadius = 25
        roundLevelDescView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(59)
            make.height.equalTo(51)
            make.width.equalTo(229)
            make.centerX.equalTo(progressView)
        }
        
        self.view.addSubview(levelImageView)
        levelImageView.image = UIImage(named: levelImageName)
        levelImageView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(26)
            make.height.equalTo(45)
            make.width.equalTo(45)
            make.centerX.equalTo(progressView)
        }
        
        self.view.addSubview(levelDescLabel)
        levelDescLabel.text = levelDescText
        levelDescLabel.textColor = .brown_1
        levelDescLabel.font = .AppleSDGothicR(size: 16)
        levelDescLabel.letterSpacing = -0.8
        
        levelDescLabel.snp.makeConstraints { make in
            make.height.equalTo(23)
            make.centerX.equalTo(roundLevelDescView)
            make.centerY.equalTo(roundLevelDescView)
        }
        
        self.view.addSubview(praiseCountLabel)
        let praiseCntText = "칭찬 \(Int(praiseCnt))번"
        let praiseCntRange = "\(Int(praiseCnt))번"
        
        let praiseCountLabelAttributedString = NSMutableAttributedString(string: praiseCntText, attributes: [
                                                                            .font: UIFont.AppleSDGothicR(size: 16),
                                                                            .foregroundColor: UIColor.brown_1,
                                                                            .kern: -0.8 ])
        praiseCountLabelAttributedString.addAttribute(.font, value: UIFont.AppleSDGothicB(size: 22), range: (praiseCntText as NSString).range(of: praiseCntRange))
        
        praiseCountLabel.attributedText = praiseCountLabelAttributedString
        
        praiseCountLabel.snp.makeConstraints { make in
            make.top.equalTo(roundLevelDescView.snp.bottom).offset(17)
            make.height.equalTo(31)
            make.centerX.equalTo(roundLevelDescView)
        }
        
        self.view.addSubview(yellowLineView2)
        yellowLineView2.backgroundColor = .yellow_1
        yellowLineView2.snp.makeConstraints { make in
            make.top.equalTo(praiseCountLabel.snp.bottom).offset(5)
            make.height.equalTo(2)
            make.width.equalTo(42)
            make.centerX.equalTo(praiseCountLabel)
        }
        
        self.view.addSubview(nextLevelGuideLabel)
        if level != 5 {
            let nextLevelGuideText = nextLavelGuideText
            let nextLevelGuideRange = "\(goal)번"
            
            let nextLevelGuideLabelAttributedString = NSMutableAttributedString(string: nextLevelGuideText, attributes: [
                                                                                .font: UIFont.AppleSDGothicR(size: 16),
                                                                                    .foregroundColor: UIColor(red: 80/255, green: 48/255, blue: 0, alpha: 0.66),
                                                                                .kern: -0.8 ])
            nextLevelGuideLabelAttributedString.addAttribute(.font, value: UIFont.AppleSDGothicB(size: 16), range: (nextLevelGuideText as NSString).range(of: nextLevelGuideRange))
            
            nextLevelGuideLabel.attributedText = nextLevelGuideLabelAttributedString
            
        }
        else {
            let nextLevelGuideText = "\(nickName)님은 이제 칭찬의 신!"
            let nextLevelGuideRange = "칭찬의 신!"
            
            let nextLevelGuideLabelAttributedString = NSMutableAttributedString(string: nextLevelGuideText, attributes: [
                                                                                .font: UIFont.AppleSDGothicR(size: 16),
                                                                                    .foregroundColor: UIColor(red: 80/255, green: 48/255, blue: 0, alpha: 0.66),
                                                                                .kern: -0.8 ])
            nextLevelGuideLabelAttributedString.addAttribute(.font, value: UIFont.AppleSDGothicB(size: 16), range: (nextLevelGuideText as NSString).range(of: nextLevelGuideRange))
            
            nextLevelGuideLabel.attributedText = nextLevelGuideLabelAttributedString
            
        }
        
        nextLevelGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(yellowLineView2.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.centerX.equalTo(yellowLineView2)
        }
    }
}
// Button Action
extension LevelVC {
    @objc func touchUpToLevelInfoBtn() {
        if let levelInfoVC = self.storyboard?.instantiateViewController(identifier: "LevelInfoVC") as? LevelInfoVC {
            levelInfoVC.modalPresentationStyle = .fullScreen
            self.present(levelInfoVC, animated: true, completion: nil)
        }
    }
}

// progressView
extension LevelVC {
    private func showCase(level: CGFloat, praiseCnt: CGFloat) {
        var standard:CGFloat = 0
        var exchangePraiseCnt: CGFloat = 0
        var gagePercent: CGFloat = 0.0
        
        if level == 0 {
            print("level 0")
            standard = 5
            goal = 5
            exchangePraiseCnt = praiseCnt
            gagePercent = exchangePraiseCnt / standard
            
            levelImageName = "lvIcLv0"
            whaleImageName = "lv0ImgWhale"
            whaleImageFrame = CGSize(width: 167.7, height: 155)
            levelDescText = "아직은 칭찬이 어색한 고래"
            nextLavelGuideText = "5번 달성시 다음 레벨!"
        }
        else if level == 1 {
            print("level 1")
            standard = 5
            goal = 10
            exchangePraiseCnt = praiseCnt - standard
            gagePercent = exchangePraiseCnt / standard
            
            levelImageName = "lvIcLv1"
            whaleImageName = "lv1ImgWhale"
            whaleImageFrame = CGSize(width: 203.4, height: 167)
            levelDescText = "칭찬에 흥미가 생긴 고래"
            nextLavelGuideText = "10번 달성시 다음 레벨!"
        }
        else if level == 2 {
            print("level 2")
            standard = 20
            goal = 30
            exchangePraiseCnt = praiseCnt - 10
            gagePercent = exchangePraiseCnt / standard
            
            levelImageName = "lvIcLv2"
            whaleImageName = "lv2ImgWhale"
            whaleImageFrame = CGSize(width: 234.5, height: 230)
            levelDescText = "칭찬에 익숙해진 고래"
            nextLavelGuideText = "30번 달성시 다음 레벨!"
        }
        else if level == 3 {
            print("level 3")
            standard = 20
            goal = 50
            exchangePraiseCnt = praiseCnt - 30
            gagePercent = exchangePraiseCnt / standard
            
            levelImageName = "lvIcLv3"
            whaleImageName = "lv3ImgWhale"
            whaleImageFrame = CGSize(width: 248.7, height: 193)
            levelDescText = "슬슬 리듬타기 시작한 고래"
            nextLavelGuideText = "50번 달성시 다음 레벨!"
        }
        else if level == 4 {
            print("level 4")
            standard = 50
            goal = 100
            exchangePraiseCnt = praiseCnt - standard
            gagePercent = exchangePraiseCnt / standard
            
            levelImageName = "lvIcLv4"
            whaleImageName = "lv4ImgWhale"
            whaleImageFrame = CGSize(width: 251.1, height: 220)
            levelDescText = "신나게 춤 추는 고래"
            nextLavelGuideText = "100번 달성시 다음 레벨!"
        }
        else {
            print("level 5")
            gagePercent = 1
            
            levelImageName = "lvIcLv5"
            whaleImageName = "lv5ImgWhale"
            whaleImageFrame = CGSize(width: 264.8, height: 230)
            levelDescText = "춤신 춤왕 만렙 고래"
            nextLavelGuideText = "\(nickName)님은 이제 칭찬의 신!"
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.countFired += 1
            
            DispatchQueue.main.async {
                self.progressView.progress = min(CGFloat(0.04 * self.countFired), gagePercent)
                
                if self.progressView.progress == 1 {
                    timer.invalidate()
                }
            }
        }
    }
}

extension LevelVC {
    func getWhaleLevelService() {
        LevelService.shared.levelService {
            [self](netwokResult) -> (Void) in
            switch netwokResult {
            case .success(let data):
                if let whaleLevelData = data as? LevelData {
                    whaleName = whaleLevelData.whaleName
                    praiseCnt = CGFloat(whaleLevelData.praiseCount)
                    userLevel = CGFloat(whaleLevelData.userLevel)
                    levelUpNeedCount = whaleLevelData.levelUpNeedCount
                    makeTopView(level: userLevel, praiseCnt: praiseCnt)
                    print(praiseCnt)
                    print(userLevel)
                }
            case .requestErr(_):
                print("requestErr")
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
