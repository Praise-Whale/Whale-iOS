//
//  UIFont+Extension.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/09.
//

import Foundation
import UIKit

extension UIFont {
    // MARK: NotoSans Font
    class func NotoSansBold(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansCJKkr-Bold", size: size)!
    }
    
    class func NotoSansMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansCJKkr-Medium", size: size)!
    }
    
    class func NotoSansRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSansCJKkr-Regular", size: size)!
    }
    
    class func GmarketSansMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "GmarketSansTTFMedium", size: size)!
    }
}
