//
//  PLAHomeOneView.swift
//  PesoAce
//
//  Created by apple on 2024/8/5.
//

import UIKit
import RxSwift

class PLAHomeOneView: UIView {
    
    lazy var disp = DisposeBag()
    
    var applyBlock: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(css: "#EEF4FA")
        return scrollView
    }()

    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Groupbgimh")
        return bgImageView
    }()
    
    lazy var bgImageView1: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Groupstep")
        return bgImageView
    }()
    
    lazy var bgImageView2: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Group 8")
        return bgImageView
    }()

    lazy var bgImageView3: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "Group_last")
        return bgImageView
    }()
    
    lazy var appBtn: UIButton = {
        let appBtn = UIButton(type: .custom)
        appBtn.setBackgroundImage(UIImage(named: "Group_apply"), for: .normal)
        return appBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        scrollView.addSubview(bgImageView1)
        scrollView.addSubview(appBtn)
        scrollView.addSubview(bgImageView2)
        scrollView.addSubview(bgImageView3)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(541.px())
        }
        bgImageView1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.px())
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView.snp.bottom).offset(-87.px())
            make.height.equalTo(155.px())
        }
        appBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 287.px(), height: 70.px()))
            make.top.equalTo(bgImageView1.snp.top).offset(-22.px())
        }
        bgImageView2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.px())
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView1.snp.bottom).offset(10.px())
            make.height.equalTo(148.px())
        }
        bgImageView3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.px())
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView2.snp.bottom).offset(10.px())
            make.height.equalTo(327.px())
            make.bottom.equalToSuperview().offset(-20.px())
        }
        
        appBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.applyBlock?()
        }).disposed(by: disp)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
