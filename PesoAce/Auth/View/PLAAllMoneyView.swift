//
//  PLAAllMoneyView.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit
import RxSwift

class PLAAllMoneyView: UIView {

    private lazy var disposeBag = DisposeBag()
        
        var block: (() -> Void)?
        var saveBlock: (() -> Void)?
        var scrollDistance: CGFloat = 0
        var modelArray: [cleanerModel]?
        
        private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.scrollsToTop = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.backgroundColor = UIColor(css: "#FFFFFF")
            scrollView.contentSize = CGSize(width: SCREEN_WIDTH * 2, height: 0)
            return scrollView
        }()
        
        private lazy var nextButton: UIButton = {
            return createButton(title: "Submit and next", font: UIFont(name: regular_font, size: 16.px()), backgroundColor: UIColor(css: "#2681FB"))
        }()
        
        private lazy var titleLabel: UILabel = {
            let label = createLabel(text: "Receiving Account", font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor(css: "#2D2D2D"), alignment: .center)
            label.alpha = 0
            return label
        }()
        
        private lazy var cancelButton: UIButton = {
            return createButton(image: UIImage(named: "Group_cc"))
        }()
        
        private lazy var statusView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(css: "#F4F7FF")
            return view
        }()
        
        private lazy var statusLabel: UILabel = {
            return createLabel(text: "Progress: 1/5", font: UIFont(name: regular_font, size: 12.px())!, textColor: UIColor(css: "#2681FB"))
        }()
        
        private lazy var statusLabel1: UILabel = {
            return createLabel(text: "Receiving Account", font: UIFont(name: black_font, size: 24.px())!, textColor: UIColor(css: "#000000"), alignment: .left)
        }()
        
        private lazy var statusLabel2: UILabel = {
            return createLabel(text: "Accurate account info for smooth loan use", font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor(css: "#A9A9A9"), alignment: .left)
        }()
        
        private lazy var loginButton: UIButton = {
            let button = createButton(title: "Submit and next", font: UIFont(name: regular_font, size: 16.px()), backgroundColor: UIColor(css: "#F4F7FF"))
            button.isEnabled = false
            return button
        }()
        
        private lazy var walletButton: UIButton = {
            return createSelectionButton(title: "E-wallet", selected: true)
        }()
        
        private lazy var bankButton: UIButton = {
            return createSelectionButton(title: "Bank", selected: false)
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViewHierarchy()
            setupConstraints()
            setupBindings()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup Methods
        
        private func setupViewHierarchy() {
            addSubview(cancelButton)
            addSubview(titleLabel)
            addSubview(statusView)
            statusView.addSubview(statusLabel)
            addSubview(statusLabel1)
            addSubview(statusLabel2)
            addSubview(walletButton)
            addSubview(bankButton)
            addSubview(scrollView)
        }
        
        private func setupConstraints() {
            cancelButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
                make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
                make.left.equalToSuperview().offset(SCREEN_WIDTH - 48.px())
            }
            
            titleLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 10.px())
                make.height.equalTo(24.px())
            }
            
            statusView.snp.makeConstraints { make in
                make.top.equalTo(cancelButton.snp.bottom).offset(22.px())
                make.size.equalTo(CGSize(width: 89.px(), height: 28.px()))
                make.left.equalToSuperview().offset(24.px())
            }
            
            statusLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            statusLabel1.snp.makeConstraints { make in
                make.top.equalTo(statusLabel.snp.bottom).offset(24.px())
                make.left.equalToSuperview().offset(24.px())
                make.height.equalTo(28.px())
            }
            
            statusLabel2.snp.makeConstraints { make in
                make.top.equalTo(statusLabel1.snp.bottom).offset(9.px())
                make.left.equalToSuperview().offset(20.px())
                make.height.equalTo(28.px())
            }
            
            walletButton.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(24.px())
                make.top.equalTo(statusLabel2.snp.bottom).offset(28.px())
                make.size.equalTo(CGSize(width: 158.px(), height: 56.px()))
            }
            
            bankButton.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-24.px())
                make.top.equalTo(statusLabel2.snp.bottom).offset(28.px())
                make.size.equalTo(CGSize(width: 158.px(), height: 56.px()))
            }
            
            scrollView.snp.makeConstraints { make in
                make.bottom.left.right.equalToSuperview()
                make.top.equalTo(walletButton.snp.bottom).offset(16.px())
            }
        }
        
        private func setupBindings() {
            cancelButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.block?()
                })
                .disposed(by: disposeBag)
            
            walletButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.selectWalletButton()
                })
                .disposed(by: disposeBag)
            
            bankButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.selectBankButton()
                })
                .disposed(by: disposeBag)
        }
        
        // MARK: - Helper Methods
        
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
        
        private func createLabel(text: String, font: UIFont, textColor: UIColor, alignment: NSTextAlignment = .left) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = font
            label.textColor = textColor
            label.textAlignment = alignment
            return label
        }
        
        private func createSelectionButton(title: String, selected: Bool) -> UIButton {
            let button = createButton(title: title, font: UIFont(name: regular_font, size: 16.px()), backgroundColor: UIColor(css: "#F4F7FF"))
            button.layer.borderWidth = 2.px()
            button.layer.borderColor = (selected ? UIColor(css: "#2681FB") : UIColor(css: "#E4E9F6")).cgColor
            button.setTitleColor(selected ? UIColor(css: "#2681FB") : UIColor(css: "#ACB7D6"), for: .normal)
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


extension PLAAllMoneyView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y + scrollView.adjustedContentInset.top
        let alpha = max(0, min(1, offset / 160.px()))
        self.titleLabel.alpha = alpha
    }

}
