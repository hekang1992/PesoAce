//
//  PLAAllMoneyView.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit
import RxSwift
import RxCocoa

class PLAAllMoneyView: UIView {
    
    private lazy var disposeBag = DisposeBag()
    
    var block: (() -> Void)?
    
    var block1: ((UIButton, lumModel) -> Void)?
    
    var block3: ((UIButton, lumModel) -> Void)?
    
    var block4: ((UIButton, lumModel) -> Void)?
    
    var saveblock: ((Int) -> Void)?
    
    var scrollDistance: CGFloat = 0
    
    var index: Int = 0
    
    var wallArray: [lumModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var modelArray: [lumModel]? {
        didSet {
            guard let modelArray = modelArray else { return }
            wallArray = modelArray.first?.lum
        }
    }
    
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
        titleLabel.text = "Receiving Account"
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
        stLabel.text = "Receiving Account"
        return stLabel
    }()
    
    lazy var stLabel2: UILabel = {
        let stLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        stLabel.text = "Please fill in true and valid information."
        return stLabel
    }()
    
    lazy var walletButton: UIButton = {
        return createSelectionButton(title: "E-wallet", selected: true)
    }()
    
    lazy var bankButton: UIButton = {
        return createSelectionButton(title: "Bank", selected: false)
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
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PLAAllMoneyView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let wallArray = wallArray, !wallArray.isEmpty {
            return wallArray.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let wallArray = wallArray,!wallArray.isEmpty else { return UITableViewCell() }
        let model = wallArray[indexPath.row]
        switch model.pendu {
        case "themselves1":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAAnNiuCell", for: indexPath) as? PLAAnNiuCell {
                cell.model.accept(model)
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.block = { [weak self] btn in
                    self?.endEditing(true)
                    self?.block1?(btn, model)
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
        headView.addSubview(walletButton)
        headView.addSubview(bankButton)
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
        walletButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(stLabel2.snp.bottom).offset(28.px())
            make.size.equalTo(CGSize(width: 158.px(), height: 56.px()))
        }
        bankButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24.px())
            make.top.equalTo(stLabel2.snp.bottom).offset(28.px())
            make.size.equalTo(CGSize(width: 158.px(), height: 56.px()))
        }
        walletButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.index = 0
                self?.wallArray = self?.modelArray?.first?.lum
                self?.selectWalletButton()
            })
            .disposed(by: disposeBag)
        
        bankButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.index = 1
                self?.wallArray = self?.modelArray?.last?.lum
                self?.selectBankButton()
            })
            .disposed(by: disposeBag)
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230.px()
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
                if let self = self {
                    self.saveblock?(self.index)
                }
            }).disposed(by: disposeBag)
            return headView
        }else {
            return nil
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.adjustedContentInset.top
        let alpha = max(0, min(1, offset / 160.px()))
        self.titleLabel.alpha = alpha
    }
    
    private func createSelectionButton(title: String, selected: Bool) -> UIButton {
        let button = createButton(title: title, font: UIFont(name: regular_font, size: 16.px()), backgroundColor: UIColor(css: "#F4F7FF"))
        button.layer.borderWidth = 2.px()
        button.layer.borderColor = (selected ? UIColor(css: "#2681FB") : UIColor(css: "#E4E9F6")).cgColor
        button.setTitleColor(selected ? UIColor(css: "#2681FB") : UIColor(css: "#ACB7D6"), for: .normal)
        return button
    }
    
    private func createButton(title: String? = nil, font: UIFont? = nil, backgroundColor: UIColor? = nil, image: UIImage? = nil) -> UIButton {
        let button = UIButton(type: .custom)
        if let title = title {
            button.setTitle(title, for: .normal)
        }
        if let font = font {
            button.titleLabel?.font = font
        }
        if let backgroundColor = backgroundColor {
            button.backgroundColor = backgroundColor
        }
        if let image = image {
            button.setBackgroundImage(image, for: .normal)
        }
        return button
    }
    
    private func selectWalletButton() {
        updateSelectionButtons(isWalletSelected: true)
    }
    
    private func selectBankButton() {
        updateSelectionButtons(isWalletSelected: false)
    }
    
    private func updateSelectionButtons(isWalletSelected: Bool) {
        walletButton.layer.borderColor = (isWalletSelected ? UIColor(css: "#2681FB") : UIColor(css: "#E4E9F6")).cgColor
        walletButton.setTitleColor(isWalletSelected ? UIColor(css: "#2681FB") : UIColor(css: "#ACB7D6"), for: .normal)
        bankButton.layer.borderColor = (isWalletSelected ? UIColor(css: "#E4E9F6") : UIColor(css: "#2681FB")).cgColor
        bankButton.setTitleColor(isWalletSelected ? UIColor(css: "#ACB7D6") : UIColor(css: "#2681FB"), for: .normal)
    }
    
}

