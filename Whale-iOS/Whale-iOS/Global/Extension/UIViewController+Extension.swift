//
//  UIViewController+Extension.swift
//  Whale-iOS
//
//  Created by Danna Lee on 2021/09/30.
//

import UIKit
extension UIViewController{
    func showToast(message: String, bottom: CGFloat = 165) {
        let width_variable: CGFloat = 33
        let toastLabel = UILabel(frame: CGRect(x: width_variable, y: self.view.frame.size.height-bottom, width: view.frame.size.width-2*width_variable, height: 44))
        // 뷰가 위치할 위치를 지정해준다. 여기서는 아래로부터 100만큼 떨어져있고, 너비는 양쪽에 10만큼 여백을 가지며, 높이는 35로
        toastLabel.backgroundColor = UIColor(red: 255/255, green: 212/255, blue: 100/255, alpha: 0.53)
        toastLabel.textColor = UIColor.brown_1
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.AppleSDGothicR(size: 13)
        toastLabel.lineSpacing(lineSpacing: -0.5)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 22
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { (isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
