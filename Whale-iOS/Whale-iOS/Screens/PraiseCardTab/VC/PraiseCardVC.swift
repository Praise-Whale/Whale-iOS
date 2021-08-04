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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func makeTopView() {
        self.view.addSubview(nicknameLabel)
        nicknameLabel.text = "\(textInputMode)님의"
        nicknameLabel.textColor = .brown_2
        nicknameLabel.font = UIFont(name: <#T##String#>, size: <#T##CGFloat#>)
        nicknameLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(self.view).offset(41)
            make
            make.center.equalTo(self.view)
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
