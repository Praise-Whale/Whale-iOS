//
//  OnboardingCVCell.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/10.
//

import UIKit

class OnboardingCVCell: UICollectionViewCell {//

    @IBOutlet var firstPraiseLabel: CustomLabel!
    @IBOutlet var secondPraiseLabel: UILabel!
    @IBOutlet var subExplanationLabel: UILabel!
    @IBOutlet var descLabel: CustomLabel!
    @IBOutlet var whaleImageView: UIImageView!
    
    
    //MARK: - 라벨 AttributeFont 설정
    func customLabels(_ firstPraiseText: String, _ secondPraiseText: String, _ firstRegularRange1: String, _ secondRegularRange1: String, _ subExplainText: String, descriptionText: String) {
        /// set firstBigLabel fonts
        let firstPraiseAttributedString = NSMutableAttributedString(string: firstPraiseText, attributes: [
                                                                        .font: UIFont.AppleSDGothicB(size: 26),
                                                            .foregroundColor: UIColor.brown_2,
                                                            .kern: -1.3 ])
        firstPraiseAttributedString.addAttribute(.font, value: UIFont.AppleSDGothicR(size: 26), range: (firstPraiseText as NSString).range(of: firstRegularRange1))
        firstPraiseAttributedString.addAttribute(.foregroundColor, value: UIColor.brown_2, range: (firstPraiseText as NSString).range(of: firstRegularRange1))
        firstPraiseLabel.attributedText = firstPraiseAttributedString
        
        
        
        
        /// set secondBigLabel fonts
        let secondPraiseAttributedString = NSMutableAttributedString(string: secondPraiseText, attributes: [
                                                            .font: UIFont.AppleSDGothicB(size: 26),
                                                            .foregroundColor: UIColor.brown_2,
                                                            .kern: -1.3 ])
        secondPraiseAttributedString.addAttribute(.font, value: UIFont.AppleSDGothicR(size: 26), range: (secondPraiseText as NSString).range(of: secondRegularRange1))
        secondPraiseAttributedString.addAttribute(.foregroundColor, value: UIColor.brown_2, range: (secondPraiseText as NSString).range(of: secondRegularRange1))
        secondPraiseLabel.attributedText = secondPraiseAttributedString
        
        /// set subExplanationLabel fonts
        let subExpAttributedString = NSMutableAttributedString(string: subExplainText, attributes: [
                                                            .font: UIFont.AppleSDGothicR(size: 16),
                                                            .foregroundColor: UIColor.brown_2,
                                                                .kern: -0.8])
        subExplanationLabel.attributedText = subExpAttributedString
        subExplanationLabel.sizeToFit()
        descLabel.text = descriptionText
        descLabel.sizeToFit()
    }
    
    func makeAnimation() {
        
        whaleImageView.frame = CGRect(x: 0, y: 253, width: self.whaleImageView.frame.width, height: self.whaleImageView.frame.height)
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse] , animations: {
            self.whaleImageView.frame = CGRect(x: 10, y: 253, width: self.whaleImageView.frame.width, height: self.whaleImageView.frame.height)
        })
    }
}
