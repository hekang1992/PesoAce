//
//  PLAAnNiuCell.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit
import RxSwift
import RxCocoa

class PLAAnNiuCell: UITableViewCell {
    
    lazy var disp = DisposeBag()
    
    var block: ((UIButton) -> Void)?
    
    var model = BehaviorRelay<lumModel?>(value: nil)
    
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
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bgvIEW)
        bgvIEW.addSubview(btn)
        
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
        btn.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16.px(), bottom: 0, right: 0))
        }
        btn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.block?(self.btn)
            }
        }).disposed(by: disp)
        bindModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PLAAnNiuCell {
    
    func bindModel() {
        model.subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            self.titleLabel.text = model.faisal ?? ""
            self.btn.setTitle(model.landlord ?? "", for: .normal)
            let shalwar = model.shalwar ?? ""
            if !shalwar.isEmpty {
                self.btn.setTitleColor(UIColor(css: "#2681FB"), for: .normal)
                self.btn.setTitle(shalwar, for: .normal)
            } else {
                self.btn.setTitleColor(UIColor(css: "#ACB7D6"), for: .normal)
            }
        }).disposed(by: disp)
    }
}
