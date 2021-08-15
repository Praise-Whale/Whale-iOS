//
//  PraiseCardCVCell.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/15.
//

import UIKit
import SnapKit

class PraiseCardCVCell: UICollectionViewCell {
    
    var toPraisePersonLabel = UILabel()
    var yellowlineView = UIView()
    var praisedDateYellowView = UIView()
    var praisedDateLabel = UILabel()
    var innerYellowBoxImageView = UIImageView()
    var praiseContentLabel = UILabel()
    
    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    var toPraisePersonText: String? { didSet { bind() } }
    var praisedDateText: String? {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let convertDate = dateFormatter.date(from: String(praisedDateText!.split(separator: "T")[0]))
            let yymmddFormatter = DateFormatter()
            yymmddFormatter.dateFormat = "MM월 dd일"
            let convertYearStr = yymmddFormatter.string(from: convertDate ?? Date())
            praisedDateText = convertYearStr
            bind()
        }
    }
    var praiseContentText: String? { didSet { bind() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentViewUI()
        addSubviews()
        setUIComponentProperty()
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setContentViewUI() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.yellow_3.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    private func addSubviews() {
        self.contentView.addSubview(toPraisePersonLabel)
        self.contentView.addSubview(yellowlineView)
        self.contentView.addSubview(praisedDateYellowView)
        self.contentView.addSubview(praisedDateLabel)
        self.contentView.addSubview(innerYellowBoxImageView)
        self.contentView.addSubview(praiseContentLabel)
    }
    
    private func configure() {
        
        toPraisePersonLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(27)
            make.leading.equalTo(contentView.snp.leading).offset(27)
        }
        
        yellowlineView.snp.makeConstraints { make in
            make.top.equalTo(toPraisePersonLabel.snp.bottom).offset(2)
            make.leading.equalTo(toPraisePersonLabel.snp.leading).offset(0)
            make.height.equalTo(2)
            make.width.equalTo(toPraisePersonLabel.snp.width).offset(0)
        }
        
        praisedDateYellowView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(29)
            make.trailing.equalTo(contentView.snp.trailing).offset(-27)
            make.height.equalTo(32)
            make.width.equalTo(78)
        }
        
        praisedDateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(praisedDateYellowView)
            make.centerY.equalTo(praisedDateYellowView)
            make.height.equalTo(17)
        }
        
        innerYellowBoxImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        
        praiseContentLabel.snp.makeConstraints { make in
            make.height.equalTo(163)
            make.width.equalTo(174)
            make.centerX.equalTo(innerYellowBoxImageView)
            make.centerY.equalTo(innerYellowBoxImageView)
        }
    }
    
    private func bind() {
        toPraisePersonLabel.text = "To. " + toPraisePersonText!
        toPraisePersonLabel.letterSpacing = -1.0
        praisedDateLabel.text = praisedDateText
        praisedDateLabel.letterSpacing = -0.65
        praiseContentLabel.text = praiseContentText
    }
}

//MARK: - UI 레이아웃 구성부
extension PraiseCardCVCell {
    
    func setUIComponentProperty() {
        
        //toPraisePersonLabel
        toPraisePersonLabel.letterSpacing = -1.0
        toPraisePersonLabel.font = .AppleSDGothicB(size: 20)
        toPraisePersonLabel.textColor = .black
        
        //yellowlineView
        yellowlineView.backgroundColor = .yellow_1
        
        //praisedDateYellowView
        praisedDateYellowView.backgroundColor = .yellow_2
        praisedDateYellowView.layer.cornerRadius = 16
        
        //praisedDateLabel
        praisedDateLabel.letterSpacing = -0.65
        praisedDateLabel.font = .AppleSDGothicR(size: 13)
        praisedDateLabel.textColor = .brown_1
        
        //innerYellowBoxImageView
        innerYellowBoxImageView.image = UIImage(named: "cardImgCard")
        
        //praiseContentLabel
        praiseContentLabel.font = .GmarketSansMedium(size: 20)
        praiseContentLabel.textColor = .brown_1
        praiseContentLabel.numberOfLines = 0
        praiseContentLabel.textAlignment = .center
    }
}


