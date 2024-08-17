//
//  PLAChangeBankCell.swift
//  PesoAce
//
//  Created by 何康 on 2024/8/17.
//

import UIKit
import RxSwift
import RxCocoa

class PLAChangeBankCell: UITableViewCell {
    
    lazy var disp = DisposeBag()
    
    var model = BehaviorRelay<improvementModel?>(value: nil)
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 2.px()
        return bgView
    }()

    lazy var naleLabel1: UILabel = {
        let naleLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 18.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .left)
        naleLabel.numberOfLines = 0
        return naleLabel
    }()
    
    lazy var naleLabel2: UILabel = {
        let naleLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        return naleLabel
    }()
    
    lazy var naleLabel3: UILabel = {
        let naleLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 16.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .left)
        return naleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        contentView.addSubview(naleLabel1)
        contentView.addSubview(naleLabel2)
        contentView.addSubview(naleLabel3)
        naleLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.px())
            make.left.equalToSuperview().offset(35.px())
            make.width.equalTo(240.px())
        }
        naleLabel2.snp.makeConstraints { make in
            make.top.equalTo(naleLabel1.snp.bottom).offset(6.px())
            make.left.equalToSuperview().offset(35.px())
            make.height.equalTo(16.px())
        }
        naleLabel3.snp.makeConstraints { make in
            make.top.equalTo(naleLabel2.snp.bottom).offset(13.px())
            make.left.equalToSuperview().offset(35.px())
            make.height.equalTo(16.px())
            make.bottom.equalToSuperview().offset(-24.px())
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15.px())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12.px())
        }
        model.subscribe(onNext: { [weak self] model in
            if let model = model, let self = self {
                self.naleLabel1.text = model.repeating ?? ""
                self.naleLabel3.text = model.podge ?? ""
                if model.signaling == "1" {
                    bgView.backgroundColor = UIColor.init(css: "#2681FB")
                    naleLabel1.textColor = UIColor.white
                    naleLabel2.textColor = UIColor.white.withAlphaComponent(0.4)
                    naleLabel3.textColor = UIColor.white
                }else {
                    bgView.backgroundColor = UIColor.init(css: "#FFFFFF")
                    naleLabel1.textColor = UIColor.init(css: "#333333")
                    naleLabel2.textColor = UIColor.init(css: "#A9A9A9")
                    naleLabel3.textColor = UIColor.init(css: "#333333")
                }
            }
        }).disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
