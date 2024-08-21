//
//  PLAPersonInfoXView.swift
//  PesoAce
//
//  Created by apple on 2024/8/10.
//

import UIKit
import RxSwift
import RxCocoa

class PLAPersonInfoXView: UIView {
    
    lazy var disp = DisposeBag()
    
    var block: (() -> Void)?
    
    var block1: ((UIButton, lumModel) -> Void)?
    
    var block3: ((UIButton, lumModel) -> Void)?
    
    var block4: ((UIButton, lumModel) -> Void)?
    
    var saveblock: (() -> Void)?
    
    var scrollDistance: CGFloat = 0
    
    var modelArray: [lumModel]?
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.contentHorizontalAlignment = .center
        nextBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        nextBtn.setTitle("Submit and next", for: .normal)
        nextBtn.backgroundColor = UIColor.init(css: "#2681FB")
        nextBtn.setTitleColor(.white, for: .normal)
        return nextBtn
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#2D2D2D"), textAlignment: .center)
        titleLabel.text = "Personal Infomation"
        titleLabel.alpha = 0
        return titleLabel
    }()
    
    lazy var canBtn: EXButton = {
        let canBtn = EXButton(type: .custom)
        canBtn.hitTestEdgeInsets = UIEdgeInsets(top: -10.px(), left: -10.px(), bottom: -10.px(), right: -10.px())
        canBtn.setBackgroundImage(UIImage(named: "Group_cc"), for: .normal)
        return canBtn
    }()
    
    lazy var stView: UIView = {
        let stView = UIView()
        stView.backgroundColor = UIColor.init(css: "#F4F7FF")
        return stView
    }()
    
    lazy var stLabel: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 12.px())!, textColor: UIColor.init(css: "#2681FB"), textAlignment: .center)
        stLabel.text = "Progress: 1/5"
        return stLabel
    }()
    
    lazy var stLabel1: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 24.px())!, textColor: UIColor.init(css: "#000000"), textAlignment: .left)
        stLabel.text = "Personal Infomation"
        return stLabel
    }()
    
    lazy var stLabel2: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        stLabel.text = "Please fill in true and valid information."
        return stLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.px()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(PLAShuRuKuangCell.self, forCellReuseIdentifier: "PLAShuRuKuangCell")
        tableView.register(PLAAnNiuCell.self, forCellReuseIdentifier: "PLAAnNiuCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        canBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disp)
        tableView.rx.contentOffset
            .map { offset in
                let adjustedOffset = offset.y + self.tableView.adjustedContentInset.top
                return max(0, min(1, adjustedOffset / 160.px()))
            }
            .bind(to: titleLabel.rx.alpha)
            .disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension PLAPersonInfoXView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let modelArray = modelArray, !modelArray.isEmpty {
            return modelArray.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let modelArray = modelArray,!modelArray.isEmpty else { return UITableViewCell() }
        let model = modelArray[indexPath.row]
        switch model.pendu {
        case "themselves1":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAAnNiuCell", for: indexPath) as? PLAAnNiuCell {
                cell.model.accept(model)
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.block = { [weak self] btn in
                    self?.endEditing(true)
                    if model.significant?[0].significant != nil {
                        self?.block4?(btn, model)
                    }else {
                        self?.block1?(btn, model)
                    }
                }
                return cell
            }
        case "themselves2":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAShuRuKuangCell", for: indexPath) as? PLAShuRuKuangCell {
                cell.model.accept(model)
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                return cell
            }
        case "themselves3":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAAnNiuCell", for: indexPath) as? PLAAnNiuCell {
                cell.model.accept(model)
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.block = { [weak self] btn in
                    self?.endEditing(true)
                    self?.block3?(btn, model)
                }
                return cell
            }
        case "themselves4":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAAnNiuCell", for: indexPath) as? PLAAnNiuCell {
                cell.model.accept(model)
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.block = { [weak self] btn in
                    self?.endEditing(true)
                    self?.block4?(btn, model)
                }
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
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
        if let modelArray = modelArray, !modelArray.isEmpty {
            let headView = UIView()
            let imageView = UIImageView()
            imageView.image = UIImage(named: "Grouserff")
            headView.addSubview(imageView)
            headView.addSubview(nextBtn)
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
            nextBtn.rx.tap.subscribe(onNext: { [weak self] in
                self?.saveblock?()
            }).disposed(by: disp)
            return headView
        }else {
            return nil
        }
    }
    
}
