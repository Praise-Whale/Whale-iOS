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
    @IBOutlet var nextBtn: UIButton!
    var onboardingArray:[Onboarding] = []
    // 페이징 관련 index 정의 변수
    private var indexOfCellBeforeDragging = 0
    // ScreenSize 가져오는 변수
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingCV.delegate = self
        onboardingCV.dataSource = self
        setOnboardingData()
        setNextBtnProperty()
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
    
    // 하단 버튼 초기 상태 set
    func setNextBtnProperty() {
        nextBtn.setTitle("다음", for: .normal)
        nextBtn.layer.cornerRadius = 25
    }
    
    // Left Paging (오른쪽으로 넘길 때)
    private func indexOfMajorCell() -> Int {
        let itemWidth = screenWidth
        let proportionalOffset = (onboardingCV.contentOffset.x / itemWidth)+0.3
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(onboardingArray.count, index))
        return safeIndex
    }
    
    // Right Paging (왼쪽으로 넘길 때)
    private func indexOfBeforCell() -> Int {
        let itemWidth = screenWidth
        let proportionalOffset = (onboardingCV.contentOffset.x / itemWidth)
        let back_index = Int(floor(proportionalOffset))
        let safeIndex = max(0, min(onboardingArray.count - 1, back_index))
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
        }
    }
}
//MARK: - CollectionView Protocol
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return onboardingArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < 3 {
            let firstOnboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCVCell", for: indexPath) as! OnboardingCVCell
            
            firstOnboardingCell.customLabels(onboardingArray[indexPath.row].firstPraiseText, onboardingArray[indexPath.row].secondPraiseText, onboardingArray[indexPath.row].firstRange1Text, onboardingArray[indexPath.row].secondRange1Text, onboardingArray[indexPath.row].subExpText, descriptionText: onboardingArray[indexPath.row].descriptionText)
            firstOnboardingCell.whaleImageView.image = UIImage(named: onboardingArray[indexPath.row].subImgName)
            firstOnboardingCell.makeAnimation()
            
            return firstOnboardingCell
        }
        else if indexPath.row == 3 {
            let lastOnboardingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastOnboardingCVC", for: indexPath) as! LastOnboardingCVC
            lastOnboardingCell.makeAnimation()
            return lastOnboardingCell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: 751)
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
        }else{
            let indexOfBeforCell = self.indexOfBeforCell()
            
            let indexPath = IndexPath(row: indexOfBeforCell, section: 0)
            onboardingCV.collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    //MARK: - scroll animation이 끝나고 적용되는 함수
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let indexOfMajorCell = self.indexOfMajorCell()
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        // scrollAnimation이 끝나고 pageControl의 현재 페이지를 animation이 끝난 상태값으로 바꿔준다.
        onboardingPageControl.currentPage = Int(round(onboardingCV.contentOffset.x / onboardingCV.frame.size.width))
        
        if indexPath.row == 3 {
            nextBtn.setTitle("시작하기", for: .normal)
        }
        else {
            nextBtn.setTitle("다음", for: .normal)
        }
    }
}
