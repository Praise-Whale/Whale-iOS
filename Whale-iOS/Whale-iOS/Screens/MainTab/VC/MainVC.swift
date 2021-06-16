//
//  MainVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: - Custom Variables
    
    var nickname: String = "다나고래"
    var praiseId: Int = 0
    
    //MARK: - IBOutlets

    /// 배경
    @IBOutlet var backgroundView: UIView!
    
    /// 우측 상단 설정 버튼
    @IBOutlet var settingBtn: UIButton!
    
    /// 상단 제목 라벨
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleLineView: UIView!
    
    /// 제목 라벨 옆 날짜 박스
    @IBOutlet var dateView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    /// 오늘의 칭찬 박스
    @IBOutlet var contentBoxView: UIView!
    @IBOutlet var contentInnerBoxView: UIView!
    @IBOutlet var boxClipViewCollection: [UIView]!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var didntBtn: UIButton!
    @IBOutlet var didBtn: UIButton!
    
    /// 하단 칭찬 설명
    @IBOutlet var whaleImageView: UIImageView!
    @IBOutlet var messageImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultStyle()
        setNicknameLabel()
        setDateBox()
        updatePraiseId()
        callMainService()
        
        print(UserDefaults.standard.integer(forKey: "PraiseId"))
        print(UserDefaults.standard.string(forKey: "DateLastVisited"))
        
    }
    
    @IBAction func didBtnDidTap(_ sender: Any) {
        let nextStoryboard = UIStoryboard(name: "MainYesPopup", bundle: nil)
        
        guard let dvc = nextStoryboard.instantiateViewController(identifier: "MainYesPopupVC") as? MainYesPopupVC else {
            return
        }
        
        dvc.modalPresentationStyle = .overCurrentContext
        
        self.present(dvc, animated: false, completion: nil)
    }
    

}

extension MainVC {
    
    /// 변하지 않는 것 스타일 설정
    func setDefaultStyle() {
        /// 배경 색
        backgroundView.backgroundColor = .yellow_2
        
        nicknameLabel.font = .NotoSansRegular(size: 16)
        nicknameLabel.textColor = .brown_2
        nicknameLabel.letterSpacing = -0.8
        
        titleLabel.font = .NotoSansBold(size: 22)
        titleLabel.textColor = .brown_2
        titleLabel.letterSpacing = -1.1
        titleLabel.text = "오늘의 칭찬 한 마디"
        
        titleLineView.backgroundColor = .sand_yellow
        titleLineView.makeRounded(cornerRadius: 1)
        
        dateView.makeRounded(cornerRadius: dateView.frame.height/2)
        dateView.backgroundColor = .white
        
        dateLabel.font = .NotoSansRegular(size: 13)
        dateLabel.textColor = .brown_1
        
        contentBoxView.backgroundColor = .white
        contentBoxView.makeRounded(cornerRadius: 15)
        contentBoxView.layer.borderWidth = 2
        contentBoxView.layer.borderColor = UIColor.yellow_3.cgColor
        contentBoxView.dropShadow(color: .yellow_3, offSet: CGSize(width: 1, height: 1), opacity: 0.1, radius: 15)
        
        contentInnerBoxView.backgroundColor = .white
        contentInnerBoxView.makeRounded(cornerRadius: 12)
        contentInnerBoxView.layer.borderWidth = 3
        contentInnerBoxView.layer.borderColor = UIColor.pale_three.cgColor
        
        for view in boxClipViewCollection {
            view.backgroundColor = .dark_cream
            view.makeRounded(cornerRadius: 3.5)
        }
        
        contentLabel.font = .NotoSansBold(size: 20) // 여기 지마켓으로 고치기
        contentLabel.textColor = .brown_1
        contentLabel.textAlignment = .center
        contentLabel.text = "(네트워크 연결을 확인하세요!)"
        
        didntBtn.backgroundColor = .grey_1
        didntBtn.setTitleColor(.black, for: .normal)
        didntBtn.titleLabel?.font = .NotoSansRegular(size: 15)
        didntBtn.titleLabel?.letterSpacing = -0.75
        didntBtn.makeRounded(cornerRadius: didntBtn.frame.height/2)
        didntBtn.setTitle("못했어요..", for: .normal)
        
        didBtn.backgroundColor = .sand_yellow
        didBtn.setTitleColor(.black, for: .normal)
        didBtn.titleLabel?.font = .NotoSansRegular(size: 15)
        didBtn.titleLabel?.letterSpacing = -0.75
        didBtn.makeRounded(cornerRadius: didBtn.frame.height/2)
        didBtn.setTitle("했어요!", for: .normal)
        
        messageLabel.font = .NotoSansRegular(size: 13)
        messageLabel.textColor = .grey_2
        messageLabel.letterSpacing = -0.65
        messageLabel.lineSpacing(lineHeightMultiple: 1)
        messageLabel.text = "와이파이나 모바일 데이터가 연결되어 있는지 확인하세요!\n칭찬할고래 iOS 버전은 지은이와 다은이가 만들었습니다!"
    }
    
    /// 유저디폴트에서 닉네임을 받아와 설정하는 함수
    func setNicknameLabel() {
        
        /// 유저디폴트에 저장된 닉네임이 있으면 닉네임 업데이트
        if let savedNickname = UserDefaults.standard.string(forKey: "nickname") {
            nickname = savedNickname
        }
        
        nicknameLabel.text = "\(nickname)님을 위한"
    }
    
    /// 현재 날짜를 받아와 설정하는 함수
    func setDateBox() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let monthToday = formatter.string(from: Date())
        formatter.dateFormat = "dd"
        let dateToday = formatter.string(from: Date())
        
        dateLabel.text = "\(monthToday)월 \(dateToday)일"
    }
    
    func callMainService() {
        MainService.shared.mainService(id: praiseId) { (networkResult) -> (Void) in
            switch networkResult {
            case .success(let data):
                if let praiseData = data as? MainPraiseSentence {
                    self.contentLabel.text = praiseData.homePraise.todayPraise
                    self.messageLabel.text = praiseData.homePraise.praiseDescription
                }
            case .requestErr(let msg):
                print("[main] request error")
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr:
                print("[main] path error")
            case .serverErr:
                print("[main] server error")
            case .networkFail:
                print("[main] network fail")
            }
        }
    }
    
    func updatePraiseId() {
        /// 오늘 날짜 받아오기
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        let date = formatter.string(from: Date())
        
        if let lastDate = UserDefaults.standard.string(forKey: "DateLastVisited") { /// 유저디폴트에 저장된 마지막 방문 날짜가 있으면
            if lastDate != date { /// 마지막으로 방문한 게 오늘이 아니라면
                /// 아이디를 하나 올려서 다시 저장
                praiseId = UserDefaults.standard.integer(forKey: "PraiseId") + 1
                UserDefaults.standard.setValue(praiseId, forKey: "PraiseId")
                
                /// 최근 방문 날짜를 오늘 날짜로 업데이트
                UserDefaults.standard.setValue(date, forKey: "DateLastVisited")
            } else { /// 마지막으로 방문한 게 오늘이라면
                praiseId = UserDefaults.standard.integer(forKey: "PraiseId")
            }
        } else { /// 없으면
            /// praiseId 새로 부여
            praiseId = 1
            UserDefaults.standard.setValue(praiseId, forKey: "PraiseId")
            
            /// 최근 방문 날짜를 오늘 날짜로 업데이트
            UserDefaults.standard.setValue(date, forKey: "DateLastVisited")
        }
    }
    
}
