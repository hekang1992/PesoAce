//
//  PLAOrderListCell.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit

class PLAOrderListCell: UITableViewCell {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var productImage: UIImageView = {
        let productImage = UIImageView()
        productImage.backgroundColor = UIColor.init(css: "#D9D9D9")
        return productImage
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 14.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .left)
        return nameLabel
    }()
    
    lazy var seView: UIView = {
        let seView = UIView()
        seView.backgroundColor = UIColor.init(css: "#F4F7FF")
        return seView
    }()
    
    lazy var typePaLabel: UILabel = {
        let typePaLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#2681FB"), textAlignment: .center)
        return typePaLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(css: "#F5F5F5")
        return lineView
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel1 = UILabel.createLabel(font: UIFont(name: regular_font, size: 16.px())!, textColor: UIColor.init(css: "#BCBCBC"), textAlignment: .left)
        return nameLabel1
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel2 = UILabel.createLabel(font: UIFont(name: black_font, size: 14.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .right)
        return nameLabel2
    }()
    
    lazy var nameLabel3: UILabel = {
        let nameLabel1 = UILabel.createLabel(font: UIFont(name: regular_font, size: 16.px())!, textColor: UIColor.init(css: "#BCBCBC"), textAlignment: .left)
        return nameLabel1
    }()
    
    lazy var nameLabel4: UILabel = {
        let nameLabel2 = UILabel.createLabel(font: UIFont(name: black_font, size: 14.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .right)
        return nameLabel2
    }()
    
    lazy var lastLabel: UILabel = {
        let lastLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 16.px())!, textColor: UIColor.init(css: "#FFFFFF"), textAlignment: .center)
        return lastLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(seView)
        seView.addSubview(typePaLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(nameLabel1)
        contentView.addSubview(nameLabel2)
        contentView.addSubview(nameLabel3)
        contentView.addSubview(nameLabel4)
        contentView.addSubview(lastLabel)
        productImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 26.px(), height: 26.px()))
            make.top.equalToSuperview().offset(27.px())
            make.left.equalToSuperview().offset(35.px())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(productImage.snp.centerY)
            make.left.equalTo(productImage.snp.right).offset(8.px())
            make.height.equalTo(18.px())
        }
        seView.snp.makeConstraints { make in
            make.centerY.equalTo(productImage.snp.centerY)
            make.size.equalTo(CGSize(width: 97.px(), height: 24.px()))
            make.right.equalToSuperview().offset(-45.px())
        }
        typePaLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35.px())
            make.top.equalTo(productImage.snp.bottom).offset(14.px())
            make.height.equalTo(1.px())
            make.centerX.equalToSuperview()
        }
        nameLabel1.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(17.px())
            make.left.equalToSuperview().offset(35.px())
            make.height.equalTo(20.px())
        }
        nameLabel2.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(17.px())
            make.right.equalToSuperview().offset(-35.px())
            make.height.equalTo(20.px())
        }
        nameLabel3.snp.makeConstraints { make in
            make.top.equalTo(nameLabel1.snp.bottom).offset(17.px())
            make.left.equalToSuperview().offset(35.px())
            make.height.equalTo(20.px())
        }
        nameLabel4.snp.makeConstraints { make in
            make.top.equalTo(nameLabel1.snp.bottom).offset(17.px())
            make.right.equalToSuperview().offset(-35.px())
            make.height.equalTo(20.px())
        }
        lastLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel4.snp.bottom).offset(24.px())
            make.right.equalToSuperview().offset(-35.px())
            make.centerX.equalToSuperview()
            make.height.equalTo(48.px())
            make.bottom.equalToSuperview().offset(-20.px())
        }
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.px())
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10.px())
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: cleanerModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.mysel ?? ""
            nameLabel1.text = String(format: "%@:", model.compared ?? "")
            nameLabel2.text = model.wordlessly ?? ""
            nameLabel3.text = String(format: "%@:", model.pooling ?? "")
            nameLabel4.text = model.oozed ?? ""
            productImage.kf.setImage(with: URL(string: model.plans ?? ""))
            lastLabel.backgroundColor = UIColor.init(css: model.notictColor ?? "#2681FB")
            lastLabel.text = model.straddling ?? ""
            seView.backgroundColor = UIColor.init(css: model.btnBgColor ?? "#F4F7FF")
            typePaLabel.textColor = UIColor.init(css: model.btnCollor ?? "#2681FB")
            typePaLabel.text = model.paws ?? ""
        }
    }
}

