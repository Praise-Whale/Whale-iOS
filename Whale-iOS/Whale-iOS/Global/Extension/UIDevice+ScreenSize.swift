//
//  UIDevice+ScreenSize.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

extension UIDevice {
    public var isiPhoneSE: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 568 && UIScreen.main.bounds.size.width == 320) {
            return true
        }
        return false
    }
    
    public var isiPhoneSE2: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 667 && UIScreen.main.bounds.size.width == 375) {
            return true
        }
        return false
    }
    
    public var isiPhone8Plus: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 736 && UIScreen.main.bounds.size.width == 414) {
            return true
        }
        return false
    }
    
    public var isiPhone12mini: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 812 && UIScreen.main.bounds.size.width == 375) {
            return true
        }
        return false
    }
    
    public var isiPhone12: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 844.0 && UIScreen.main.bounds.size.width == 390.0) {
            return true
        }
        return false
    }
    
    public var isiPhone12proMax: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 926.0 && UIScreen.main.bounds.size.width == 428.0) {
            return true
        }
        return false
    }
    
    public var isiPhone11: Bool {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone && (UIScreen.main.bounds.size.height == 896 && UIScreen.main.bounds.size.width == 414) {
            return true
        }
        return false
    }
}
