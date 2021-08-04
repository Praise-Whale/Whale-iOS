//
//  SplashVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/07/24.
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    
    @IBOutlet var lottieView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDeviceSize()
        makeLottieAnimation(animationName: "whale")
        print(UIScreen.main.bounds.size)
    }
    
    //MARK: - LottieAnimtaion 적용
    func makeLottieAnimation(animationName:String){
        
        let lottieAnimationView = AnimationView()
        lottieAnimationView.animation = Animation.named(animationName)
        lottieAnimationView.frame = lottieView.frame
        lottieAnimationView.center = self.lottieView.center
        lottieAnimationView.contentMode = .scaleAspectFill
        lottieAnimationView.loopMode = .playOnce
        lottieAnimationView.play()
        lottieView.addSubview(lottieAnimationView)
    }
    
    //MARK: - lottieView와 view간 오토레이아웃 변경할때 사용하는 함수
    func changeAutoLayout(_ top: CGFloat, _ leading: CGFloat, _ trailing: CGFloat, _ bottom: CGFloat) {
        lottieView.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        lottieView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
        lottieView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        lottieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
    }
    
    
    //MARK: - 기기별 frame size 정의
    func setDeviceSize() {
        if UIDevice.current.isiPhoneSE2 {
            print("isiPhoneSE2")
            changeAutoLayout(-44, 0, 0, 0)
            lottieView.frame.size = CGSize(width: 375, height: 667)
        }
        else if UIDevice.current.isiPhone12mini {
            print("isiPhone12mini")
            changeAutoLayout(-44, 0, 0, 0)
            lottieView.frame.size = CGSize(width: 375, height: 812)
        }
        else if UIDevice.current.isiPhone12 {
            print("isiPhone12Pro")
            lottieView.frame.size = CGSize(width: 390, height: 844)
            changeAutoLayout(-44, 0, 0, 0)
        }
        else if UIDevice.current.isiPhone8Plus {
            print("isiPhone8Plus")
            changeAutoLayout(-44, 0, 0, 0)
            lottieView.frame.size = CGSize(width: 414, height: 736)
        }
        else if UIDevice.current.isiPhone11 {
            print("isiPhone11")
            lottieView.frame.size = CGSize(width: 414, height: 896)
            changeAutoLayout(-44, 0, 0, 0)
            self.lottieView.layoutIfNeeded()
        }
        else if UIDevice.current.isiPhone12proMax {
            print("isiPhone12proMax")
            changeAutoLayout(0, 0, 20, 0)
            self.view.layoutIfNeeded()
            self.lottieView.layoutIfNeeded()
        }
        else {
            print("there's no correct device")
        }
    }
}
