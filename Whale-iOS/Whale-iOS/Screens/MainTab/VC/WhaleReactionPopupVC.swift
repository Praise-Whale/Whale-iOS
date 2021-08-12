//
//  MainNoPopup.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/10.
//

import UIKit

class WhaleReactionPopupVC: UIViewController {
    
    //MARK: - Custom variables
    enum WhaleState {
        case good, sad, wannaDance, shout, levelOne, levelTwo, levelThree, levelFour, levelFive
    }
    
    var whale: WhaleState = .good
    
    
    //MARK: - IBOutlets

    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var whaleImageView: UIImageView!
    @IBOutlet weak var mainMessageLabel: UILabel!
    @IBOutlet weak var subMessageLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!
    
    
    //MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaults()
    }
    
    
    //MARK: - IBActions
    
    @IBAction func closeBtnDidTap(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func okBtnDidTap(_ sender: Any) {
        if whale == .sad || whale == .wannaDance || whale == .shout {
            let savedWhale = UserDefaults.standard.integer(forKey: "accumulatedNo")
            UserDefaults.standard.setValue(savedWhale < 2 ? savedWhale + 1 : 2, forKey: "accumulatedNo")
            
            
        }
        
        self.dismiss(animated: false, completion: nil)
    }
}

//MARK: - Styles & Functions
extension WhaleReactionPopupVC {
    func setDefaults() {
        popupView.backgroundColor = .white
        popupView.layer.borderWidth = 3
        popupView.layer.borderColor = UIColor.yellow_3.cgColor
        popupView.makeRounded(cornerRadius: 15)
        
        mainMessageLabel.font = .AppleSDGothicB(size: 21)
        mainMessageLabel.textColor = .brown_2
        
        subMessageLabel.font = .AppleSDGothicR(size: 17)
        subMessageLabel.textColor = .brown_2
        
        okButton.backgroundColor = UIColor(red: 255/255, green: 212/255, blue: 100/255, alpha: 1)
        okButton.makeRounded(cornerRadius: okButton.frame.height/2)
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(.black, for: .normal)
        
        switch whale {
        case .good:
            setWhaleGood()
        case .sad:
            setWhaleSad()
        case .wannaDance:
            setWhaleDance()
        case .shout:
            setWhaleShout()
        case .levelOne:
            setWhaleLevelOne()
        case .levelTwo:
            setWhaleLevelTwo()
        case .levelThree:
            setWhaleLevelThree()
        case .levelFour:
            setWhaleLevelFour()
        case .levelFive:
            setWhaleLelelFive()
        }
    }
    
    func setWhaleGood() {
        whaleImageView.image = UIImage(named: "yes6ImgWhale")
        mainMessageLabel.text = "참 잘했고래!"
        subMessageLabel.text = "내일도 칭찬해요!"
        closeBtn.isHidden = true
    }
    
    func setWhaleSad() {
        whaleImageView.image = UIImage(named: "no1ImgWhale")
        mainMessageLabel.text = "아쉽고래!"
        subMessageLabel.text = "내일은 꼭 칭찬해요!"
    }
    
    func setWhaleDance() {
        whaleImageView.image = UIImage(named: "no2ImgWhale")
        mainMessageLabel.text = "내일은 꼭 칭찬해요!"
        subMessageLabel.text = "칭찬으로 저를 춤 추게 해주세요!"
    }
    
    func setWhaleShout() {
        whaleImageView.image = UIImage(named: "no3ImgWhale")
        mainMessageLabel.text = "고래고래 소리지를고래!"
        subMessageLabel.text = "칭찬하는 습관을 가져봐요!"
    }
    
    func setWhaleLevelOne() {
        whaleImageView.image = UIImage(named: "lvPopupImgWhale")
        mainMessageLabel.text = "레벨업했고래!"
        subMessageLabel.text = "칭찬에 흥미가 생겼군요!"
        closeBtn.isHidden = true
    }
    
    func setWhaleLevelTwo() {
        whaleImageView.image = UIImage(named: "lvPopupImgWhale")
        mainMessageLabel.text = "레벨업했고래!"
        subMessageLabel.text = "칭찬에 익숙해지고 있네요!"
        closeBtn.isHidden = true
    }
    
    func setWhaleLevelThree() {
        whaleImageView.image = UIImage(named: "lvPopupImgWhale")
        mainMessageLabel.text = "레벨업했고래!"
        subMessageLabel.text = "둠칫 두둠칫 점점 신이나요!"
        closeBtn.isHidden = true
    }
    
    func setWhaleLevelFour() {
        whaleImageView.image = UIImage(named: "lvPopupImgWhale")
        mainMessageLabel.text = "레벨업했고래!"
        subMessageLabel.text = "저 춤 출래요, 말리지 마세요!"
        closeBtn.isHidden = true
    }
    
    func setWhaleLelelFive() {
        whaleImageView.image = UIImage(named: "lvPopupImgWhale")
        mainMessageLabel.text = "이제 만렙 고래!"
        subMessageLabel.text = "친구에게도 칭찬할고래를 알려줘요!"
        closeBtn.isHidden = true
    }
}

