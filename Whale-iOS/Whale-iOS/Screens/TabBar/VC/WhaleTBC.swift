//
//  WhaleTBC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit

class WhaleTBC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    // MARK: - 탭바 만드는 함수
    
    func setTabBar() {
        
        self.tabBar.tintColor = UIColor.black
        self.tabBar.frame.size.height = 55
        
        
        // 메인탭
        let WhaleMain = UIStoryboard.init(name: "Main", bundle: nil)
        guard let firstTab = WhaleMain.instantiateViewController(identifier: "MainVC") as? MainVC else {return}
        
        firstTab.tabBarItem.image = UIImage(systemName: "pencil.circle")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        firstTab.tabBarItem.selectedImage = UIImage(systemName: "pencil.circle.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        
        
        // 칭찬카드탭
        let PraiseCardTab = UIStoryboard.init(name: "PraiseCard", bundle: nil)
        guard let secondTab = PraiseCardTab.instantiateViewController(identifier: "PraiseCardVC")
                as? PraiseCardVC  else {
            return
        }
        secondTab.tabBarItem.image = UIImage(systemName: "folder.circle")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        secondTab.tabBarItem.selectedImage = UIImage(systemName: "folder.circle.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        
        
        // 레벨탭
        let WhaleLevel = UIStoryboard.init(name: "Level", bundle: nil)
        guard let thirdTab = WhaleLevel.instantiateViewController(identifier: "LevelVC")
                as? LevelVC  else {
            return
        }
        thirdTab.tabBarItem.image = UIImage(systemName: "tray")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        thirdTab.tabBarItem.selectedImage = UIImage(systemName: "tray.fill")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        
        let tabs =  [firstTab, secondTab, thirdTab]
        
        tabBar.layer.shadowOpacity = 0
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.barTintColor = .white
        self.setViewControllers(tabs, animated: false)
    }
}
