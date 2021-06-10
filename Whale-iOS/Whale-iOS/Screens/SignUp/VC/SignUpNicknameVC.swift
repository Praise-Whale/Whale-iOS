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
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldBackgroud()
        makeTextFieldLeftPadding()
        setNextBtnLayout(25)
    }
    
    //MARK: - set textField background Image
    func setTextFieldBackgroud() {
        nicknameTextField.background = UIImage(named: "nickname_box_nickname")
        nicknameTextField.layer.borderWidth = 0
    }

    //MARK: - add NicknameTextField placeHolder (Left padding)
    func makeTextFieldLeftPadding() {
        nicknameTextField.addLeftPadding(13)
    }

    //MARK: - nextBtn 레이아웃 설정
    func setNextBtnLayout(_ cornerRadius: CGFloat) {
        nextBtn.isEnabled = true
        nextBtn.layer.cornerRadius = cornerRadius
    }
    
    //MARK: - 닉네임 중복체크 Service
    func nicknameCheckService() {
        NicknameCheckService.shared.checkNickname(nickname: nicknameTextField.text!){
            (networkResult) -> (Void) in
            switch networkResult {
            case .success(let msg):
                print(msg)
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
    
    @IBAction func touchUpNextBtn(_ sender: UIButton) {
        nicknameCheckService()
    }
    
    @IBAction func touchUpBackSwipe(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
