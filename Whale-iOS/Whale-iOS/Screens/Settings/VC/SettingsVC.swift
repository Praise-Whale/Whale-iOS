//
//  SettingsVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/08.
//

import UIKit
import MessageUI
import UserNotifications

class SettingsVC: UIViewController {
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleUnderLineView: UIView!
    @IBOutlet var settingView: [UIView]!
    @IBOutlet var settingTitleLabel: [UILabel]!
    @IBOutlet var settingDetailLabel: [UILabel]!
    @IBOutlet var settingUnderView: [UIView]!
    @IBOutlet var changeAlertStateSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        
        userNotificationCenter.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(nicknameChanged(_:)), name: NSNotification.Name("nicknameChanged"), object: nil)
    }
    
    @objc func nicknameChanged(_ noti: Notification) {
        let newNickname = noti.object as! String
        
        self.showToast(message: "닉네임이 변경되었어요!", bottom: 115)
        settingDetailLabel[0].text = newNickname
    }
    
    @IBAction func closeBtnDidTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func changeAlertTimeBtnDidTap(_ sender: Any) {
        self.showToast(message: "아직 준비 중인 기능이에요! 기다려주세요!", bottom: 115)
    }
    
    @IBAction func changeAlertStateSwitch(_ sender: Any) {
        if changeAlertStateSwitch.isOn {
            UserDefaults.standard.setValue(true, forKey: "isAlertOn")
            self.requestAuthorization()
        } else {
            UserDefaults.standard.setValue(false, forKey: "isAlertOn")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["whaleTimeNoti"])
        }
    } 
    
    @IBAction func mailDidTap(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients(["Co.Goraedan@gmail.com"])
            composeVC.setSubject("[칭찬할고래 문의]")
            composeVC.setMessageBody("1. 문의 유형 ( 문의, 버그 제보, 탈퇴하기, 기타) : \n2. 회원 닉네임 (필요시 기입) : \n3. 문의 내용 : \n\n\n문의하신 사항은 칭찬할고래팀이 신속하게 처리하겠습니다. 감사합니다 :)", isHTML: false)
            
            // Present the view controller modally.
            present(composeVC, animated: true) {
                composeVC.showToast(message: "문의 내용을 적어 메일로 보내주세요!", bottom: 115)
            }
            
        } else {
            // Mail앱을 사용할 수 없을 경우
            self.showToast(message: "메일 앱을 설치해주세요", bottom: 115)
        }
    }
    
    @IBAction func privacyPolicyDidTap(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "PrivacyPolicyVC") as? PrivacyPolicyVC else {
            return
        }
        
        dvc.whatToShow = .privacyPolicy
        self.present(dvc, animated: true)
    }
    
    @IBAction func termsOfServiceDidTap(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "PrivacyPolicyVC") as? PrivacyPolicyVC else {
            return
        }
        
        dvc.whatToShow = .termsOfService
        self.present(dvc, animated: true)
    }
}

extension SettingsVC {
    func setStyle() {
        titleLabel.font = .AppleSDGothicB(size: 23)
        
        titleUnderLineView.backgroundColor = .yellow_1
        
        for i in 0..<settingView.count {
            settingView[i].backgroundColor = .clear
            settingTitleLabel[i].font = .AppleSDGothicR(size: 18)
            if i < 2 {
                settingDetailLabel[i].font = .AppleSDGothicR(size: 15)
                settingDetailLabel[i].textColor = .brown_1
            }
            if i != settingView.count - 1 {
                settingUnderView[i].backgroundColor = .grey_1
            }
        }
        
        settingDetailLabel[0].text = UserDefaults.standard.string(forKey: "nickName")
        
        if UserDefaults.standard.bool(forKey: "isAlertOn") {
            print("on")
            changeAlertStateSwitch.setOn(true, animated: false)
        } else {
            print("off")
            changeAlertStateSwitch.setOn(false, animated: false)
        }
    }
    
    func requestAuthorization() {
        let options = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: options) { didAllow, error in
            if let error = error {
                print(error)
            } else {
                if didAllow {
                    self.sendNotification()
                    print("request granted")
                    UserDefaults.standard.setValue(true, forKey: "isAlertOn")
                    DispatchQueue.main.async {
                        self.showToast(message: "앞으로 오전 9:00 에 칭찬 알림을 보내드릴게요!", bottom: 115)
                    }
                } else {
                    print("request denied")
                    UserDefaults.standard.setValue(false, forKey: "isAlertOn")
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["whaleTimeNoti"])
                    DispatchQueue.main.async {
                        self.changeAlertStateSwitch.setOn(false, animated: false)
                        self.showToast(message: "설정에서 알림 권한을 확인하세요!", bottom: 115)
                    }
                }
            }
        }
    }
    
    func sendNotification() {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "오늘의 칭찬이 도착했어요!"
        notiContent.body = "지금 바로 오늘의 칭찬을 확인하고, 실천해보세요!"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "whaleTimeNoti", content: notiContent, trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
}

extension SettingsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .sent:
            // 메일 발송 성공 ( 인터넷이 안되는 경우도 sent처리되고, 인터넷이 연결되면 메일이 발송됨. )
            self.showToast(message: "소중한 의견 감사합니다! :)", bottom: 115)
        case .saved:
            // 메일 임시 저장
            self.showToast(message: "메일이 임시 저장 되었어요", bottom: 115)
        case .cancelled:
            // 메일 작성 취소
            self.showToast(message: "메일 작성이 취소 되었어요", bottom: 115)
        case .failed:
            // 메일 발송 실패 (오류 발생)
            self.showToast(message: "메일 발송에 실패했어요 :(", bottom: 115)
        @unknown default:
            self.showToast(message: "메일 발송에 실패했어요 :(", bottom: 115)
        }
        dismiss(animated: true)
    }
}

extension SettingsVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .badge, .sound, .banner])
    }
}
