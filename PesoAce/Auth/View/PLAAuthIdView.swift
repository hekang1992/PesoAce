//
//  PLAAuthIdView.swift
//  PesoAce
//
//  Created by apple on 2024/8/7.
//

import UIKit
import RxSwift

class PLAAuthIdView: UIView {
    
    var block: (() -> Void)?
    
    lazy var disp = DisposeBag()

    lazy var canBtn: UIButton = {
        let canBtn = UIButton(type: .custom)
        canBtn.setBackgroundImage(UIImage(named: "Group_cc"), for: .normal)
        return canBtn
    }()
    
    lazy var titltLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 16.px())!, textColor: UIColor.init(css: "#2D2D2D"), textAlignment: .center)
        return titleLabel
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titltLabel)
        addSubview(canBtn)
        titltLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(24.px())
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
        }
        canBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titltLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
            make.left.equalToSuperview().offset(SCREEN_WIDTH - 48.px())
        }
        
        
        canBtn.rx.tap.subscribe(onNext: { [weak self ] in
            self?.block?()
        }).disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


