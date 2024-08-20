//
//  PLAMainHomeView.swift
//  PesoAce
//
//  Created by apple on 2024/8/14.
//

import UIKit
import GKCycleScrollView
import RxSwift
import RxCocoa
import FSPagerView

class PLAMainHomeView: UIView {
    
    var modelArray = BehaviorRelay<[improvementModel]>(value: [])
    
    var picBlock: ((String) -> Void)?
    
    var picBlock1: ((String) -> Void)?
    
    var proUrlBlock: ((String) -> Void)?
    
    var leftBolck: (() -> Void)?
    
    var rightBolck: (() -> Void)?
    
    var overdueArray = BehaviorRelay<[improvementModel]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    lazy var topImageView: UIView = {
        let topImageView = UIView()
        topImageView.backgroundColor = UIColor.init(css: "#2681FB")
        return topImageView
    }()
    
    lazy var leftBtn: UIButton = {
        let leftBtn = UIButton(type: .custom)
        leftBtn.adjustsImageWhenDisabled = false
        leftBtn.setBackgroundImage(UIImage(named: "ffGrouleff"), for: .normal)
        return leftBtn
    }()
    
    lazy var rightBtn: UIButton = {
        let rightBtn = UIButton(type: .custom)
        rightBtn.adjustsImageWhenDisabled = false
        rightBtn.setBackgroundImage(UIImage(named: "Groupjhefu7"), for: .normal)
        return rightBtn
    }()
    
    lazy var bannerView: GKCycleScrollView = {
        let bannerView = GKCycleScrollView()
        bannerView.delegate = self
        bannerView.dataSource = self
        bannerView.minimumCellAlpha = 0.0;
        return bannerView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.estimatedRowHeight = 80.px()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(css: "#F6F6F7")
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(PLAMainProCell.self, forCellReuseIdentifier: "PLAMainProCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topImageView)
        topImageView.addSubview(leftBtn)
        topImageView.addSubview(rightBtn)
        addSubview(tableView)
        topImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(DeviceStatusHeightManager.statusBarHeight + 44.px())
        }
        leftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.px())
            make.bottom.equalToSuperview().offset(-10.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24.px())
            make.bottom.equalToSuperview().offset(-10.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topImageView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        modelArray.bind(to: tableView.rx.items(cellIdentifier: "PLAMainProCell", cellType: PLAMainProCell.self)) { [weak self] (row, element, cell) in
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.model.accept(self?.modelArray.value[row])
            cell.picUrlBlock = { [weak self] proid in
                self?.proUrlBlock?(proid)
            }
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            print("indexPath>>>>>\(indexPath.row)")
            let model = self?.modelArray.value[indexPath.row]
            self?.proUrlBlock?(model?.bellyaches ?? "")
        }).disposed(by: disposeBag)
        
        leftBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.leftBolck?()
        }).disposed(by: disposeBag)
        rightBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.rightBolck?()
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var bannerArray: [improvementModel]? {
        didSet {
            bannerView.reloadData()
        }
    }
    
}


extension PLAMainHomeView: GKCycleScrollViewDelegate, GKCycleScrollViewDataSource, UITableViewDelegate, FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfCells(in cycleScrollView: GKCycleScrollView!) -> Int {
        return bannerArray?.count ?? 0
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView, cellForViewAt index: Int) -> GKCycleScrollViewCell {
        let cell = GKCycleScrollViewCell()
        let model = bannerArray?[index]
        let picUrl = model?.margalla ?? ""
        cell.imageView.kf.setImage(with: URL(string: picUrl))
        return cell
    }
    
    func cycleScrollView(_ cycleScrollView: GKCycleScrollView, didSelectCellAt index: Int) {
        let model = bannerArray?[index]
        let prcUrl = model?.minarets ?? ""
        self.picBlock?(prcUrl)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 155.px() + 13.px() + 56.px()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        let pagerView = FSPagerView()
        let icon = UIImageView()
        icon.image = UIImage(named: "Groupbuleda")
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(PLACycleCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.backgroundColor = .white
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 2.0
        pagerView.transformer = FSPagerViewTransformer(type: .crossFading)
        headView.addSubview(bannerView)
        headView.addSubview(pagerView)
        headView.addSubview(icon)
        bannerView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(139.px())
        }
        pagerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16.px())
            make.top.equalTo(bannerView.snp.bottom).offset(13.px())
            make.height.equalTo(56.px())
        }
        icon.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-32.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
            make.centerY.equalTo(pagerView.snp.centerY)
        }
        pagerView.reloadData()
        return headView
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return overdueArray.value.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! PLACycleCell
        let model = overdueArray.value[index]
        cell.model.accept(model)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let model = overdueArray.value[index]
        self.picBlock1?(model.minarets ?? "")
    }
    
}


