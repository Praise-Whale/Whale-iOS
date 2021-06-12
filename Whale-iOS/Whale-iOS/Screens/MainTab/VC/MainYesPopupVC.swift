//
//  MainYesPopupVC.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/10.
//

import UIKit

class MainYesPopupVC: UIViewController {
    
    //MARK: - Custom Variables
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleUnderView: UIView!
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var recentTitleLabel: UILabel!
    @IBOutlet var recentCollectionView: UICollectionView!
    @IBOutlet var leftBlurImageView: UIImageView!
    @IBOutlet var rightBlurImageView: UIImageView!
    
    @IBOutlet var submitBtn: UIButton!
    
    //MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultStyle()
        setNameTextNotExists()

    }
    
    //MARK: - IBActions

}

extension MainYesPopupVC {
    func setDefaultStyle() {
        popupView.backgroundColor = .white
        popupView.layer.borderWidth = 3
        popupView.layer.borderColor = UIColor.yellow_3.cgColor
        popupView.makeRounded(cornerRadius: 15)
        
        titleLabel.text = "누구에게 칭찬했나요?"
        titleLabel.textColor = .brown_2
        titleLabel.font = .NotoSansRegular(size: 18)
        titleLabel.letterSpacing = -0.9
        
        titleUnderView.backgroundColor = .sand_yellow
        titleUnderView.makeRounded(cornerRadius: 1)
        
        nameTextField.addLeftPadding(width: 13)
//        nameTextField.addRightPadding(width: 5)
        nameTextField.font = .NotoSansRegular(size: 13)
        nameTextField.layer.borderColor = UIColor.yellow_3.cgColor
        nameTextField.layer.borderWidth = 1
        nameTextField.placeholder = "이름을 실명으로 입력해주세요."
        nameTextField.makeRounded(cornerRadius: 12)
        nameTextField.clearButtonMode = .always
        nameTextField.autocorrectionType = .no
        
        recentTitleLabel.textColor = .grey_2
        recentTitleLabel.font = .NotoSansRegular(size: 14)
        recentTitleLabel.text = "최근 칭찬한 사람"
        recentTitleLabel.letterSpacing = -0.7
        
        submitBtn.makeRounded(cornerRadius: submitBtn.frame.height/2)
        submitBtn.setTitle("확인", for: .normal)
        submitBtn.setTitleColor(.black, for: .normal)
    }
    
    func setNameTextExists() {
        submitBtn.backgroundColor = .sand_yellow
    }
    
    func setNameTextNotExists() {
        submitBtn.backgroundColor = .grey_1
    }
}
