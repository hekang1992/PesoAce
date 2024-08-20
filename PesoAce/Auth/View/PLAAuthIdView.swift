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
    
    var clickblock: ((cleanerModel) -> Void)?
    
    lazy var canBtn: EXButton = {
        let canBtn = EXButton(type: .custom)
        canBtn.hitTestEdgeInsets = UIEdgeInsets(top: -10.px(), left: -10.px(), bottom: -10.px(), right: -10.px())
        canBtn.setBackgroundImage(UIImage(named: "Group_cc"), for: .normal)
        return canBtn
    }()
    
    lazy var titltLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 16.px())!, textColor: UIColor.init(css: "#2D2D2D"), textAlignment: .center)
        return titleLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: SCREEN_WIDTH / 2 - 34.px(), height: 134.px())
        layout.sectionInset = UIEdgeInsets(top: 0, left: 17.px(), bottom: 0, right: 17.px())
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PLACollectionViewCell.self, forCellWithReuseIdentifier: "PLACollectionViewCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titltLabel)
        addSubview(canBtn)
        addSubview(collectionView)
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
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titltLabel.snp.bottom).offset(12.px())
        }
        
        canBtn.rx.tap.subscribe(onNext: { [weak self ] in
            self?.block?()
        }).disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var modelArray: [cleanerModel]?
    
}

extension PLAAuthIdView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PLACollectionViewCell", for: indexPath) as? PLACollectionViewCell else {
            fatalError("PLACollectionViewCell")
        }
        cell.model = modelArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = modelArray?[indexPath.row] {
            self.clickblock?(model)
        }
    }
    
}
