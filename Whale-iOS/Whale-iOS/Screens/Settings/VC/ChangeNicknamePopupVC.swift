//
//  changeNicknamePopupVC.swift
//  Whale-iOS
//
//  Created by Danna Lee on 2021/10/01.
//

import UIKit

class ChangeNicknamePopupVC: UIViewController {
    
    //MARK: - Custom Variables
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleUnderbarView: UIView!
    
    @IBOutlet var textfieldWrapView: UIView!
    @IBOutlet var nicknameTextfield: UITextField!
    @IBOutlet var wordCountLabel: UILabel!
    
    @IBOutlet var modifyBtn: UIButton!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
    }
    
    //MARK: - IBActions

    @IBAction func closeBtnDidTap(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
}

extension ChangeNicknamePopupVC {
    //MARK: - Custom Methods
    
    func setStyle() {
        popupView.makeRounded(cornerRadius: 15)
        popupView.layer.borderColor = UIColor.yellow_3.cgColor
        popupView.layer.borderWidth = 3
        
        titleLabel.textColor = .brown_2
        titleLabel.font = .AppleSDGothicR(size: 20)
        
        titleUnderbarView.backgroundColor = .yellow_1
        
        textfieldWrapView.layer.borderWidth = 1
        textfieldWrapView.layer.borderColor = UIColor.yellow_4.cgColor
        textfieldWrapView.makeRounded(cornerRadius: 12)
        
        nicknameTextfield.placeholder = UserDefaults.standard.string(forKey: "nickName")
        nicknameTextfield.font = .AppleSDGothicR(size: 13)
        
        wordCountLabel.font = .AppleSDGothicR(size: 13)
        
        modifyBtn.setTitle("변경", for: .normal)
        modifyBtn.titleLabel?.font = .AppleSDGothicR(size: 15)
        modifyBtn.makeRounded(cornerRadius: modifyBtn.frame.height/2)
    }
}
