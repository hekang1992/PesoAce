//
//  PLAAllMoneyViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/11.
//

import UIKit

class PLAAllMoneyViewController: PLABaseViewController {
    
    var productID: String?
    
    lazy var moneyView: PLAAllMoneyView = {
        let moneyView = PLAAllMoneyView()
        return moneyView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(moneyView)
        moneyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        moneyView.block = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
