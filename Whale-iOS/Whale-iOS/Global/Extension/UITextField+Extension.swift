//
//  UITextField+Extension.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

extension UITextField{
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addLeftPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 111, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    func addRightPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
    func addDetailRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addSelectRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addLoginTextFieldLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addChangeNicknameTextFieldLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

