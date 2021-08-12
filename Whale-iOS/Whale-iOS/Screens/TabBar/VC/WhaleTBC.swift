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
        
        // 탭바 스타일 설정
        tabBar.tintColor = .brown_1
        tabBar.frame.size.height = 65
        tabBar.layer.shadowOpacity = 0
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.barTintColor = .white
        
        // 메인탭
        let WhaleMain = UIStoryboard.init(name: "Main", bundle: nil)
        guard let firstTab = WhaleMain.instantiateViewController(identifier: "MainVC") as? MainVC else {return}
        
        firstTab.tabBarItem.image = UIImage(named: "naviIcCompliment")
        firstTab.tabBarItem.selectedImage = UIImage(named: "naviIcComplimentSelected")
        firstTab.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0)
        
        
        // 칭찬카드탭
        let PraiseCardTab = UIStoryboard.init(name: "PraiseCard", bundle: nil)
        guard let secondTab = PraiseCardTab.instantiateViewController(identifier: "PraiseCardVC")
                as? PraiseCardVC  else {
            return
        }
        secondTab.tabBarItem.image = UIImage(named: "naviIcCard")
        secondTab.tabBarItem.selectedImage = UIImage(named: "naviIcCardSelected")
        secondTab.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0)
        
        
        // 레벨탭
        let WhaleLevel = UIStoryboard.init(name: "Level", bundle: nil)
        guard let thirdTab = WhaleLevel.instantiateViewController(identifier: "LevelVC")
                as? LevelVC  else {
            return
        }
        thirdTab.tabBarItem.image = UIImage(named: "naviIcWhale")
        thirdTab.tabBarItem.selectedImage = UIImage(named: "naviIcWhaleSelected")
        thirdTab.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0)
        
        
        // 탭 구성
        let tabs =  [firstTab, secondTab, thirdTab]
        
        // VC에 루트로 설정
        self.setViewControllers(tabs, animated: false)
    }
}
