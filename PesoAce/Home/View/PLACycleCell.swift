//
//  PLACycleCell.swift
//  PesoAce
//
//  Created by 何康 on 2024/8/20.
//

import UIKit
import FSPagerView
import RxRelay
import RxSwift

class PLACycleCell: FSPagerViewCell {
    
    private let disposeBag = DisposeBag()
    
    var model = BehaviorRelay<improvementModel?>(value: nil)
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#2681FB"), textAlignment: .left)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 14.px(), bottom: 0, right: 100.px()))
        }
        model.subscribe(onNext: { [weak self] model in
            if let self = self, let model = model {
                self.nameLabel.text = model.formica ?? ""
            }
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
