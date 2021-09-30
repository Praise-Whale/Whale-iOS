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
        titleLabel.font = .AppleSDGothicB(size: 23)
        
        titleUnderLineView.backgroundColor = .yellow_1
        
        for i in 0..<settingView.count {
            settingView[i].backgroundColor = .clear
            settingTitleLabel[i].font = .AppleSDGothicR(size: 18)
            if i < 2 {
                settingDetailLabel[i].font = .AppleSDGothicR(size: 15)
                settingDetailLabel[i].textColor = .brown_1
            }
            if i != settingView.count - 1 {
                settingUnderView[i].backgroundColor = .grey_1
            }
        }
        
        settingDetailLabel[0].text = UserDefaults.standard.string(forKey: "nickName")
    }
}
