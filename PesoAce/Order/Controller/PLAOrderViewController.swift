//
//  PLAOrderViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit

class PLAOrderViewController: UIViewController {
    
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
        orderView.block1 = { [weak self] str in
            let vc = PLAOrderListViewController()
            vc.battered = str
            self?.orderView.contentScrollView.addSubview(vc.view)
            self?.listVCArray.append(vc)
            self?.view.setNeedsLayout()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for (index, vc) in listVCArray.enumerated() {
            vc.view.frame = CGRect(x: SCREEN_WIDTH * CGFloat(index), y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - CGRectGetMaxY(orderView.segmentedView.frame))
        }
    }

}
