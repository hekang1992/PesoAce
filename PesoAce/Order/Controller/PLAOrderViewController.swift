//
//  PLAOrderViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit

class PLAOrderViewController: PLABaseViewController {
    
    lazy var orderView: PLAOrderView = {
        let orderView = PLAOrderView()
        orderView.backgroundColor = .white
        orderView.titltLabel.text = "Orders"
        return orderView
    }()
    
    var listVCArray = [PLAOrderListViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(orderView)
        orderView.block = { [weak self ] in
            self?.navigationController?.popViewController(animated: true)
        }
        orderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        for vc in listVCArray {
            vc.view.removeFromSuperview()
        }
        listVCArray.removeAll()
        for _ in 0..<5 {
            let vc = PLAOrderListViewController()
            orderView.contentScrollView.addSubview(vc.view)
            vc.block = { [weak self] url in
                if let self = self {
                    JudgeConfig.judue(url, from: self)
                }
            }
            listVCArray.append(vc)
        }
        listVCArray.first?.orderListPage("4")
        orderView.block1 = { [weak self] str, index in
            var type: String?
            if str == "4" {
                type = "4"
            }else if str == "5" {
                type = "6"
            }else if str == "6" {
                type = "8"
            }else if str == "7" {
                type = "7"
            }else if str == "8" {
                type = "5"
            }else {}
            self?.listVCArray[index].orderListPage(type ?? "")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for (index, vc) in listVCArray.enumerated() {
            vc.view.frame = CGRect(x: SCREEN_WIDTH * CGFloat(index), y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - CGRectGetMaxY(orderView.segmentedView.frame))
        }
    }

}
