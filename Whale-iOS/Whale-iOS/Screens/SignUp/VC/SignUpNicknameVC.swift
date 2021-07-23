//
//  SignUpNicknameVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/11.
//

import UIKit
import Alamofire

class SignUpNicknameVC: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var cancelNicknameTextingBtn: UIButton!
    @IBOutlet var existingNicknameAlertLabel: CustomLabel!
    @IBOutlet var editingCountLabel: UILabel!
    @IBOutlet var editLimitAlertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setInitialComponents()
        makeTextFieldLeftPadding()
        setNextBtnLayout(25)
        textFieldEditingCheck()
    }
    
    func setDelegate() {
        nicknameTextField.delegate = self
        nicknameTextField.becomeFirstResponder()
    }
    
    //MARK: - set component's Initial Status
    func setInitialComponents() {
        nicknameTextField.background = UIImage(named: "nickname_box_nickname")
        existingNicknameAlertLabel.isHidden = true
    }

    //MARK: - add NicknameTextField placeHolder (Left padding)
    func makeTextFieldLeftPadding() {
        nicknameTextField.addLeftPadding(13)
    }

    //MARK: - nextBtn 레이아웃 설정
    func setNextBtnLayout(_ cornerRadius: CGFloat) {
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = .grey_1
        nextBtn.layer.cornerRadius = cornerRadius
    }
    
    func setStateOfBtnNicknameTF(_ status: Bool) {
        if status == true {
            nicknameTextField.background = UIImage(named: "nickname_box_nickname")
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = .sand_yellow
            existingNicknameAlertLabel.isHidden = true
        }
        else {
            nicknameTextField.background = UIImage(named: "nickname_box_name_error")
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .grey_1
            existingNicknameAlertLabel.isHidden = false
        }
    }
    
    //MARK: - 닉네임 중복체크 Service
    func nicknameCheckService() {
        NicknameCheckService.shared.checkNickname(nickname: nicknameTextField.text!){ [self]
            (networkResult) -> (Void) in
            switch networkResult {
            case .success:
                setStateOfBtnNicknameTF(true)
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
                setStateOfBtnNicknameTF(false)
            }
        }
    }
    
    //MARK: - nicknameTextField의 취소버튼을 눌렀을 때
    @IBAction func touchUpToNicknameTextFieldClear(_ sender: UIButton) {
        // emailTextField의 텍스트 전부를 지우고, 취소버튼을 사라지게 한다
        nicknameTextField.text?.removeAll()
        cancelNicknameTextingBtn.isHidden = true
        nicknameTextField.background = UIImage(named: "nickname_box_nickname")
        nextBtn.isEnabled = false
        nextBtn.backgroundColor = .grey_1
        existingNicknameAlertLabel.isHidden = true
    }
    
    
    @IBAction func touchUpNextBtn(_ sender: UIButton) {
    }
    
    @IBAction func touchUpBackSwipe(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpNicknameVC: UITextFieldDelegate {
    
    //MARK: - TextField 입력 체크하는 함수
    private func textFieldEditingCheck() {
        
        /// 텍스트가 입력중일 때 동작
        nicknameTextField.addTarget(self, action: #selector(nicknameTextIsEditing(_:)), for: .editingChanged)
        
        /// 텍스트 입력 끝났을 때 동작
        nicknameTextField.addTarget(self, action: #selector(nicknameTextIsEndEditing(_:)), for: .editingDidEnd)
    }
    
    
    //MARK: - nicknameTextField가 입력중일 때
    @objc func nicknameTextIsEditing(_ TextLabel: UITextField) {
        
        /// emailTextfield에 텍스트가 입력되면
        if nicknameTextField.text!.count > 0 {

            //취소버튼을 보이게 한다
            cancelNicknameTextingBtn.isHidden = false
            nextBtn.isEnabled = true
            nicknameCheckService()
        }
    }
    
    //MARK: - nicknameTextField 입력 끝났을 때
    @objc func nicknameTextIsEndEditing(_ TextLabel: UITextField) {
        
        /// emailTextfield에 텍스트가 없으면
        if nicknameTextField.text!.count == 0 {
            
            //취소버튼을 숨긴다
            cancelNicknameTextingBtn.isHidden = true
        }
    }
    
}
