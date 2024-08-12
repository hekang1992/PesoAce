//
//  PLAShuRuKuangCell.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit

class PLAShuRuKuangCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        return titleLabel
    }()
    
    lazy var bgvIEW: UIView = {
        let bgvIEW = UIView()
        bgvIEW.backgroundColor = UIColor.init(css: "#F4F7FF")
        bgvIEW.layer.borderWidth = 2.px()
        bgvIEW.layer.borderColor = UIColor.init(css: "#E4E9F6").cgColor
        return bgvIEW
    }()
    
    lazy var nameField: UITextField = {
        let nameField = UITextField()
        nameField.textAlignment = .left
        nameField.font = UIFont(name: regular_font, size: 18.px())
        nameField.textColor = UIColor.init(css: "#2681FB")
        nameField.addTarget(self, action: #selector(ngChanged(_:)), for: .editingChanged)
        return nameField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bgvIEW)
        bgvIEW.addSubview(nameField)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(28.px())
        }
        bgvIEW.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(titleLabel.snp.bottom).offset(4.px())
            make.height.equalTo(56.px())
            make.bottom.equalToSuperview().offset(-16.px())
        }
        nameField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16.px(), bottom: 0, right: 0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: lumModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.faisal ?? ""
            let attrString = NSMutableAttributedString(string: model.landlord ?? "", attributes: [
                .foregroundColor: UIColor.init(css: "#ACB7D6") as Any,
                .font: UIFont(name: regular_font, size: 16.px())!
            ])
            nameField.attributedPlaceholder = attrString
            let shalwar = model.shalwar ?? ""
            if !shalwar.isEmpty {
                nameField.text = shalwar
            }else {
                nameField.text = ""
            }
        }
    }
    
}

extension PLAShuRuKuangCell {
    
    @objc func ngChanged(_ textField: UITextField) {
        if textField == nameField {
            if let model = model {
                model.shalwar = nameField.text
            }
        }
    }
    
}


