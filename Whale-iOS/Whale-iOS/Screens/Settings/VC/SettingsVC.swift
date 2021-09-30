//
//  SettingsVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleUnderLineView: UIView!
    @IBOutlet var settingView: [UIView]!
    @IBOutlet var settingTitleLabel: [UILabel]!
    @IBOutlet var settingDetailLabel: [UILabel]!
    @IBOutlet var settingUnderView: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
    }
    
    @IBAction func closeBtnDidTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}

extension SettingsVC {
    func setStyle() {
        
    }
}
