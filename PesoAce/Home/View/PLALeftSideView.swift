//
//  PLALeftSideView.swift
//  PesoAce
//
//  Created by apple on 2024/8/5.
//

import UIKit
import RxSwift

class PLALeftSideView: UIView {
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    var block3: (() -> Void)?
    
    var block4: (() -> Void)?
    
    var block5: (() -> Void)?
    
    var block6: (() -> Void)?
    
    var block7: (() -> Void)?//bank change
    
    lazy var disposeBag = {
        return DisposeBag()
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(css: "#FFFFFF")
        return scrollView
    }()
    
    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.setBackgroundImage(UIImage(named: "Group_cc"), for: .normal)
        return canBtn
    }()
    
    lazy var kefuBtn: UIButton = {
        let kefuBtn = UIButton(type: .custom)
        kefuBtn.setBackgroundImage(UIImage(named: "Groupkefu"), for: .normal)
        return kefuBtn
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Ellipseii")
        return bgImageView
    }()
    
    lazy var helloLabel: UILabel = {
        let helloLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 24.px())!, textColor: UIColor.init(css: "#222222"), textAlignment: .center)
        helloLabel.numberOfLines = 0
        if IS_LOGIN {
            let phone = UserDefaults.standard.object(forKey: PLA_LOGIN) as! String
            helloLabel.text = "Hello!\n\(phone)"
        }else {
            helloLabel.text = "Hello!"
        }
        return helloLabel
    }()
    
    lazy var helloLabel1: UILabel = {
        let helloLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 12.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .center)
        helloLabel.numberOfLines = 0
        helloLabel.text = "‘’ Making timely payments can help increase your credit limit‘’"
        return helloLabel
    }()
    
    lazy var leftView1: PLAJianTouView = {
        let leftView1 = PLAJianTouView()
        leftView1.helloLabel.text = "My Orders"
        leftView1.iconImageView.image = UIImage(named: "Group_right")
        return leftView1
    }()
    
    lazy var leftView2: PLAJianTouView = {
        let leftView1 = PLAJianTouView()
        leftView1.helloLabel.text = "Privacy Policy"
        leftView1.iconImageView.image = UIImage(named: "Group_right")
        return leftView1
    }()
    
    lazy var leftView3: PLAJianTouView = {
        let leftView1 = PLAJianTouView()
        leftView1.helloLabel.text = "Loan agreement"
        leftView1.iconImageView.image = UIImage(named: "Group_right")
        return leftView1
    }()
    
    lazy var leftView4: PLAJianTouView = {
        let leftView1 = PLAJianTouView()
        leftView1.helloLabel.textColor = UIColor.init(css: "#F44444")
        leftView1.helloLabel.text = "Deleting an account"
        leftView1.iconImageView.image = UIImage(named: "Group_right_red")
        return leftView1
    }()
    
    lazy var leftView5: PLAJianTouView = {
        let leftView1 = PLAJianTouView()
        leftView1.helloLabel.text = "Bank card"
        leftView1.iconImageView.image = UIImage(named: "Group_right")
        return leftView1
    }()
    
    lazy var outBtn: UIButton = {
        let outBtn = UIButton(type: .custom)
        outBtn.setTitle("Sign Out", for: .normal)
        outBtn.setTitleColor(UIColor.init(css: "#222222"), for: .normal)
        outBtn.titleLabel?.font = UIFont(name: black_font, size: 14.px())
        outBtn.backgroundColor = UIColor.init(css: "#FAFAFA")
        return outBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(canBtn)
        scrollView.addSubview(kefuBtn)
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(helloLabel)
        scrollView.addSubview(helloLabel1)
        scrollView.addSubview(leftView1)
        scrollView.addSubview(leftView5)
        scrollView.addSubview(leftView2)
        scrollView.addSubview(leftView3)
        scrollView.addSubview(leftView4)
        scrollView.addSubview(outBtn)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        canBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22.px())
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        kefuBtn.snp.makeConstraints { make in
            make.left.equalTo(canBtn.snp.right).offset(166.px())
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(kefuBtn.snp.bottom).offset(65.px())
            make.size.equalTo(CGSize(width: 122.px(), height: 122.px()))
        }
        helloLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView.snp.bottom).offset(18.px())
            make.left.equalToSuperview().offset(24.px())
        }
        helloLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(helloLabel.snp.bottom).offset(12.px())
            make.left.equalToSuperview().offset(24.px())
        }
        leftView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48.px())
            make.left.equalToSuperview()
            make.top.equalTo(helloLabel1.snp.bottom).offset(45.px())
        }
        leftView5.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48.px())
            make.left.equalToSuperview()
            make.top.equalTo(leftView1.snp.bottom).offset(12.px())
        }
        leftView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48.px())
            make.left.equalToSuperview()
            make.top.equalTo(leftView5.snp.bottom).offset(12.px())
        }
        leftView3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48.px())
            make.left.equalToSuperview()
            make.top.equalTo(leftView2.snp.bottom).offset(12.px())
        }
        leftView4.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48.px())
            make.left.equalToSuperview()
            make.top.equalTo(leftView3.snp.bottom).offset(12.px())
        }
        outBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(48.px())
            make.left.equalToSuperview().offset(16.px())
            make.top.equalTo(leftView4.snp.bottom).offset(92.px())
            make.bottom.equalToSuperview().offset(-50.px())
        }
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disposeBag)
        kefuBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        outBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block2?()
        }).disposed(by: disposeBag)
        leftView1.btn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block3?()
        }).disposed(by: disposeBag)
        leftView2.btn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block4?()
        }).disposed(by: disposeBag)
        leftView3.btn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block5?()
        }).disposed(by: disposeBag)
        leftView4.btn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block6?()
        }).disposed(by: disposeBag)
        leftView5.btn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block7?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
