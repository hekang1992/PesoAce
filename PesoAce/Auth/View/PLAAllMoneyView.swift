//
//  PLAAllMoneyView.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit
import RxSwift

class PLAAllMoneyView: UIView {

    lazy var disp = DisposeBag()
    
    var block: (() -> Void)?
    
    var saveblock: (() -> Void)?
    
    var scrollDistance: CGFloat = 0
    
    var modelArray: [cleanerModel]?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(css: "#FFFFFF")
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: 0)
        return scrollView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.contentHorizontalAlignment = .center
        nextBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        nextBtn.setTitle("Submit and next", for: .normal)
        nextBtn.backgroundColor = UIColor.init(css: "#2681FB")
        nextBtn.setTitleColor(.white, for: .normal)
        return nextBtn
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#2D2D2D"), textAlignment: .center)
        titleLabel.text = "Receiving Account"
        titleLabel.alpha = 0
        return titleLabel
    }()
    
    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
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
        stLabel.text = "Receiving Account"
        return stLabel
    }()
    
    lazy var stLabel2: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        stLabel.text = "Accurate account info for smooth loan use"
        return stLabel
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.isEnabled = false
        loginBtn.setTitle("Submit and next", for: .normal)
        loginBtn.backgroundColor = UIColor.init(css: "#F4F7FF")
        return loginBtn
    }()
    
    lazy var wallBtn: UIButton = {
        let wallBtn = UIButton(type: .custom)
        wallBtn.setTitle("E-wallet", for: .normal)
        wallBtn.backgroundColor = UIColor.init(css: "#F4F7FF")
        wallBtn.layer.borderWidth = 2.px()
        wallBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        wallBtn.layer.borderColor = UIColor.init(css: "#2681FB").cgColor
        wallBtn.setTitleColor(UIColor.init(css: "#2681FB"), for: .normal)
        return wallBtn
    }()
    
    lazy var bankBtn: UIButton = {
        let bankBtn = UIButton(type: .custom)
        bankBtn.setTitle("Bank", for: .normal)
        bankBtn.backgroundColor = UIColor.init(css: "#F4F7FF")
        bankBtn.layer.borderWidth = 2.px()
        bankBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        bankBtn.setTitleColor(UIColor.init(css: "#ACB7D6"), for: .normal)
        bankBtn.layer.borderColor = UIColor.init(css: "#E4E9F6").cgColor
        return bankBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(canBtn)
        addSubview(titleLabel)
        addSubview(stView)
        stView.addSubview(stLabel)
        addSubview(stLabel1)
        addSubview(stLabel2)
        addSubview(wallBtn)
        addSubview(bankBtn)
        addSubview(scrollView)
        canBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
            make.left.equalToSuperview().offset(SCREEN_WIDTH - 48.px())
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
            make.height.equalTo(24.px())
        }
        stView.snp.makeConstraints { make in
            make.top.equalTo(canBtn.snp.bottom).offset(22.px())
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
        wallBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(stLabel2.snp.bottom).offset(28.px())
            make.size.equalTo(CGSize(width: 158.px(), height: 56.px()))
        }
        bankBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24.px())
            make.top.equalTo(stLabel2.snp.bottom).offset(28.px())
            make.size.equalTo(CGSize(width: 158.px(), height: 56.px()))
        }
        scrollView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(wallBtn.snp.bottom).offset(16.px())
        }
        
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disp)
        wallBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.bankBtn.setTitleColor(UIColor.init(css: "#ACB7D6"), for: .normal)
                self.bankBtn.layer.borderColor = UIColor.init(css: "#E4E9F6").cgColor
                self.wallBtn.layer.borderColor = UIColor.init(css: "#2681FB").cgColor
                self.wallBtn.setTitleColor(UIColor.init(css: "#2681FB"), for: .normal)
            }
        }).disposed(by: disp)
        bankBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.wallBtn.setTitleColor(UIColor.init(css: "#ACB7D6"), for: .normal)
                self.wallBtn.layer.borderColor = UIColor.init(css: "#E4E9F6").cgColor
                self.bankBtn.layer.borderColor = UIColor.init(css: "#2681FB").cgColor
                self.bankBtn.setTitleColor(UIColor.init(css: "#2681FB"), for: .normal)
            }
        }).disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PLAAllMoneyView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.adjustedContentInset.top
        let alpha = max(0, min(1, offset / 160.px()))
        self.titleLabel.alpha = alpha
    }

}
