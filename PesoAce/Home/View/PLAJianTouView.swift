//
//  PLAJianTouView.swift
//  PesoAce
//
//  Created by apple on 2024/8/5.
//

import UIKit

class PLAJianTouView: UIView {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(css: "#FAFAFA")
        return bgView
    }()

    lazy var helloLabel: UILabel = {
        let helloLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 14.px())!, textColor: UIColor.init(css: "#222222"), textAlignment: .left)
        return helloLabel
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "Group_right")
        return iconImageView
    }()
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .custom)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(helloLabel)
        bgView.addSubview(iconImageView)
        bgView.addSubview(btn)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16.px())
            make.top.equalToSuperview()
            make.height.equalTo(48.px())
        }
        helloLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.px())
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-60.px())
        }
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16.px())
            make.size.equalTo(CGSize(width: 16.px(), height: 16.px()))
        }
        btn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
