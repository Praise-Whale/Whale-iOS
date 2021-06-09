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

        // Do any additional setup after loading the view.
    }
    


}

extension MainVC {
    
    func setDefaultStyle() {
        backgroundView.backgroundColor = .yellow_2
        
    }
    
}
