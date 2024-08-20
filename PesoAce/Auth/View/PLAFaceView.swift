//
//  PLAFaceView.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit
import RxSwift

class PLAFaceView: UIView {
    
    lazy var disp = DisposeBag()
    
    var block: (() -> Void)?
    
    var block1: ((UIButton) -> Void)?
    
    var block2: ((UIButton) -> Void)?
    
    var block3: ((UIButton) -> Void)?
    
    var block4: ((UIButton) -> Void)?

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(css: "#FFFFFF")
        return scrollView
    }()
    
    lazy var canBtn: EXButton = {
        let canBtn = EXButton(type: .custom)
        canBtn.hitTestEdgeInsets = UIEdgeInsets(top: -10.px(), left: -10.px(), bottom: -10.px(), right: -10.px())
        canBtn.setBackgroundImage(UIImage(named: "Group_cc"), for: .normal)
        return canBtn
    }()
    
    lazy var stView: UIView = {
        let stView = UIView()
        stView.backgroundColor = UIColor.init(css: "#F4F7FF")
        return stView
    }()
    
    lazy var stLabel: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 12.px())!, textColor: UIColor.init(css: "#2681FB"), textAlignment: .center)
        stLabel.text = "Progress: 1/5"
        return stLabel
    }()
    
    lazy var stLabel1: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 24.px())!, textColor: UIColor.init(css: "#000000"), textAlignment: .left)
        stLabel.text = "Verify identity"
        return stLabel
    }()
    
    lazy var stLabel2: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        stLabel.text = "For ldentity And Credit Assessment"
        return stLabel
    }()
    
    lazy var idBtn: UIButton = {
        let idBtn = UIButton(type: .custom)
        idBtn.adjustsImageWhenHighlighted = false
        idBtn.setBackgroundImage(UIImage(named: "Groupid"), for: .normal)
        return idBtn
    }()
    
    lazy var idBtn1: UIButton = {
        let idBtn = UIButton(type: .custom)
        idBtn.adjustsImageWhenHighlighted = false
//        idBtn.setBackgroundImage(UIImage(named: "Group 39988"), for: .normal)
        return idBtn
    }()
    
    lazy var idBtn2: UIButton = {
        let idBtn = UIButton(type: .custom)
        idBtn.adjustsImageWhenHighlighted = false
        idBtn.setBackgroundImage(UIImage(named: "Group 39922"), for: .normal)
        return idBtn
    }()
    
    lazy var faceBtn: UIButton = {
        let faceBtn = UIButton(type: .custom)
        faceBtn.adjustsImageWhenHighlighted = false
        faceBtn.setBackgroundImage(UIImage(named: "Groupface"), for: .normal)
        return faceBtn
    }()
    
    lazy var faceBtn1: UIButton = {
        let faceBtn = UIButton(type: .custom)
        faceBtn.adjustsImageWhenHighlighted = false
        faceBtn.setBackgroundImage(UIImage(named: "Group 40007"), for: .normal)
        return faceBtn
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        descLabel.numberOfLines = 0
        descLabel.text = "The platform will protect your information security according to the law and relevant agreements"
        return descLabel
    }()
    
    lazy var bg: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "Group 39980")
        return bg
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.isEnabled = false
        loginBtn.setTitle("Submit and next", for: .normal)
        loginBtn.backgroundColor = UIColor.init(css: "#F4F7FF")
        return loginBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(canBtn)
        scrollView.addSubview(stView)
        stView.addSubview(stLabel)
        scrollView.addSubview(stLabel1)
        scrollView.addSubview(stLabel2)
        scrollView.addSubview(idBtn)
        idBtn.addSubview(idBtn1)
        idBtn1.addSubview(idBtn2)
        scrollView.addSubview(faceBtn)
        faceBtn.addSubview(faceBtn1)
        scrollView.addSubview(descLabel)
        scrollView.addSubview(bg)
        scrollView.addSubview(loginBtn)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        canBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 15.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
            make.left.equalToSuperview().offset(SCREEN_WIDTH - 48.px())
        }
        stView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 52.px())
            make.size.equalTo(CGSize(width: 89.px(), height: 28.px()))
            make.left.equalToSuperview().offset(24.px())
        }
        stLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stLabel1.snp.makeConstraints { make in
            make.top.equalTo(stLabel.snp.bottom).offset(24.px())
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(28.px())
        }
        stLabel2.snp.makeConstraints { make in
            make.top.equalTo(stLabel1.snp.bottom).offset(9.px())
            make.left.equalToSuperview().offset(20.px())
            make.height.equalTo(28.px())
        }
        idBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stLabel2.snp.bottom).offset(123.px())
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(102.px())
        }
        idBtn1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 125.px(), height: 78.px()))
            make.left.equalToSuperview().offset(12.px())
        }
        idBtn2.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        faceBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(idBtn.snp.bottom).offset(12.px())
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(102.px())
        }
        faceBtn1.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 125.px(), height: 78.px()))
            make.left.equalToSuperview().offset(12.px())
        }
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(faceBtn.snp.bottom).offset(12.px())
            make.left.equalToSuperview().offset(36.px())
        }
        bg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 160.px(), height: 20.px()))
            make.top.equalTo(descLabel.snp.bottom).offset(56.px())
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(32.px())
            make.top.equalTo(bg.snp.bottom).offset(12.px())
            make.height.equalTo(57.px())
            make.bottom.equalToSuperview().offset(-50.px())
        }
        
        canBtn.rx.tap.subscribe(onNext: { [weak self ] in
            self?.block?()
        }).disposed(by: disp)
        
        //datup
        idBtn.rx.tap.subscribe(onNext: { [weak self ] in
            if let self = self {
                self.block3?(self.idBtn1)
            }
        }).disposed(by: disp)
        
        idBtn1.rx.tap.subscribe(onNext: { [weak self ] in
            if let self = self {
                self.block1?(self.idBtn1)
            }
        }).disposed(by: disp)
        
        idBtn2.rx.tap.subscribe(onNext: { [weak self ] in
            if let self = self {
                self.block1?(self.idBtn1)
            }
        }).disposed(by: disp)
        
        faceBtn.rx.tap.subscribe(onNext: { [weak self ] in
            if let self = self {
                self.block2?(self.faceBtn1)
            }
        }).disposed(by: disp)
        
        faceBtn1.rx.tap.subscribe(onNext: { [weak self ] in
            if let self = self {
                self.block2?(self.faceBtn1)
            }
        }).disposed(by: disp)
        
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self ] in
            if let self = self {
                self.block4?(self.loginBtn)
            }
        }).disposed(by: disp)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
