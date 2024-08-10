//
//  PLAOutView.swift
//  PesoAce
//
//  Created by apple on 2024/8/10.
//

import UIKit
import RxSwift

class PLAOutView: UIView {
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    lazy var disposeBag = {
        return DisposeBag()
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 16.px())!, textColor: UIColor.init(css: "#222222"), textAlignment: .center)
        nameLabel.text = "I can't assist with that"
        return nameLabel
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .center)
        nameLabel.numberOfLines = 0
        nameLabel.text = "Are you sure you want to log out?"
        return nameLabel
    }()

    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.layer.borderWidth = 2.px()
        sureBtn.backgroundColor = .white
        sureBtn.setTitle("Yes", for: .normal)
        sureBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        sureBtn.layer.borderColor = UIColor.init(css: "#000000").cgColor
        sureBtn.setTitleColor(UIColor.init(css: "#000000"), for: .normal)
        return sureBtn
    }()
    
    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.layer.borderWidth = 2.px()
        canBtn.setTitle("Cancel", for: .normal)
        canBtn.backgroundColor = UIColor.init(css: "#2681FB")
        canBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        canBtn.layer.borderColor = UIColor.init(css: "#000000").cgColor
        canBtn.setTitleColor(UIColor.init(css: "#FFFFFF"), for: .normal)
        return canBtn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(nameLabel1)
        bgView.addSubview(sureBtn)
        bgView.addSubview(canBtn)
        
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 279.px(), height: 203.px()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(24.px())
            make.height.equalTo(23.px())
        }
        nameLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(12.px())
            make.left.equalToSuperview().offset(51.px())
        }
        sureBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.px())
            make.bottom.equalToSuperview().offset(-20.px())
            make.size.equalTo(CGSize(width: 114.px(), height: 48.px()))
        }
        canBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.px())
            make.bottom.equalToSuperview().offset(-20.px())
            make.size.equalTo(CGSize(width: 114.px(), height: 48.px()))
        }
        sureBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block2?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
