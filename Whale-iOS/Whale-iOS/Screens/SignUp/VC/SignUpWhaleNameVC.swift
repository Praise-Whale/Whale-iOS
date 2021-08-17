//
//  SignUpWhaleNameVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/17.
//

import UIKit
import Alamofire

class SignUpWhaleNameVC: UIViewController {
    
    @IBOutlet var firstTitleLabel: UILabel!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var cancelNicknameTextingBtn: UIButton!
    @IBOutlet var editingCountLabel: UILabel!
    @IBOutlet var editLimitAlertLabel: UILabel!
    let maxLength = 7
    var userNickName: String = "" {
        didSet {
            print(userNickName)
        }
    }
    var praiseWhaleText  = ""
    var praiseWhaleTextRange  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setInitialComponents()
        setLabelAttributesText()
        makeTextFieldLeftPadding()
        setNextBtnLayout(25)
        textFieldEditingCheck()
    }
    
    func setDelegate() {
        nicknameTextField.delegate = self
        nicknameTextField.becomeFirstResponder()
    }
    
    func setLabelAttributesText() {
        let firstPraiseAttributedString = NSMutableAttributedString(string: praiseWhaleText, attributes: [
                                                                        .font: UIFont.AppleSDGothicR(size: 22),
                                                                        .foregroundColor: UIColor.brown_2,
                                                                        .kern: -1.1 ])
        firstPraiseAttributedString.addAttribute(.font, value: UIFont.AppleSDGothicB(size: 22), range: (praiseWhaleText as NSString).range(of: praiseWhaleTextRange))
        firstTitleLabel.attributedText = firstPraiseAttributedString
    }
    
    //MARK: - set component's Initial Status
    func setInitialComponents() {
        praiseWhaleText = "\(userNickName)님과 함께할"
        praiseWhaleTextRange = "\(userNickName)"
        nicknameTextField.background = UIImage(named: "nickname_box_nickname")
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
            nextBtn.backgroundColor = .yellow_1
            editingCountLabel.isHidden = false
            editLimitAlertLabel.isHidden = false
        }
        else {
            nicknameTextField.background = UIImage(named: "nickname_box_name_error")
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .grey_1
            editingCountLabel.isHidden = true
            editLimitAlertLabel.isHidden = true
        }
    }
    
    // 뷰의 다른 곳 탭하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { self.view.endEditing(true)
    }
    
    //MARK: - 회원가입 Service
    func signUpService() {
        NicknameCheckService.shared.checkNickname(nickname: nicknameTextField.text!){ [self]
            (networkResult) -> (Void) in
            switch networkResult {
            case .success:
                setStateOfBtnNicknameTF(true)
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                    setStateOfBtnNicknameTF(false)
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
        editingCountLabel.isHidden = false
        editLimitAlertLabel.isHidden = false
    }
    
    @IBAction func touchUpCompleteBtn(_ sender: UIButton) {
        signUpService(nickName: userNickName, whaleName: nicknameTextField.text ?? "", deviceToken: "iOS Token..")
    }
    
    @IBAction func touchUpBackSwipe(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpWhaleNameVC: UITextFieldDelegate {
    
    //MARK: - TextField 입력 체크하는 함수
    private func textFieldEditingCheck() {
        
        /// 텍스트가 입력중일 때 동작
        nicknameTextField.addTarget(self, action: #selector(nicknameTextIsEditing(_:)), for: .editingChanged)
        
        /// 텍스트 입력 끝났을 때 동작
        nicknameTextField.addTarget(self, action: #selector(nicknameTextIsEndEditing(_:)), for: .editingDidEnd)
    }
    
    
    //MARK: - nicknameTextField가 입력중일 때
    @objc func nicknameTextIsEditing(_ TextLabel: UITextField) {
        if let text = nicknameTextField.text {
            /// emailTextfield에 텍스트가 입력되면
            
            if nicknameTextField.text!.count == maxLength {
                //취소버튼을 보이게 한다
                cancelNicknameTextingBtn.isHidden = false
                nextBtn.backgroundColor = .yellow_1
                nextBtn.isEnabled = true
                editingCountLabel.textColor = .brown_1
                
                let index = text.index(text.startIndex, offsetBy: maxLength)
                let newString = text[text.startIndex..<index]
                nicknameTextField.text = String(newString)
            }
            
            else if nicknameTextField.text!.count > maxLength + 1 {
                // 8글자 넘어가면 자동으로 키보드 내려감
                nicknameTextField.resignFirstResponder()
            }
            
            if nicknameTextField.text!.count > 0 {
                
                //취소버튼을 보이게 한다
                cancelNicknameTextingBtn.isHidden = false
                nextBtn.backgroundColor = .yellow_1
                nextBtn.isEnabled = true
                
                if text.count > 7 {
                    editingCountLabel.text = "7"
                }
                else {
                    editingCountLabel.text = "\(nicknameTextField.text!.count)"
                }
                editingCountLabel.textColor = .brown_1
            }
            
            else{
                //취소버튼을 숨긴다
                cancelNicknameTextingBtn.isHidden = true
                nextBtn.backgroundColor = .grey_1
                nextBtn.isEnabled = false
                editingCountLabel.text = "\(nicknameTextField.text!.count)"
                editingCountLabel.textColor = .grey_2
            }
        }
    }
    
    
    //MARK: - nicknameTextField 입력 끝났을 때
    @objc func nicknameTextIsEndEditing(_ TextLabel: UITextField) {
        
        /// emailTextfield에 텍스트가 없으면
        if nicknameTextField.text!.count == 0 {
            
            //취소버튼을 숨긴다
            cancelNicknameTextingBtn.isHidden = true
            nextBtn.backgroundColor = .grey_1
            nextBtn.isEnabled = false
            editingCountLabel.text = "0"
            editingCountLabel.textColor = .grey_2
        }
    }
    
    @objc func handleTapTextField(_ sender: UITapGestureRecognizer) {
        self.nicknameTextField.resignFirstResponder()
    }
    
    // 키보드 return 눌렀을 때 Action
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nicknameTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = nicknameTextField.text else {return false}
        
        // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        return true
    }
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 50
            }
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension SignUpWhaleNameVC {
    func signUpService(nickName: String, whaleName: String, deviceToken: String) {
        SignUpService.shared.signUpService(nickName: nickName, whaleName: whaleName, deviceToken: deviceToken) { [self]
            (networkResult) -> (Void) in
            switch networkResult {
            case .success(let data):
                if let loginData = data as? LoginData {
                    UserDefaults.standard.setValue(nickName, forKey: "nickName")
                    UserDefaults.standard.setValue(loginData.accessToken, forKey: "accessToken")
                    UserDefaults.standard.setValue(loginData.refreshToken, forKey: "refreshToken")
                    print("refreshToken", loginData.refreshToken)
                    print("accessToken", loginData.accessToken)
                    goToMainView()
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

extension SignUpWhaleNameVC {
    func goToMainView() {
        print("main")
        let storyBoard: UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "WhaleTBC") as? WhaleTBC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
