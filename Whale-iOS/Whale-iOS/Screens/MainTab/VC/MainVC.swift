//
//  MainVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

enum PraiseState {
    case before, success, fail
}

class MainVC: UIViewController {
    
    //MARK: - Custom Variables
    
    var nickname: String = "다나고래"
    var praiseId: Int = 0
    
    var todayPraiseState: PraiseState = .fail
    
    var todayMessage: String = ""
    
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
    @IBOutlet var beforeStackView: UIStackView!
    @IBOutlet var afterPraiseView: UIView!
    @IBOutlet weak var afterPraiseLabel: UILabel!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        adjustState()
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
        contentLabel.text = "(네트워크 연결을 확인하세요)"
        
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
        
        afterPraiseView.makeRounded(cornerRadius: 12)
        
        messageImageView.image = UIImage(named: "mainBoxTip")
        messageLabel.font = .NotoSansRegular(size: 15)
        
        messageLabel.font = .NotoSansRegular(size: 13)
        messageLabel.textColor = .grey_2
        messageLabel.letterSpacing = -0.65
        messageLabel.lineSpacing(lineHeightMultiple: 1)
        messageLabel.textAlignment = .center
        messageLabel.text = "칭찬할고래 iOS는 지은이와 다은이가 만들었습니다!"
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
                    
                    if self.todayPraiseState == .before {
                        self.messageLabel.text = praiseData.homePraise.praiseDescription
                    }
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
    
    func adjustState() {
        switch todayPraiseState {
        case .before:
            setBeforePraise()
        case .success:
           setSuccessPraise()
        case .fail:
           setFailPraise()
        }
    }
    
    func setBeforePraise() {
        beforeStackView.isHidden = false
        afterPraiseView.isHidden = true
        whaleImageView.image = UIImage(named: "mainImgWhale")
    }
    
    func setSuccessPraise() {
        beforeStackView.isHidden = true
        afterPraiseView.isHidden = false
        whaleImageView.image = UIImage(named: "mainImgWhaleSuccess")
        
        let attributedString = NSMutableAttributedString(string: "오늘의 칭찬 완료")
        attributedString.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.NotoSansBold(size: 17), range: ("오늘의 칭찬 완료" as NSString).range(of: "완료"))
        attributedString.addAttribute(.foregroundColor, value: UIColor(red: 76/255, green: 136/255, blue: 242/255, alpha: 1), range: ("오늘의 칭찬 완료" as NSString).range(of: "완료"))
        
        afterPraiseView.backgroundColor = UIColor(red: 76/255, green: 136/255, blue: 242/255, alpha: 0.13)
        afterPraiseLabel.attributedText = attributedString
        messageLabel.text = "완료한 칭찬은 카드서랍에서 확인할 수 있어요!"
    }
    
    func setFailPraise() {
        beforeStackView.isHidden = true
        afterPraiseView.isHidden = false
        whaleImageView.image = UIImage(named: "mainImgWhaleFail")
        
        let attributedString = NSMutableAttributedString(string: "오늘의 칭찬 미완료")
        attributedString.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: UIFont.NotoSansBold(size: 17), range: ("오늘의 칭찬 미완료" as NSString).range(of: "미완료"))
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: ("오늘의 칭찬 미완료" as NSString).range(of: "미완료"))
        
        afterPraiseView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        afterPraiseLabel.attributedText = attributedString
        messageLabel.text = "내일은 꼭 칭찬해서\n고래를 춤 추게 해요!"
    }
}
