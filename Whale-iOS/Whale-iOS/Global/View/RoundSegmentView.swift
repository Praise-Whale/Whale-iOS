//
//  RoundSegmentView.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/05.
//

import UIKit

@IBDesignable
class RoundSegmentView: UIView {
    
    var buttons = [UIButton]()
    var selector: UIView!
    
    // width, height에 따른 동적 뷰를 만들기 위한 프로퍼티
    var frameWidth: Int = 0 {
        didSet {
            updateView()
        }
    }
    var frameHeight: Int = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        buttons.removeAll()
        
        //$0 -> (view) in view
        subviews.forEach({ $0.removeFromSuperview()})
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frameWidth / buttonTitles.count
        let selectorHeight = frameHeight - 8
        
        selector = UIView(frame: CGRect(x: 4, y: 4, width: selectorWidth - 4, height: selectorHeight))
        selector.layer.cornerRadius = CGFloat(selectorHeight / 2)
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        
        // put buttons in stackView
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = frame.height / 2
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    if buttonIndex == 0 {
                        self.selector.frame.origin.x = 4
                        NotificationCenter.default.post(name: Notification.Name.pushedCardDrawer, object: nil)
                    }
                    else {
                        self.selector.frame.origin.x = selectorStartPosition
                        NotificationCenter.default.post(name: Notification.Name.pushedPraiseLank, object: nil)
                    }
                })
                
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}
