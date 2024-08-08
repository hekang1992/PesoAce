//
//  PLAPMInfoView.swift
//  PesoAce
//
//  Created by apple on 2024/8/8.
//

import UIKit
import RxSwift

class PLAPMInfoView: UIView {
    
    lazy var disp = DisposeBag()
    
    var block: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(css: "#FFFFFF")
        return scrollView
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        return bgView
    }()

    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.setBackgroundImage(UIImage(named: "Group_cc"), for: .normal)
        return canBtn
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 16.px())!, textColor: UIColor.init(css: "#2D2D2D"), textAlignment: .center)
        titleLabel.text = "Confirm Details"
        return titleLabel
    }()
    
    lazy var nameView: PLAPCommonView = {
        let nameView = PLAPCommonView()
        nameView.tlabel.text = "Name"
        return nameView
    }()
    
    lazy var idView: PLAPCommonView = {
        let idView = PLAPCommonView()
        idView.tlabel.text = "Number"
        return idView
    }()
    
    
    lazy var dateView: PLAPClickView = {
        let dateView = PLAPClickView()
        dateView.tlabel.text = "Date of birth"
        return dateView
    }()
    
    lazy var sendBtn: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        sendBtn.setTitle("Confirm", for: .normal)
        sendBtn.setTitleColor(UIColor.init(css: "#FFFFFF"), for: .normal)
        sendBtn.backgroundColor = UIColor.init(css: "#2681FB")
        return sendBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(scrollView)
        scrollView.addSubview(canBtn)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(nameView)
        scrollView.addSubview(idView)
        scrollView.addSubview(dateView)
        scrollView.addSubview(sendBtn)
        bgView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 327.px(), height: 468.px()))
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        canBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14.px())
            make.left.equalToSuperview().offset(289.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12.px())
            make.height.equalTo(24.px())
        }
        nameView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(28.px())
            make.height.equalTo(82.px())
        }
        idView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(nameView.snp.bottom).offset(20.px())
            make.height.equalTo(82.px())
        }
        dateView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(idView.snp.bottom).offset(20.px())
            make.height.equalTo(82.px())
        }
        sendBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(dateView.snp.bottom).offset(38.px())
            make.height.equalTo(56.px())
            make.bottom.equalToSuperview().offset(-30.px())
        }
        
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
