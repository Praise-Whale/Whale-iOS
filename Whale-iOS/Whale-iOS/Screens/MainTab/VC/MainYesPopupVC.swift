//
//  MainYesPopupVC.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/10.
//

import UIKit

class MainYesPopupVC: UIViewController {
    
    //MARK: - Custom Variables
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleUnderView: UIView!
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var countLabel: UILabel!
    
    @IBOutlet var recentTitleLabel: UILabel!
    @IBOutlet var recentCollectionView: UICollectionView!
    @IBOutlet var leftBlurImageView: UIImageView!
    @IBOutlet var rightBlurImageView: UIImageView!
    
    @IBOutlet var submitBtn: UIButton!
    
    //MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - IBActions

}

extension MainYesPopupVC {
    func setDefaultStyle() {
        
    }
}
