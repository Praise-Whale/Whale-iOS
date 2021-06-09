//
//  MainVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: - Custom Variables
    
    
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
        setText()
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
    }
    
    func setText() {
        nicknameLabel.text = "다나고래님을 위한"
        dateLabel.text = "12월 22일"
        contentLabel.text = "고래 아요가 다은이라서\n참 좋아"
        messageLabel.text = "항상 내 편인 친구에게 ㅇㅇㅇ 고마움을 표현해보세요 :)ㅇㅇ 한 줄 더 되겠군요 히히히히히"
    }
    
}
