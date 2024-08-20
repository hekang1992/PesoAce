//
//  PLAOrderListNormalCell.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit

class PLAOrderListNormalCell: UITableViewCell {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var productImage: UIImageView = {
        let productImage = UIImageView()
        productImage.image = UIImage(named: "AppIcon")
        return productImage
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 16.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .left)
        return timeLabel
    }()
    
    lazy var stView: UIView = {
        let stView = UIView()
        stView.backgroundColor = UIColor.init(css: "#F4F7FF")
        return stView
    }()
    
    lazy var stLabel: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#2681FB"), textAlignment: .left)
        return stLabel
    }()
    
    lazy var monLabel: UILabel = {
        let monLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 18.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .left)
        return monLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(productImage)
        contentView.addSubview(timeLabel)
        contentView.addSubview(stView)
        contentView.addSubview(stLabel)
        contentView.addSubview(monLabel)
        productImage.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 58.px(), height: 58.px()))
            make.top.equalToSuperview().offset(27.px())
            make.left.equalToSuperview().offset(27.px())
        }
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).offset(12.px())
            make.top.equalToSuperview().offset(25.px())
            make.height.equalTo(20.px())
        }
        stLabel.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).offset(21.px())
            make.top.equalTo(timeLabel.snp.bottom).offset(14.px())
            make.height.equalTo(18.px())
        }
        stView.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).offset(12.px())
            make.top.equalTo(timeLabel.snp.bottom).offset(11.px())
            make.height.equalTo(24.px())
            make.right.equalTo(stLabel.snp.right).offset(8.px())
        }
        monLabel.snp.makeConstraints { make in
            make.left.equalTo(timeLabel.snp.left)
            make.top.equalTo(stView.snp.bottom).offset(8.px())
            make.height.equalTo(22.px())
            make.bottom.equalToSuperview().offset(-8.px())
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
            timeLabel.text = "Due Date: \(model.wordlessly ?? "")"
            stLabel.text = model.pooling ?? ""
            monLabel.text = model.oozed ?? ""
            productImage.kf.setImage(with: URL(string: model.plans ?? ""), placeholder: UIImage(named: "AppIcon"))
        }
    }
    
}
