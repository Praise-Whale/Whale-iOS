//
//  DatePickerPopUpVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/12.
//

import UIKit
import SnapKit

class DatePickerPopUpVC: UIViewController {

    var datePopUpView: praiseDatePickerView = praiseDatePickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpViewLayout()
    }
    
    func setPopUpViewLayout() {
        self.view.addSubview(datePopUpView)
        datePopUpView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(291)
            make.height.equalTo(376)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }
    }
}
