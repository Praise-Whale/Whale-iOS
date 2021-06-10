//
//  SignUpNicknameVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/11.
//

import UIKit

class SignUpNicknameVC: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nextBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldBackgroud()
        makeTextFieldLeftPadding()
        setNextBtnLayout(25)
        // Do any additional setup after loading the view.
    }
    
    // set textField background Image
    func setTextFieldBackgroud() {
        nicknameTextField.background = UIImage(named: "nickname_box_nickname")
        nicknameTextField.layer.borderWidth = 0
    }

    func makeTextFieldLeftPadding() {
        nicknameTextField.addLeftPadding(13)
    }

    func setNextBtnLayout(_ cornerRadius: CGFloat) {
        nextBtn.isEnabled = false
        nextBtn.layer.cornerRadius = cornerRadius
    }
    
    @IBAction func touchUpBackSwipe(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
