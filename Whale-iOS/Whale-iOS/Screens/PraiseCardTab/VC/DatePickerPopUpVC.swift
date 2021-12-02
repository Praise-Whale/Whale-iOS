//
//  DatePickerPopUpVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/12.
//

import UIKit
import SnapKit

protocol selectYearMonthFromPicker {
    func setYearMonth(_ year: Int,_ month: Int)
}

class DatePickerPopUpVC: UIViewController {

    var datePopUpView: praiseDatePickerView = praiseDatePickerView()
    var delegate: selectYearMonthFromPicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpViewLayout()
        notificationAddObserver()
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

//MARK: - Notifiication
extension DatePickerPopUpVC {
    func notificationAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(dismissDatePickerPopUp), name: .dismissDatePickerPopUp, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectDatePickerPopUp), name: .selectDatePickerPopUp, object: nil)
    }
    
    @objc func dismissDatePickerPopUp() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectDatePickerPopUp(notification: Notification) {
        let dict = notification.object as! NSDictionary
        let year = dict["year"] as! Int
        let month = dict["month"] as! Int
        
        self.delegate?.setYearMonth(year, month)
        self.dismiss(animated: true, completion: nil)
    }
}
