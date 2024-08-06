//
//  PLAOrderView.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit
import RxSwift
import JXSegmentedView

class PLAOrderView: UIView {
    
    var segmentedDataSource: JXSegmentedTitleDataSource!
    
    lazy var disp = DisposeBag()
    
    var block: (() -> Void)?
    
    var block1: ((String) -> Void)?
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "backimage"), for: .normal)
        return backBtn
    }()
    
    lazy var titltLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 16.px())!, textColor: UIColor.init(css: "#2D2D2D"), textAlignment: .center)
        return titleLabel
    }()
    
    lazy var segmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        segmentedView.delegate = self
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = ["All", "Ongoing", "Pending", "Completed", "Failure"]
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titleNormalFont = UIFont(name: black_font, size: 14.px())!
        segmentedDataSource.titleSelectedFont = UIFont(name: black_font, size: 14.px())!
        segmentedDataSource.titleNormalColor = UIColor.init(css: "#A9A9A9")
        segmentedDataSource.titleSelectedColor = UIColor.init(css: "#222222")
        segmentedView.dataSource = segmentedDataSource
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.lineStyle = .lengthen
        indicator.indicatorHeight = 3.px()
        indicator.indicatorColor = UIColor.init(css: "#2D2D2D")
        segmentedView.indicators = [indicator]
        segmentedView.contentScrollView = contentScrollView
        return segmentedView
    }()
    
    lazy var contentScrollView: UIScrollView = {
        contentScrollView = UIScrollView()
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.contentSize = CGSize(width: SCREEN_WIDTH * 5, height: 0)
        return contentScrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titltLabel)
        addSubview(backBtn)
        addSubview(segmentedView)
        addSubview(contentScrollView)
        titltLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(24.px())
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
        }
        backBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titltLabel.snp.centerY)
            make.left.equalToSuperview().offset(28.px())
            make.size.equalTo(CGSize(width: 16.px(), height: 16.px()))
        }
        segmentedView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titltLabel.snp.bottom).offset(10.px())
            make.height.equalTo(56.px())
        }
        contentScrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(segmentedView.snp.bottom)
        }
        backBtn.rx.tap.subscribe(onNext: { [weak self ] in
            self?.block?()
        }).disposed(by: disp)
        DispatchQueue.main.async {
            self.segmentedView(self.segmentedView, didSelectedItemAt: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PLAOrderView: JXSegmentedViewDelegate, UIScrollViewDelegate {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.block1?(String(index + 4))
    }
    
}
