//
//  PLACommonView.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import UIKit
import RxSwift
import RxCocoa

class PLACommonView: UIView {
    
    lazy var disposeBag = {
        return DisposeBag()
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    lazy var bgIcon: UIImageView = {
        let bgIcon = UIImageView()
        bgIcon.image = UIImage(named: "Group_1")
        return bgIcon
    }()

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(bgIcon)
        bgView.addSubview(scrollView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgIcon.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(367.px())
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



