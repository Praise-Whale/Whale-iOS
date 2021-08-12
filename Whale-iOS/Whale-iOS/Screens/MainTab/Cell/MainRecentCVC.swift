//
//  MainRecentCVC.swift
//  Whale-iOS
//
//  Created by Danna Lee on 2021/08/11.
//

import UIKit

class MainRecentCVC: UICollectionViewCell {
    static let identifier = "MainRecentCVC"
    
    @IBOutlet weak var nameView: UIView!{
        didSet{
            nameView.backgroundColor = .yellow_2
            nameView.makeRounded(cornerRadius: 16)
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.font = .AppleSDGothicR(size: 13)
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MainRecentCVC", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
