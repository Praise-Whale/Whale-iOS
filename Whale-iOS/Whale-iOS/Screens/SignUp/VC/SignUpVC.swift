//
//  SignUpVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/11.
//

import UIKit
import SafariServices

class SignUpVC: UIViewController {

    @IBOutlet var firstTitleLabel: UILabel!
    @IBOutlet var agreeAllBtn: UIButton!
    @IBOutlet var personalAgreeBtn: UIButton!
    @IBOutlet var serviceAgreeBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    var praiseWhaleText  = "칭찬할고래의"
    var praiseWhaleTextRange  = "칭찬할고래"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNextBtnLayout(25)
        setLabelAttributesText()
    }
    
    func setNextBtnLayout(_ cornerRadius: CGFloat) {
        nextBtn.isEnabled = false
        nextBtn.layer.cornerRadius = cornerRadius
    }
    
    func setLabelAttributesText() {
        let firstPraiseAttributedString = NSMutableAttributedString(string: praiseWhaleText, attributes: [
                                                                        .font: UIFont.AppleSDGothicR(size: 22),
                                                            .foregroundColor: UIColor.brown_2,
                                                            .kern: -1.1 ])
        firstPraiseAttributedString.addAttribute(.font, value: UIFont.AppleSDGothicB(size: 22), range: (praiseWhaleText as NSString).range(of: praiseWhaleTextRange))
        firstTitleLabel.attributedText = firstPraiseAttributedString
    }
    
    @IBAction func touchUpAgreeAllBtn(_ sender: UIButton) {
        if agreeAllBtn.isSelected == false {
            agreeAllBtn.isSelected = true
            personalAgreeBtn.isSelected = true
            serviceAgreeBtn.isSelected = true
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = .yellow_1
        }
        else {
            agreeAllBtn.isSelected = false
            personalAgreeBtn.isSelected = false
            serviceAgreeBtn.isSelected = false
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .grey_1
        }
    }
    
    @IBAction func touchUpPersonalAgreeBtn(_ sender: UIButton) {
        if personalAgreeBtn.isSelected == false {
            personalAgreeBtn.isSelected = true
            if serviceAgreeBtn.isSelected == true {
                agreeAllBtn.isSelected = true
                nextBtn.isEnabled = true
                nextBtn.backgroundColor = .yellow_1
            }
        }
        else {
            agreeAllBtn.isSelected = false
            personalAgreeBtn.isSelected = false
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .grey_1
        }
    }
    
    @IBAction func touchUpServiceAgreeBtn(_ sender: UIButton) {
        if serviceAgreeBtn.isSelected == false {
            serviceAgreeBtn.isSelected = true
            if personalAgreeBtn.isSelected == true {
                agreeAllBtn.isSelected = true
                nextBtn.isEnabled = true
                nextBtn.backgroundColor = .yellow_1
            }
        }
        else {
            agreeAllBtn.isSelected = false
            serviceAgreeBtn.isSelected = false
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = .grey_1
        }
    }
    
    @IBAction func touchUpPersonalTermBtn(_ sender: UIButton) {
        let personalTermURL = NSURL(string: "https://www.notion.so/4ae478f551f249d097a6e46cffad6d07")
        let personalTermSafariView: SFSafariViewController = SFSafariViewController(url: personalTermURL! as URL)
        self.present(personalTermSafariView, animated: true, completion: nil)
    }
    
    @IBAction func touchUpServiceTermBtn(_ sender: UIButton) {
        let serviceTermURL = NSURL(string: "https://www.notion.so/8ced90e384b1417ab6e24ce9c8436ab8")
        let serviceTermSafariView: SFSafariViewController = SFSafariViewController(url: serviceTermURL! as URL)
        self.present(serviceTermSafariView, animated: true, completion: nil)
    }

    @IBAction func touchUpNextPageBtn(_ sender: UIButton) {
//        self.present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }
}
