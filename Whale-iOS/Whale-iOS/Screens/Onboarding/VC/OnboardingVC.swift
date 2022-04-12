//
//  OnboardingVC.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/06/10.
//

import UIKit

class OnboardingVC: UIViewController {
    
    @IBOutlet var onboardingCV: UICollectionView!
    @IBOutlet var onboardingPageControl: UIPageControl!
    @IBOutlet var nextBtn: UIButton! {
        didSet {
            nextBtn.setTitle("다음", for: .normal)
            nextBtn.layer.cornerRadius = 25
        }
    }
    var onboardingArray:[Onboarding] = []
    // 페이징 관련 index 정의 변수
    private var indexOfCellBeforeDragging = 0
    // ScreenSize 가져오는 변수
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingCV.delegate = self
        onboardingCV.dataSource = self
        setOnboardingData()
        
        userNotificationCenter.delegate = self
        requestAuthorization()
    }
    
    // Onboarding Data 구성
    func setOnboardingData() {
        onboardingArray.append(contentsOf:
                                [Onboarding(firstPraiseText: "하루에 한 번씩", firstRange1Text: "", secondPraiseText: "칭찬해요", secondRange1Text: "해요", subExpText: "매일 매일 다른 칭찬 미션을 \n하나씩 보내드릴게요!", descriptionText: "원하는 시간에 리마인드 알림도 받을 수 있어요:)", subImgName: "onboarding_1_img_whale"),
                                 Onboarding(firstPraiseText: "나만의 고래를", firstRange1Text: "를", secondPraiseText: "춤 추게 해요", secondRange1Text: "해요", subExpText: "칭찬을 할 때 마다 \n나의 고래가 춤을 춰요!", descriptionText: "칭찬 횟수에 따라 고래의 레벨이 높아져요:)", subImgName: "onboarding_2_img_whale"),
                                 Onboarding(firstPraiseText: "칭찬을 모아보고", firstRange1Text: "칭찬을", secondPraiseText: "칭찬 랭킹을 확인해요", secondRange1Text: "칭찬 랭킹", subExpText: "내가 한 칭찬을 모아보고 \n칭찬 대상에 대한 랭킹도 확인해요!", descriptionText: "누구에게 언제 어떤 칭찬을 했는지 한 번에 확인해요:)", subImgName: "onboarding_3_img_whale")
                                ])
        onboardingPageControl.numberOfPages = onboardingArray.count + 1
    }
    
    // Left Paging (오른쪽으로 넘길 때)
    private func indexOfMajorCell() -> Int {
        let itemWidth = screenWidth
        let proportionalOffset = (onboardingCV.contentOffset.x / itemWidth)
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(onboardingArray.count, index))
        if safeIndex == 3 {
            nextBtn.setTitle("시작하기", for: .normal)
        }
        return safeIndex
    }
    
    // Right Paging (왼쪽으로 넘길 때)
    private func indexOfBeforCell() -> Int {
        let itemWidth = screenWidth
        let proportionalOffset = (onboardingCV.contentOffset.x / itemWidth)
        let back_index = Int(floor(proportionalOffset))
        let safeIndex = max(0, min(onboardingArray.count - 1, back_index))
        
        nextBtn.setTitle("다음", for: .normal)
        return safeIndex
    }
    
    // TouchUpNextBtn (nextBtn 눌렀을 때 액션)
    @IBAction func touchUpToNextPageBtn(_ sender: Any) {
        let indexPath = IndexPath(row: onboardingPageControl.currentPage + 1, section: 0)
        
        if indexPath.row == 4 {
            // 회원가입 뷰로 이동
            let signUpSB: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
            if let signUpVC = signUpSB.instantiateViewController(identifier: "SignUpVC") as? SignUpVC {
                self.navigationController?.pushViewController(signUpVC, animated: true)
            }
        }
        else {
            // 페이지 이동
            onboardingCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if indexPath.item == 3 {
                nextBtn.setTitle("시작하기", for: .normal)
            }
        }
    }
    
    private func requestAuthorization() {
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
                }
            }
        }
    }
    
    private func sendNotification() {
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
//MARK: - CollectionView Protocol
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item < 3 {
            let firstOnboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCVCell", for: indexPath) as! OnboardingCVCell
            firstOnboardingCell.customLabels(onboardingArray[indexPath.row].firstPraiseText, onboardingArray[indexPath.row].secondPraiseText, onboardingArray[indexPath.row].firstRange1Text, onboardingArray[indexPath.row].secondRange1Text, onboardingArray[indexPath.row].subExpText, descriptionText: onboardingArray[indexPath.row].descriptionText)
            firstOnboardingCell.whaleImageView.image = UIImage(named: onboardingArray[indexPath.row].subImgName)
            firstOnboardingCell.makeAnimation()
            firstOnboardingCell.setDeviceSizeLayout()
            return firstOnboardingCell
        }
        else if indexPath.item == 3 {
            let lastOnboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastOnboardingCVC", for: indexPath) as! LastOnboardingCVC
            lastOnboardingCell.makeAnimation()
            return lastOnboardingCell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        let height =  self.onboardingCV.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - collectionView Horizontal Scrolling Magnetic Effect 적용
extension OnboardingVC : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        if velocity.x > 0 {
            let indexOfMajorCell = self.indexOfMajorCell()
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            onboardingCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else{
            let indexOfBeforCell = self.indexOfBeforCell()
            
            let indexPath = IndexPath(row: indexOfBeforCell, section: 0)
            onboardingCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    //MARK: - scroll animation이 끝나고 적용되는 함수
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // scrollAnimation이 끝나고 pageControl의 현재 페이지를 animation이 끝난 상태값으로 바꿔준다.
        onboardingPageControl.currentPage = Int(round(onboardingCV.contentOffset.x / onboardingCV.frame.size.width))
    }
}

extension OnboardingVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .badge, .sound, .banner])
    }
}
