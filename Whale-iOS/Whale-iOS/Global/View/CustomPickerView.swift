//
//  CustomPickerView.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/11.
//

import UIKit

@IBDesignable
class CustomPickerView: UIPickerView
{
    @IBInspectable var selectorColor: UIColor?
    
    override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: 1)
        view.layer.backgroundColor = UIColor.white.cgColor
    }
    
    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        self.sendSubviewToBack(subview)
        subview.layer.backgroundColor = UIColor.yellow_1.cgColor
    }
}
