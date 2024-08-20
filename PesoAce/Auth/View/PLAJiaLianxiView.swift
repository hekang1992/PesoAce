//
//  PLAJiaLianxiView.swift
//  PesoAce
//
//  Created by 何康 on 2024/8/17.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources

class PLAJiaLianxiView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var block: (() -> Void)?
    
    var saveblock: (() -> Void)?
    
    var scrollDistance: CGFloat = 0
    
    var block1: ((UIButton, cleanerModel) -> Void)?
    
    var block2: ((UIButton, cleanerModel) -> Void)?
    
    var modelArray = BehaviorRelay<[cleanerModel]>(value: [])
    
    lazy var nextBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.contentHorizontalAlignment = .center
        button.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        button.setTitle("Submit and next", for: .normal)
        button.backgroundColor = UIColor(css: "#2681FB")
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor(css: "#2D2D2D"), textAlignment: .center)
        label.text = "Contacts Information"
        label.alpha = 0
        return label
    }()
    
    lazy var canBtn: EXButton = {
        let canBtn = EXButton(type: .custom)
        canBtn.hitTestEdgeInsets = UIEdgeInsets(top: -10.px(), left: -10.px(), bottom: -10.px(), right: -10.px())
        canBtn.setBackgroundImage(UIImage(named: "Group_cc"), for: .normal)
        return canBtn
    }()
    
    lazy var stView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(css: "#F4F7FF")
        return view
    }()
    
    lazy var stLabel: UILabel = {
        let label = UILabel.createLabel(font: UIFont(name: regular_font, size: 12.px())!, textColor: UIColor(css: "#2681FB"), textAlignment: .center)
        return label
    }()
    
    lazy var stLabel1: UILabel = {
        let label = UILabel.createLabel(font: UIFont(name: black_font, size: 24.px())!, textColor: UIColor(css: "#000000"), textAlignment: .left)
        label.text = "Contacts Information"
        return label
    }()
    
    lazy var stLabel2: UILabel = {
        let label = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor(css: "#A9A9A9"), textAlignment: .left)
        label.text = "After you select it, you can't modify it"
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.estimatedRowHeight = 80.px()
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(PLALxiCell.self, forCellReuseIdentifier: "PLALxiCell")
        tableView.register(PLAShuRuKuangCell.self, forCellReuseIdentifier: "PLAShuRuKuangCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(canBtn)
        addSubview(titleLabel)
        addSubview(tableView)
        
        canBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
            make.left.equalToSuperview().offset(SCREEN_WIDTH - 48.px())
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
            make.height.equalTo(24.px())
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(canBtn.snp.bottom).offset(22.px())
        }
    }
    
    private func setupBindings() {
        modelArray
            .asObservable()
            .bind(to: tableView.rx.items) { tableView, index, model in
                if model.pendu != nil {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAShuRuKuangCell", for: IndexPath(row: index, section: 0)) as? PLAShuRuKuangCell {
                        cell.titleLabel.text = model.faisal ?? ""
                        cell.selectionStyle = .none
                        cell.backgroundColor = .clear
                        cell.ffmodel.accept(model)
                        return cell
                    }
                }else {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "PLALxiCell", for: IndexPath(row: index, section: 0)) as? PLALxiCell {
                        cell.selectionStyle = .none
                        cell.backgroundColor = .clear
                        cell.model.accept(model)
                        cell.block1 = { [weak self] btn, model in
                            self?.block1?(btn, model)
                        }
                        cell.block2 = { [weak self] btn, model in
                            self?.block2?(btn, model)
                        }
                        return cell
                    }
                }
                return UITableViewCell()
            }
            .disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .map { offset in
                let adjustedOffset = offset.y + self.tableView.adjustedContentInset.top
                return max(0, min(1, adjustedOffset / 160.px()))
            }
            .bind(to: titleLabel.rx.alpha)
            .disposed(by: disposeBag)
    
        canBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.block?()
            })
            .disposed(by: disposeBag)
        
        nextBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.saveblock?()
            })
            .disposed(by: disposeBag)
    }
}

extension PLAJiaLianxiView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.addSubview(stView)
        stView.addSubview(stLabel)
        headView.addSubview(stLabel1)
        headView.addSubview(stLabel2)
        
        stView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 89.px(), height: 28.px()))
            make.left.equalToSuperview().offset(24.px())
        }
        
        stLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stLabel1.snp.makeConstraints { make in
            make.top.equalTo(stLabel.snp.bottom).offset(24.px())
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(28.px())
        }
        
        stLabel2.snp.makeConstraints { make in
            make.top.equalTo(stLabel1.snp.bottom).offset(9.px())
            make.left.equalToSuperview().offset(20.px())
            make.height.equalTo(28.px())
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140.px()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120.px()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if !modelArray.value.isEmpty {
            let footerView = UIView()
            let imageView = UIImageView()
            imageView.image = UIImage(named: "Grouserff")
            footerView.addSubview(imageView)
            footerView.addSubview(nextBtn)
            
            imageView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 160.px(), height: 20.px()))
                make.top.equalToSuperview().offset(16.px())
            }
            
            nextBtn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(imageView.snp.bottom).offset(12.px())
                make.size.equalTo(CGSize(width: 312.px(), height: 57.px()))
            }
            
            return footerView
        } else {
            return nil
        }
    }
}

