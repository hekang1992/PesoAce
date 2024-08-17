//
//  PLAChangeBankView.swift
//  PesoAce
//
//  Created by 何康 on 2024/8/17.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct CleanerSectionModel {
    let millah: String
    var items: [improvementModel]
}

extension CleanerSectionModel: SectionModelType {
    typealias Item = improvementModel
    init(original: CleanerSectionModel, items: [improvementModel]) {
        self = original
        self.items = items
    }
}

class PLAChangeBankView: UIView {
    
    lazy var disp = DisposeBag()
    
    var block: (() -> Void)?
    
    var block1: (() -> Void)?
    
    var block2: ((improvementModel) -> Void)?
    
    var modelArray = BehaviorRelay<[CleanerSectionModel]>(value: [])
    
    let dataSource = RxTableViewSectionedReloadDataSource<CleanerSectionModel>(
        configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "PLAChangeBankCell", for: indexPath) as? PLAChangeBankCell
            if let cell = cell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                let sectionModel = dataSource.sectionModels[indexPath.section]
                cell.naleLabel2.text = sectionModel.millah
                cell.model.accept(item)
            }
            return cell ?? UITableViewCell()
        },
        titleForHeaderInSection: { dataSource, index in
            return nil
        }
    )
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "backimage"), for: .normal)
        return backBtn
    }()
    
    lazy var titltLabel: UILabel = {
        let titleLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 16.px())!, textColor: UIColor.init(css: "#2D2D2D"), textAlignment: .center)
        titleLabel.text = "Bank Card"
        return titleLabel
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
        tableView.register(PLAChangeBankCell.self, forCellReuseIdentifier: "PLAChangeBankCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titltLabel)
        addSubview(backBtn)
        addSubview(tableView)
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
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titltLabel.snp.bottom).offset(8.px())
            make.left.right.bottom.equalToSuperview()
        }
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disp)
        
        modelArray
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disp)
        tableView.rx.modelSelected(CleanerSectionModel.Item.self).subscribe { [weak self] model in
            if let self = self {
                self.block2?(model)
            }
        }.disposed(by: disp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PLAChangeBankView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20.px()
        }else {
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print(">>>>>>>>\(modelArray.value.count)")
        if section == modelArray.value.count - 1 {
            return 56.px()
        }else {
            return 0.01.px()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == modelArray.value.count - 1 {
            let footView = UIView()
            let bgView = UIView()
            let btn = UIButton(type: .custom)
            bgView.backgroundColor = .white
            bgView.layer.cornerRadius = 2.px()
            let icon = UIImageView()
            icon.image = UIImage(named: "Grouaddjia")
            let label = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
            label.text = "Add E-wallet or bank card"
            footView.addSubview(bgView)
            bgView.addSubview(icon)
            bgView.addSubview(label)
            bgView.addSubview(btn)
            bgView.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(15.px())
                make.height.equalTo(56.px())
            }
            icon.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
                make.left.equalToSuperview().offset(24.px())
            }
            label.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.equalTo(16.px())
                make.left.equalTo(icon.snp.right).offset(6.px())
            }
            btn.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            btn.rx.tap.subscribe(onNext: { [weak self] in
                self?.block1?()
            }).disposed(by: disp)
            return footView
        }else {
            return nil
        }
    }
    
}
