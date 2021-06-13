//
//  LastOnboardingCVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/11.
//

import UIKit

class LastOnboardingCVC: UICollectionViewCell {
    
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var whaleImageView: UIImageView!
    
    override func awakeFromNib() {
        customLabels()
    }
    
    //MARK: - 라벨 AttributeFont 설정
    func customLabels() {
        /// set firstBigLabel fonts
        let firstAttributedString = NSMutableAttributedString(string: firstLabel.text!, attributes: [
                                                            .font: UIFont(name: "NotoSansCJKkr-Bold", size: 23)!,
                                                            .foregroundColor: UIColor.brown_2,
                                                            .kern: -1.15 ])
        firstAttributedString.addAttribute(.font, value: UIFont(name: "NotoSansCJKkr-Regular", size: 23)!, range: (firstLabel.text! as NSString).range(of: "와 함께"))
        firstAttributedString.addAttribute(.foregroundColor, value: UIColor.brown_2, range: (firstLabel.text! as NSString).range(of: "와 함께"))
        
        firstLabel.attributedText = firstAttributedString
        firstLabel.sizeToFit()
        
        /// set secondBigLabel fonts
        let secondAttributedString = NSMutableAttributedString(string: secondLabel.text!, attributes: [
                                                            .font: UIFont(name: "NotoSansCJKkr-Bold", size: 23)!,
                                                            .foregroundColor: UIColor.brown_2,
                                                            .kern: -1.15 ])
        secondAttributedString.addAttribute(.font, value: UIFont(name: "NotoSansCJKkr-Regular", size: 23)!, range: (secondLabel.text! as NSString).range(of: "매일"))
        secondAttributedString.addAttribute(.foregroundColor, value: UIColor.brown_2, range: (secondLabel.text! as NSString).range(of: "매일"))
        secondLabel.attributedText = secondAttributedString
        secondLabel.sizeToFit()
    }
    
    func makeAnimation() {
        
        whaleImageView.frame = CGRect(x: 0, y: 83, width: self.whaleImageView.frame.width, height: self.whaleImageView.frame.height)
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.whaleImageView.frame = CGRect(x: 10, y: 83, width: self.whaleImageView.frame.width, height: self.whaleImageView.frame.height)
        })
    }
}
