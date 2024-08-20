//
//  PLAPopPhotoView.swift
//  PesoAce
//
//  Created by apple on 2024/8/8.
//

import UIKit
import RxSwift

class PLAPopPhotoView: UIView {
    
    let disp = DisposeBag()
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    var block2: (() -> Void)?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = UIColor.init(css: "#FFFFFF")
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "Group_photo")
        return bgImageView
    }()
    
    lazy var canBtn: EXButton = {
        let canBtn = EXButton(type: .custom)
        canBtn.adjustsImageWhenHighlighted = false
        canBtn.hitTestEdgeInsets = UIEdgeInsets(top: -10.px(), left: -10.px(), bottom: -10.px(), right: -10.px())
        canBtn.setBackgroundImage(UIImage(named: "Group_cc"), for: .normal)
        return canBtn
    }()
    
    lazy var phontBtn: UIButton = {
        let phontBtn = UIButton(type: .custom)
        phontBtn.adjustsImageWhenHighlighted = false
        return phontBtn
    }()
    
    lazy var cameraBtn: UIButton = {
        let cameraBtn = UIButton(type: .custom)
        cameraBtn.adjustsImageWhenHighlighted = false
        return cameraBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgImageView)
        bgImageView.addSubview(canBtn)
        bgImageView.addSubview(cameraBtn)
        bgImageView.addSubview(phontBtn)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH)
            make.height.equalTo(688.px())
            make.bottom.equalToSuperview().offset(-10.px())
        }
        canBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14.px())
            make.right.equalToSuperview().offset(-14.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        cameraBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(32.px())
            make.height.equalTo(57.px())
            make.bottom.equalToSuperview().offset(-54.px())
        }
        phontBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(32.px())
            make.height.equalTo(57.px())
            make.bottom.equalTo(cameraBtn.snp.top).offset(-12.px())
        }
        
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disp)
        
        phontBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disp)
        
        cameraBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block2?()
        }).disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
