//
//  MainYesPopupVC.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/10.
//

import UIKit

class MainYesPopupVC: UIViewController {
    
    //MARK: - Custom Variables
    
    var wordCount: Int = 0
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleUnderView: UIView!
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var nameView: UIView!
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
        
        nameTextField.delegate = self
        
        keyBoardAction()
        setDefaultStyle()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    
    @IBAction func closeBtnDidTap(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func nameTextFieldEditChanged(_ sender: Any) {
        
        checkMaxLength(textField: nameTextField, maxLength: 6)
        
        if nameTextField.text?.count == 0 {
            wordCount = 0
            setNameTextNotExists()
        }
        else {
            wordCount = nameTextField.text!.count
            setNameTextExists()
        }
    }
    
}

extension MainYesPopupVC {
    func setDefaultStyle() {
        popupView.backgroundColor = .white
        popupView.layer.borderWidth = 3
        popupView.layer.borderColor = UIColor.yellow_3.cgColor
        popupView.makeRounded(cornerRadius: 15)
        
        titleLabel.text = "누구에게 칭찬했나요?"
        titleLabel.textColor = .brown_2
        titleLabel.font = .AppleSDGothicR(size: 18)
        titleLabel.letterSpacing = -0.9
        
        titleUnderView.backgroundColor = .sand_yellow
        titleUnderView.makeRounded(cornerRadius: 1)
        
        nameView.layer.borderWidth = 1
        nameView.backgroundColor = .white
        nameView.makeRounded(cornerRadius: 12)
        
        nameTextField.font = .AppleSDGothicR(size: 13)
        nameTextField.placeholder = "이름을 실명으로 입력해주세요."
        nameTextField.clearButtonMode = .always
        nameTextField.autocorrectionType = .no
        
        countLabel.font = .AppleSDGothicR(size: 13)
        countLabel.text = "\(wordCount)/6"
        countLabel.textColor = .grey_2
        
        recentTitleLabel.textColor = .grey_2
        recentTitleLabel.font = .AppleSDGothicR(size: 14)
        recentTitleLabel.text = "최근 칭찬한 사람"
        recentTitleLabel.letterSpacing = -0.7
        
        recentCollectionView.backgroundColor = .white
        
        submitBtn.makeRounded(cornerRadius: submitBtn.frame.height/2)
        submitBtn.setTitle("확인", for: .normal)
        submitBtn.setTitleColor(.black, for: .normal)
    }
    
    func setNameTextExists() {
        countLabel.text = "\(wordCount)/6"
        
        if let text = countLabel.text {
            let attributedStr = NSMutableAttributedString(string: countLabel.text ?? "")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String),
                                       value: UIFont(name: "AppleSDGothicNeoR00", size: 13.0)!, range: (text as NSString).range(of: "\(wordCount)"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.brown_1, range: (countLabel.text! as NSString).range(of: "\(wordCount)"))
            countLabel.attributedText = attributedStr
        }
        
        submitBtn.backgroundColor = .sand_yellow
    }
    
    func setNameTextNotExists() {
        countLabel.text = "\(wordCount)/6"
        countLabel.textColor = .grey_2
        
        submitBtn.backgroundColor = .grey_1
    }
    
    func keyBoardAction() {
        /// 키보드 디텍션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustInputView(noti: Notification) {
        /// 키보드 활성화/비활성화 분기처리
        if noti.name == UIResponder.keyboardWillShowNotification {
            nameView.layer.borderColor = UIColor.yellow_4.cgColor
            
            countLabel.isHidden = false
        } else {
            nameView.layer.borderColor = UIColor.grey_1.cgColor
            
            countLabel.isHidden = true
        }
    }
}

//MARK: - UITextFieldDelegate

extension MainYesPopupVC: UITextFieldDelegate {
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if(textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
