//
//  PLALxiCell.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit
import RxSwift

class PLALxiCell: UITableViewCell {

    lazy var disp = DisposeBag()
    
    var block1: ((UIButton, cleanerModel) -> Void)?
    
    var block2: ((UIButton, cleanerModel) -> Void)?

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
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        btn.setTitleColor(UIColor.init(css: "#ACB7D6"), for: .normal)
        btn.setTitle("Relationship", for: .normal)
        return btn
    }()
    
    lazy var btn1: UIButton = {
        let btn1 = UIButton(type: .custom)
        btn1.contentHorizontalAlignment = .left
        btn1.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        btn1.setTitleColor(UIColor.init(css: "#ACB7D6"), for: .normal)
        btn1.setTitle("Phone and name", for: .normal)
        return btn1
    }()
    
    lazy var iocn: UIImageView = {
        let iocn = UIImageView()
        iocn.image = UIImage(named: "Grolian")
        return iocn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bgvIEW)
        bgvIEW.addSubview(btn)
        bgvIEW.addSubview(btn1)
        bgvIEW.addSubview(iocn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(28.px())
        }
        bgvIEW.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(titleLabel.snp.bottom).offset(4.px())
            make.height.equalTo(80.px())
            make.bottom.equalToSuperview().offset(-16.px())
        }
        iocn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        btn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.px())
            make.top.right.equalToSuperview()
            make.height.equalTo(40.px())
        }
        btn1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.px())
            make.right.bottom.equalToSuperview()
            make.height.equalTo(40.px())
        }
        btn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                guard let model = self.model else { return }
                self.block1?(self.btn, model)
            }
        }).disposed(by: disp)
        btn1.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                guard let model = self.model else { return }
                self.block2?(self.btn1, model)
            }
        }).disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: cleanerModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.riches ?? ""
        }
    }

}
