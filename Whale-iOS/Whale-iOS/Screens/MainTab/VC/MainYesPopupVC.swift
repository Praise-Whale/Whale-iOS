//
//  MainYesPopupVC.swift
//  Whale-iOS
//
//  Created by DANNA LEE on 2021/06/10.
//

import UIKit

class MainYesPopupVC: UIViewController {
    
    //MARK: - Custom Variables
    
    var wordCount: Int = 0
    
    
    //MARK: - IBOutlets
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var popupView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var titleUnderView: UIView!
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var nameView: UIView!
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
        
        nameTextField.delegate = self
        recentCollectionView.dataSource = self
        recentCollectionView.delegate = self
        
        keyBoardAction()
        setDefaultStyle()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    
    @IBAction func closeBtnDidTap(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func submitBtnDidTap(_ sender: Any) {
        let nextStoryboard = UIStoryboard(name: "WhaleReactionPopup", bundle: nil)
        
        guard let dvc = nextStoryboard.instantiateViewController(identifier: "WhaleReactionPopupVC") as? WhaleReactionPopupVC else {
            return
        }
        
        dvc.whale = .good
        dvc.modalPresentationStyle = .overCurrentContext
        
        self.present(dvc, animated: false)
        //TODO: 이거 dismiss로 바꾸고 메인에서 정상 완료 됐다는 notification 받아서 팝업 띄우기
    }
    
    @IBAction func nameTextFieldEditChanged(_ sender: Any) {
        
        checkMaxLength(textField: nameTextField, maxLength: 6)
        
        if nameTextField.text?.count == 0 {
            wordCount = 0
            setNameTextNotExists()
        }
        else {
            wordCount = nameTextField.text!.count
            setNameTextExists()
        }
    }
    
}

extension MainYesPopupVC {
    func setDefaultStyle() {
        popupView.backgroundColor = .white
        popupView.layer.borderWidth = 3
        popupView.layer.borderColor = UIColor.yellow_3.cgColor
        popupView.makeRounded(cornerRadius: 15)
        
        titleLabel.text = "누구에게 칭찬했나요?"
        let attributedText = NSMutableAttributedString(string: "누구에게 칭찬했나요?", attributes: [
            .font: UIFont(name: "AppleSDGothicNeoR00", size: 20.0)!,
            .foregroundColor: UIColor.brown_2,
            .kern: -1.0
        ])
        attributedText.addAttribute(.font, value: UIFont(name: "AppleSDGothicNeoB00", size: 20.0)!, range: NSRange(location: 5, length: 2))
        titleLabel.attributedText = attributedText
        
        titleUnderView.backgroundColor = .sand_yellow
        titleUnderView.makeRounded(cornerRadius: 1)
        
        nameView.backgroundColor = .white
        nameView.makeRounded(cornerRadius: 12)
        nameView.layer.borderWidth = 1
        nameView.layer.borderColor = UIColor.grey_1.cgColor
        
        nameTextField.font = .AppleSDGothicR(size: 13)
        nameTextField.placeholder = "이름을 실명으로 입력해주세요."
        nameTextField.clearButtonMode = .always
        nameTextField.autocorrectionType = .no
        
        countLabel.font = .AppleSDGothicR(size: 13)
        countLabel.text = "\(wordCount)/6"
        countLabel.textColor = .grey_2
        
        recentTitleLabel.textColor = .grey_2
        recentTitleLabel.font = .AppleSDGothicR(size: 14)
        recentTitleLabel.text = "최근 칭찬한 사람"
        recentTitleLabel.letterSpacing = -0.7
        
        recentCollectionView.backgroundColor = .white
        leftBlurImageView.alpha = 0
        
        submitBtn.makeRounded(cornerRadius: submitBtn.frame.height/2)
        submitBtn.setTitle("확인", for: .normal)
        submitBtn.setTitleColor(.black, for: .normal)
    }
    
    func setNameTextExists() {
        countLabel.text = "\(wordCount)/6"
        
        if let text = countLabel.text {
            let attributedStr = NSMutableAttributedString(string: countLabel.text ?? "")
            attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String),
                                       value: UIFont(name: "AppleSDGothicNeoR00", size: 13.0)!, range: (text as NSString).range(of: "\(wordCount)"))
            attributedStr.addAttribute(.foregroundColor, value: UIColor.brown_1, range: (countLabel.text! as NSString).range(of: "\(wordCount)"))
            countLabel.attributedText = attributedStr
        }
        
        submitBtn.backgroundColor = .sand_yellow
    }
    
    func setNameTextNotExists() {
        countLabel.text = "\(wordCount)/6"
        countLabel.textColor = .grey_2
        
        submitBtn.backgroundColor = .grey_1
    }
    
    func keyBoardAction() {
        /// 키보드 디텍션
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustInputView(noti: Notification) {
        /// 키보드 활성화/비활성화 분기처리
        if noti.name == UIResponder.keyboardWillShowNotification {
            nameView.layer.borderColor = UIColor.yellow_4.cgColor
            
            countLabel.isHidden = false
        } else {
            nameView.layer.borderColor = UIColor.grey_1.cgColor
            
            countLabel.isHidden = true
        }
    }
}

//MARK: - UICollectionViewDataSource

extension MainYesPopupVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainRecentCVC", for: indexPath) as? MainRecentCVC
        else {
            return UICollectionViewCell()
        }
        
        cell.nameLabel.text = "이건임시야!"
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainYesPopupVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = "이건 임시야!"
        label.sizeToFit()
        let cellSize = label.frame.width + 15
        
        return CGSize(width: cellSize, height: 32)
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= 10 {
            leftBlurImageView.alpha = CGFloat( scrollView.contentOffset.x / 10)
        } else {
            leftBlurImageView.alpha = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nameTextField.text = "이건임시야!"
        wordCount = 6
        setNameTextExists()
        nameTextField.resignFirstResponder()
    }
}

//MARK: - UITextFieldDelegate

extension MainYesPopupVC: UITextFieldDelegate {
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if(textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
}
