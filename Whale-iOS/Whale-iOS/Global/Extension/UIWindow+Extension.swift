//
//  UIWindow+Extension.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
