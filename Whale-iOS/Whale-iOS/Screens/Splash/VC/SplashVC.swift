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
    var userNickname = UserDefaults.standard.string(forKey: "nickName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDeviceSize()
        makeLottieAnimation(animationName: "whale")
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
        goToNextScene()
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
    
    func goToNextScene() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            if (UserDefaults.standard.bool(forKey: "isFirstlaunch") == false) && (UserDefaults.standard.bool(forKey: "isSignedUp") == false) {
                print("첫 로드 : 온보딩")
                UserDefaults.standard.set(
                    true,forKey: "isFirstlaunch")
                goToOnboarding()
            }
            else if (UserDefaults.standard.bool(forKey: "isFirstlaunch") == true && UserDefaults.standard.bool(forKey: "isSignedUp") == false) {
                print("첫 로드 : 회원가입")
                goToSignUp()
            }
            else {
                print("첫 로드 : 메인뷰")
                loginService(userNickname ?? "")
            }
        }
    }
}

extension SplashVC {
    func loginService(_ nickName: String) {
        LoginService.shared.loginService(nickName: nickName) { [self]
            (networkResult) -> (Void) in
            switch networkResult {
            case .success(let data):
                if let loginData = data as? LoginData {
                    UserDefaults.standard.setValue(nickName, forKey: "nickName")
                    UserDefaults.standard.setValue(loginData.accessToken, forKey: "accessToken")
                    UserDefaults.standard.setValue(loginData.refreshToken, forKey: "refreshToken")
                    print("refreshToken", loginData.refreshToken)
                    print("accessToken", loginData.accessToken)
                    goToMainView()
                }
            case .requestErr(let msg):
                if let message = msg as? String {
                    print(message)
                }
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
}

extension SplashVC {
    func goToOnboarding() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "OnboardingVC") as? OnboardingVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goToMainView() {
        print("main")
        let storyBoard: UIStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "WhaleTBC") as? WhaleTBC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goToSignUp() {
        print("signUp")
        let storyBoard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "SignUpVC") as? SignUpVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
