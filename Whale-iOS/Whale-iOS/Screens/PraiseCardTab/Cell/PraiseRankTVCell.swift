//
//  PraiseRankTVCell.swift
//  Whale-iOS
//
//  Created by 황지은 on 2021/08/16.
//

import UIKit

class PraiseRankTVCell: UITableViewCell {

    static var id: String { NSStringFromClass(Self.self).components(separatedBy: ".").last ?? "" }
    
    var rankingCircleNumberImageView = UIImageView()
    var praisedPersonLabel = UILabel()
    var praisedCountLabel = UILabel()
    var rankingArrowImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setContentViewUI()
        addSubviews()
        setUIComponentProperty()
        configure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 42, bottom: 12, right: 42))
    }
    
    var praisedPersonText: String? { didSet { bind() } }
    var praisedCountText: String? { didSet { bind() } }
    var praisedNumber: Int? { didSet { rankingCircleNumberVerify(praisedNumber!) } }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setContentViewUI() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.yellow_3.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    private func addSubviews() {
        self.contentView.addSubview(rankingCircleNumberImageView)
        self.contentView.addSubview(praisedPersonLabel)
        self.contentView.addSubview(praisedCountLabel)
        self.contentView.addSubview(rankingArrowImageView)
    }
    
    private func configure() {
        
        rankingCircleNumberImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.height.equalTo(38)
            make.width.equalTo(38)
            make.centerY.equalTo(contentView)
        }
        
        praisedPersonLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(87)
            make.height.equalTo(25)
            make.centerY.equalTo(contentView)
        }
        
        praisedCountLabel.snp.makeConstraints{ make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-55)
            make.height.equalTo(23)
            make.centerY.equalTo(contentView)
        }
        
        rankingArrowImageView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).offset(-22)
            make.width.equalTo(4)
            make.height.equalTo(8)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func bind() {
        praisedPersonLabel.text = praisedPersonText
        praisedPersonLabel.letterSpacing = -0.9
        praisedCountLabel.text = praisedCountText
        praisedCountLabel.letterSpacing = -0.8
    }
    
    private func rankingCircleNumberVerify(_ number: Int) {
        for i in 1...5 {
            if number == i - 1 {
                rankingCircleNumberImageView.image = UIImage(named: "rankingCircleNumber" + "\(i)")
                print(i)
                print("rankingCircleNumber" + "\(i)")
            }
        }
    }
}

//MARK: - UI 레이아웃 구성부
extension PraiseRankTVCell {
    
    func setUIComponentProperty() {
        
        //praisedPersonLabel
        praisedPersonLabel.font = .AppleSDGothicB(size: 18)
        praisedPersonLabel.textColor = .black
        
        //praisedCountLabel
        praisedCountLabel.font = .AppleSDGothicR(size: 16)
        praisedCountLabel.textColor = .brown_1
        
        //rankingArrowImageView
        rankingArrowImageView.image = UIImage(named: "rankingIcArrow")
    }
}


