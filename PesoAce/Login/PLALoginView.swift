//
//  PLALoginView.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import UIKit

class PLALoginView: PLACommonView {
    
    var block: ((UIButton) -> Void)?
    
    var block1: (() -> Void)?
    
    var xieyiblock: (() -> Void)?
    
    lazy var hiLabel: UILabel = {
        let hiLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 38.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .left)
        hiLabel.text = "HI,"
        return hiLabel
    }()
    
    lazy var hiLabel1: UILabel = {
        let hiLabel1 = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .left)
        hiLabel1.text = "welcome to log in PesoAce"
        return hiLabel1
    }()
    
    lazy var hiLabel2: UILabel = {
        let hiLabel2 = UILabel.createLabel(font: UIFont(name: regular_font, size: 16.px())!, textColor: UIColor.init(css: "#333333"), textAlignment: .left)
        hiLabel2.text = "+63"
        return hiLabel2
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(css: "#333333")
        return lineView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Phone Number", attributes: [
            .foregroundColor: UIColor.init(css: "#B8B8B8") as Any,
            .font: UIFont(name: regular_font, size: 16.px())!
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont(name: regular_font, size: 16.px())
        phoneTx.textColor = UIColor.init(css: "#333333")
        return phoneTx
    }()
    
    lazy var lineView1: UIView = {
        let lineView1 = UIView()
        lineView1.backgroundColor = UIColor.init(css: "#F5F5F5")
        return lineView1
    }()
    
    lazy var codeTx: UITextField = {
        let codeTx = UITextField()
        codeTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "OTP", attributes: [
            .foregroundColor: UIColor.init(css: "#B8B8B8") as Any,
            .font: UIFont(name: regular_font, size: 16.px())!
        ])
        codeTx.attributedPlaceholder = attrString
        codeTx.font = UIFont(name: regular_font, size: 16.px())
        codeTx.textColor = UIColor.init(css: "#333333")
        return codeTx
    }()
    
    lazy var lineView2: UIView = {
        let lineView2 = UIView()
        lineView2.backgroundColor = UIColor.init(css: "#F5F5F5")
        return lineView2
    }()
    
    lazy var sendBtn: UIButton = {
        let sendBtn = UIButton(type: .custom)
        sendBtn.contentHorizontalAlignment = .right
        sendBtn.titleLabel?.font = UIFont(name: regular_font, size: 16.px())
        sendBtn.setTitle("Send OTP", for: .normal)
        sendBtn.setTitleColor(UIColor.init(css: "#2681FB"), for: .normal)
        return sendBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.isEnabled = false
        loginBtn.setTitle("Login/Register", for: .normal)
        loginBtn.backgroundColor = UIColor.init(css: "#F4F7FF")
        return loginBtn
    }()
    
    lazy var xieyibtn: UIButton = {
        let xieyibtn = UIButton(type: .custom)
        xieyibtn.setBackgroundImage(UIImage(named: "Group 1663"), for: .normal)
        return xieyibtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.addSubview(hiLabel)
        scrollView.addSubview(hiLabel1)
        scrollView.addSubview(hiLabel2)
        scrollView.addSubview(lineView)
        scrollView.addSubview(phoneTx)
        scrollView.addSubview(lineView1)
        scrollView.addSubview(codeTx)
        scrollView.addSubview(lineView2)
        scrollView.addSubview(sendBtn)
        scrollView.addSubview(loginBtn)
        scrollView.addSubview(xieyibtn)
        hiLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(26.px())
            make.top.equalToSuperview().offset(DeviceStatusHeightManager.statusBarHeight + 56.px())
            make.height.equalTo(40.px())
        }
        hiLabel1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(hiLabel.snp.bottom).offset(17.px())
            make.height.equalTo(22.px())
        }
        hiLabel2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(35.px())
            make.top.equalTo(hiLabel1.snp.bottom).offset(45.px())
            make.height.equalTo(22.px())
        }
        lineView.snp.makeConstraints { make in
            make.left.equalTo(hiLabel2.snp.right).offset(12.px())
            make.size.equalTo(CGSize(width: 2.px(), height: 11.px()))
            make.top.equalTo(hiLabel2.snp.top).offset(6.px())
        }
        phoneTx.snp.makeConstraints { make in
            make.top.equalTo(hiLabel2.snp.top).offset(-8.px())
            make.width.equalTo(240.px())
            make.left.equalTo(lineView.snp.right).offset(12.px())
            make.centerY.equalTo(hiLabel2.snp.centerY)
        }
        lineView1.snp.makeConstraints { make in
            make.height.equalTo(2.px())
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(phoneTx.snp.bottom).offset(8.px())
            make.centerX.equalToSuperview()
        }
        codeTx.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(25.px())
            make.width.equalTo(210.px())
            make.left.equalToSuperview().offset(24.px())
            make.height.equalTo(22.px())
        }
        lineView2.snp.makeConstraints { make in
            make.height.equalTo(2.px())
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(codeTx.snp.bottom).offset(14.px())
            make.centerX.equalToSuperview()
        }
        sendBtn.snp.makeConstraints { make in
            make.right.equalTo(lineView2.snp.right)
            make.bottom.equalTo(lineView2.snp.top).offset(-14.px())
            make.size.equalTo(CGSize(width: 105.px(), height: 22.px()))
        }
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24.px())
            make.top.equalTo(lineView2.snp.bottom).offset(35.px())
            make.height.equalTo(54.px())
        }
        xieyibtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBtn.snp.bottom).offset(14.px())
            make.size.equalTo(CGSize(width: 309.px(), height: 22.px()))
            make.bottom.equalToSuperview().offset(-50.px())
        }
        
        xieyibtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.xieyiblock?()
        }).disposed(by: disposeBag)
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        phoneTx.rx.text.orEmpty.subscribe(onNext: { [weak self] text in
            if text.count > 0{
                self?.loginBtn.isEnabled = true
                self?.loginBtn.backgroundColor = UIColor.init(css: "#2681FB")
            }else {
                self?.loginBtn.isEnabled = false
                self?.loginBtn.backgroundColor = UIColor.init(css: "#F4F7FF")
            }
        }).disposed(by: disposeBag)
        phoneTx.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                self?.lineView1.backgroundColor = UIColor.init(css: "#2681FB")
            }).disposed(by: disposeBag)
        phoneTx.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] _ in
                self?.lineView1.backgroundColor = UIColor.init(css: "#F5F5F5")
            })
            .disposed(by: disposeBag)
        codeTx.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [weak self] in
                self?.lineView2.backgroundColor = UIColor.init(css: "#2681FB")
            }).disposed(by: disposeBag)
        codeTx.rx.controlEvent(.editingDidEnd)
            .subscribe(onNext: { [weak self] _ in
                self?.lineView2.backgroundColor = UIColor.init(css: "#F5F5F5")
            })
            .disposed(by: disposeBag)
        sendBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.block?(self.sendBtn)
            }
        }).disposed(by: disposeBag)
        
        
        phoneTx
            .rx
            .text
            .orEmpty
            .map { text -> String in
            if text.count > 10 {
                let index = text.index(text.startIndex, offsetBy: 10)
                return String(text[..<index])
            } else {
                return text
            }
        }
        .bind(to: phoneTx.rx.text)
        .disposed(by: disposeBag)
        
        codeTx
            .rx
            .text
            .orEmpty
            .map { text -> String in
            if text.count > 6 {
                let index = text.index(text.startIndex, offsetBy: 6)
                return String(text[..<index])
            } else {
                return text
            }
        }
        .bind(to: codeTx.rx.text)
        .disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
