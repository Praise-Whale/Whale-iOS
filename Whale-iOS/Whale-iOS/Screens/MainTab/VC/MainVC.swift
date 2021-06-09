//
//  MainVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

class MainVC: UIViewController {
    
    //MARK: - Custom Variables
    
    
    //MARK: - IBOutlets

    @IBOutlet var backgroundView: UIView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}

extension MainVC {
    
    func setDefaultStyle() {
        backgroundView.backgroundColor = .yellow_2
        
    }
    
}
