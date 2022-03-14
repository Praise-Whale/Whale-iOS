//
//  changeNicknamePopupVC.swift
//  Whale-iOS
//
//  Created by Danna Lee on 2021/10/01.
//

import UIKit
import Alamofire

class ChangeNicknamePopupVC: UIViewController {
    
    //MARK: - Custom Variables
    var wordCount = 0
    var nameTyped = ""
    
    //MARK: - IBOutlets
    
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleUnderbarView: UIView!
    
    @IBOutlet var textfieldWrapView: UIView!
    @IBOutlet var nicknameTextfield: UITextField!
    @IBOutlet var alreadyInUseLabel: UILabel!
    @IBOutlet var wordCountLabel: UILabel!
    
    @IBOutlet var modifyBtn: UIButton!
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nicknameTextfield.delegate = self
        nicknameTextfield.becomeFirstResponder()
        
        setStyle()
        setNameTextNotExists()
        alreadyInUseLabel.isHidden = true
    }
    
    //MARK: - IBActions

    @IBAction func closeBtnDidTap(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func nameTextFieldEditChanged(_ sender: Any) {
        
        checkMaxLength(textField: nicknameTextfield, maxLength: 7)
        nameTyped = nicknameTextfield.text ?? ""
        
        if nicknameTextfield.text?.count == 0 {
            wordCount = 0
            setNameTextNotExists()
            alreadyInUseLabel.isHidden = true
        }
        else {
            wordCount = nicknameTextfield.text!.count
//            setNameTextExists()
            nicknameCheckService()
        }
    }
    
    @IBAction func modifyBtnDidTap(_ sender: Any) {
        callPutService()
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
        
        alreadyInUseLabel.textColor
            = UIColor(red: 221/255, green: 155/255, blue: 155/255, alpha: 1)
        alreadyInUseLabel.font = .AppleSDGothicR(size: 13)
        
        wordCountLabel.font = .AppleSDGothicR(size: 13)
        
        modifyBtn.setTitle("변경", for: .normal)
        modifyBtn.setTitleColor(.black, for: .normal)
        modifyBtn.titleLabel?.font = .AppleSDGothicR(size: 15)
        modifyBtn.makeRounded(cornerRadius: modifyBtn.frame.height/2)
    }
    
    func setNameTextExists() {
        alreadyInUseLabel.isHidden = true
        wordCountLabel.text = "\(wordCount)/7"
        
        if let text = wordCountLabel.text {
            let attributedStr = NSMutableAttributedString(string: wordCountLabel.text ?? "")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String),
                                       value: UIFont(name: "AppleSDGothicNeoR00", size: 13.0)!, range: (text as NSString).range(of: "\(wordCount)"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.brown_1, range: (wordCountLabel.text! as NSString).range(of: "\(wordCount)"))
            wordCountLabel.attributedText = attributedStr
        }
        
        modifyBtn.isUserInteractionEnabled = true
        modifyBtn.backgroundColor = .yellow_1
    }
    
    func setNameTextNotExists() {
        alreadyInUseLabel.isHidden = false
        
        wordCountLabel.text = "\(wordCount)/7"
        wordCountLabel.textColor = .grey_2
        
        modifyBtn.isUserInteractionEnabled = false
        modifyBtn.backgroundColor = .grey_1
    }
    
    // 뷰의 다른 곳 탭하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { self.view.endEditing(true)
    }
    
    func keyBoardAction() {
        /// 키보드 디텍션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustInputView(noti: Notification) {
        /// 키보드 활성화/비활성화 분기처리
        if noti.name == UIResponder.keyboardWillShowNotification {
            textfieldWrapView.layer.borderColor = UIColor.yellow_4.cgColor
            
            wordCountLabel.isHidden = false
        } else {
            textfieldWrapView.layer.borderColor = UIColor.grey_1.cgColor
            
            wordCountLabel.isHidden = true
        }
    }
    
    //MARK: - 닉네임 중복체크 Service
    func nicknameCheckService() {
        NicknameCheckService.shared.checkNickname(nickname: nicknameTextfield.text!){ [self]
            (networkResult) -> (Void) in
            switch networkResult {
            case .success:
//                setStateOfBtnNicknameTF(true)
                setNameTextExists()
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
//                    setStateOfBtnNicknameTF(false)
                    setNameTextNotExists()
                }
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
//                setStateOfBtnNicknameTF(false)
                setNameTextNotExists()
            }
        }
    }
    
    func callPutService() {
        NicknameChangeService.shared.nicknameChangeService(newNickname: nameTyped) { [self]
            (networkResult) -> (Void) in
            switch networkResult {
            case .success:
                UserDefaults.standard.setValue(nameTyped, forKey: "nickName")
                self.dismiss(animated: false) {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nicknameChanged"), object: nameTyped)
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
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

extension ChangeNicknamePopupVC: UITextFieldDelegate {
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if(textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
