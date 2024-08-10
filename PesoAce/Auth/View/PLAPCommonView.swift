//
//  PLAPCommonView.swift
//  PesoAce
//
//  Created by apple on 2024/8/8.
//

import UIKit
import RxSwift

class PLAPCommonView: UIView {
    
    lazy var tlabel: UILabel = {
        let tlabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        return tlabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(css: "#F4F7FF")
        bgView.layer.borderWidth = 2.px()
        bgView.layer.borderColor = UIColor.init(css: "#E4E9F6").cgColor
        return bgView
    }()
    
    lazy var tectFie: UITextField = {
        let tectFie = UITextField()
        tectFie.textColor = UIColor.init(css: "#2D2D2D")
        tectFie.font = UIFont(name: regular_font, size: 16.px())
        return tectFie
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tlabel)
        addSubview(bgView)
        bgView.addSubview(tectFie)
        
        tlabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(24.px())
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(tlabel.snp.bottom).offset(6.px())
            make.height.equalTo(52.px())
        }
        tectFie.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16.px(), bottom: 0, right: 16.px()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PLAPClickView: UIView {
    
    var block: ((UIButton) -> Void)?
    
    lazy var disp = DisposeBag()
    
    lazy var tlabel: UILabel = {
        let tlabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        return tlabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(css: "#F4F7FF")
        bgView.layer.borderWidth = 2.px()
        bgView.layer.borderColor = UIColor.init(css: "#E4E9F6").cgColor
        return bgView
    }()
    
    lazy var tectBtn: UIButton = {
        let tectBtn = UIButton()
        tectBtn.contentHorizontalAlignment = .left
        tectBtn.setTitleColor(UIColor.init(css: "#2D2D2D"), for: .normal)
        tectBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        return tectBtn
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "Groupdown")
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tlabel)
        addSubview(bgView)
        bgView.addSubview(icon)
        bgView.addSubview(tectBtn)
        
        tlabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(24.px())
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(tlabel.snp.bottom).offset(6.px())
            make.height.equalTo(52.px())
        }
        icon.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        tectBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16.px(), bottom: 0, right: 16.px()))
        }
        
        tectBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.block?(self.tectBtn)
            }
        }).disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
