//
//  PLAMainProCell.swift
//  PesoAce
//
//  Created by apple on 2024/8/14.
//

import UIKit
import RxSwift
import RxCocoa

class PLAMainProCell: UITableViewCell {
    
    let disp = DisposeBag()
    
    var model = BehaviorRelay<improvementModel?>(value: nil)
    
    var picUrlBlock: ((String) -> Void)?
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4.px()
        bgView.backgroundColor = .white
        return bgView
    }()

    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "AppIcon")
        return icon
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 16.px())!, textColor: .black, textAlignment: .left)
        return nameLabel
    }()
    
    lazy var nameLabel1: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 16.px())!, textColor: .black, textAlignment: .right)
        return nameLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(css: "#D9D9D9")
        return lineView
    }()
    
    lazy var nameLabel2: UILabel = {
        let nameLabel = UILabel.createLabel(font: UIFont(name: regular_font, size: 16.px())!, textColor: .black, textAlignment: .left)
        return nameLabel
    }()
    
    lazy var qianLabel: UILabel = {
        let qianLabel = UILabel.createLabel(font: UIFont(name: black_font, size: 30.px())!, textColor: UIColor.init(css: "#F44444"), textAlignment: .left)
        return qianLabel
    }()
    
    lazy var nameLabel3: UILabel = {
        let nameLabel3 = UILabel.createLabel(font: UIFont(name: regular_font, size: 14.px())!, textColor: UIColor.init(css: "#A9A9A9"), textAlignment: .left)
        return nameLabel3
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.layer.cornerRadius = 2.px()
        applyBtn.titleLabel?.font = UIFont(name: regular_font, size: 14.px())
        return applyBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(icon)
        bgView.addSubview(nameLabel)
        bgView.addSubview(nameLabel1)
        bgView.addSubview(nameLabel2)
        bgView.addSubview(lineView)
        bgView.addSubview(qianLabel)
        bgView.addSubview(nameLabel3)
        bgView.addSubview(applyBtn)
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16.px())
            make.centerX.equalToSuperview()
            make.height.equalTo(127.px())
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.constraintPriorityTargetValue)
        }
        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.px())
            make.top.equalToSuperview().offset(16.px())
            make.size.equalTo(CGSize(width: 24.px(), height: 24.px()))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.left.equalTo(icon.snp.right).offset(4)
            make.height.equalTo(16.px())
        }
        nameLabel2.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.right.equalToSuperview().offset(-20.px())
            make.height.equalTo(16.px())
        }
        lineView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 2.px(), height: 12.px()))
            make.right.equalTo(nameLabel2.snp.left).offset(-5.px())
            make.centerY.equalTo(nameLabel2.snp.centerY)
        }
        nameLabel1.snp.makeConstraints { make in
            make.centerY.equalTo(icon.snp.centerY)
            make.right.equalTo(lineView.snp.left).offset(-5.constraintPriorityTargetValue)
            make.height.equalTo(16.px())
        }
        qianLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.px())
            make.top.equalTo(icon.snp.bottom).offset(25.px())
            make.height.equalTo(26.px())
        }
        nameLabel3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20.px())
            make.top.equalTo(qianLabel.snp.bottom).offset(5.px())
            make.height.equalTo(17.px())
        }
        applyBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20.px())
            make.bottom.equalToSuperview().offset(-16.px())
            make.size.equalTo(CGSize(width: 99.px(), height: 41.px()))
        }
        applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            if let self = self {
                self.picUrlBlock?(self.model.value?.bellyaches ?? "")
            }
        }).disposed(by: disp)
        bindModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PLAMainProCell {
    
    
    func bindModel() {
        model.subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            icon.kf.setImage(with: URL(string: model.plans ?? ""), placeholder: UIImage(named: "AppIcon"))
            nameLabel.text = model.mysel ?? ""
            nameLabel2.text = model.wheeled ?? ""
            nameLabel1.text = model.loan_rate ?? ""
            qianLabel.text = model.amountMax ?? ""
            nameLabel3.text = model.loanTermText ?? ""
            applyBtn.setTitle(model.paws ?? "", for: .normal)
            if model.buttonStatus == "Apply" {
                applyBtn.isEnabled = true
                applyBtn.setTitleColor(.white, for: .normal)
                applyBtn.backgroundColor = UIColor.init(css: "#2681FB")
            }else {
                applyBtn.isEnabled = false
                applyBtn.setTitleColor(UIColor.init(css: "#D9D9D9"), for: .normal)
                applyBtn.backgroundColor = UIColor.init(css: "#EEF4FA")
            }
        }).disposed(by: disp)
    }
    
}
