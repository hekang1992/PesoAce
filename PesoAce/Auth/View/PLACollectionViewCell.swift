//
//  PLACollectionViewCell.swift
//  PesoAce
//
//  Created by apple on 2024/8/8.
//

import UIKit
import Kingfisher

class PLACollectionViewCell: UICollectionViewCell {
    
    
    lazy var bgview: UIView = {
        let bgview = UIView()
        bgview.backgroundColor = UIColor.init(css: "#F8F8F8")
        return bgview
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 14.px())!, textColor: UIColor.init(css: "#0F4743"), textAlignment: .center)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgview)
        bgview.addSubview(icon)
        bgview.addSubview(titleLabel)
        
        bgview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.px())
            make.size.equalTo(CGSize(width: 162.px(), height: 134.px()))
        }
        icon.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(99.px())
        }
        titleLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(33.px())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: cleanerModel? {
        didSet {
            guard let model = model else { return }
            titleLabel.text = model.asthma ?? ""
            icon.kf.setImage(with: URL(string: model.pic_url ?? ""))
        }
    }
    
}
