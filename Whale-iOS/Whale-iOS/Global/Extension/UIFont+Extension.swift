//
//  UIFont+Extension.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/09.
//

import Foundation
import UIKit

extension UIFont {
    // MARK: AppleSDGothic Font
    class func AppleSDGothicB(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeoB00", size: size)!
    }
    
    class func AppleSDGothicM(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeoM00", size: size)!
    }
    
    class func AppleSDGothicR(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeoR00", size: size)!
    }
    
    class func AppleSDGothicSB(size: CGFloat) -> UIFont {
        return UIFont(name: "AppleSDGothicNeoSB00", size: size)!
    }
    
    // MARK: GmarketSans Font
    class func GmarketSansBold(size: CGFloat) -> UIFont {
        return UIFont(name: "GmarketSansTTFBold", size: size)!
    }
    
    // MARK: Roboto Font
    class func RobotoB(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size)!
    }
}
