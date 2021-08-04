//
//  PraiseCardVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit
import SnapKit

class PraiseCardVC: UIViewController {

    var nicknameLabel = UILabel()
    var praiseCardLabel = UILabel()
    var yellowBoxView = UIView()
    @IBOutlet var roundSegmentView: RoundSegmentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        setSuperViewLayout()
        makeTopView()
    }
    
    //추후에 오토레이아웃 적용시 사용할 함수
    func setAutoLayout() {
        //screenSize에 따라 달라질 동적 width, height
        roundSegmentView.frameWidth = 225
        roundSegmentView.frameHeight = 51
    }
    
    //MARK: - set superView layout
    func setSuperViewLayout() {
        self.view.backgroundColor = .yellow_2
        self.roundSegmentView.backgroundColor = .clear
    }
    
    //MARK: - 칭찬카드 상단부 View 생성(UILabel, RoundSegmentControl)
    func makeTopView() {
        //create: nicknameLabel 생성 -> '~님의'
        self.view.addSubview(nicknameLabel)
        nicknameLabel.text = "황지은님의"
        nicknameLabel.textColor = .brown_2
        nicknameLabel.font = UIFont(name: "AppleSDGothicNeoR00", size: 16)
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
        praiseCardLabel.font = UIFont(name: "AppleSDGothicNeoB00", size: 23)
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
        
        roundSegmentView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(yellowBoxView.snp.bottom).offset(34)
            make.height.equalTo(51)
            make.width.equalTo(225)
            make.centerX.equalTo(yellowBoxView)
        }
    }
}
    
    
