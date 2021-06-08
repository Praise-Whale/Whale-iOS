//
//  UIButton+Extension.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

extension UIButton {
    @IBInspectable
    // 버튼 내 글자 자간 설정
    var letterSpacing: CGFloat {
        set {
            let attributedString: NSMutableAttributedString
            if let currentAttrString = attributedTitle(for: .normal) {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: self.title(for: .normal) ?? "")
                setTitle(.none, for: .normal)
            }
            
            attributedString.addAttribute(NSAttributedString.Key.kern, value: newValue, range: NSRange(location: 0, length: attributedString.length))
            setAttributedTitle(attributedString, for: .normal)
        }
        get {
            if let currentLetterSpace = attributedTitle(for: .normal)?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
}
