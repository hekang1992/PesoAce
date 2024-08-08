//
//  PLAAuThAbcController.swift
//  PesoAce
//
//  Created by apple on 2024/8/7.
//

import UIKit

class PLAAuThAbcController: UIViewController {
    
    lazy var pVeiw: PLAAuthIdView = {
        let pVeiw = PLAAuthIdView()
        pVeiw.backgroundColor = .white
        pVeiw.titltLabel.text = "Select the document type"
        return pVeiw
    }()
    
    var productID: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(pVeiw)
        pVeiw.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pVeiw.block = { [weak self ] in
            self?.navigationController?.popViewController(animated: true)
        }
        tupianInfo()
    }

}


extension PLAAuThAbcController {
    
    func tupianInfo() {
        ViewHud.addLoadView()
        PLAAFNetWorkManager.shared.requestAPI(params: [:], pageUrl: "/ace/saybut/obstinate/list", method: .post) { baseModel in
            ViewHud.hideLoadView()
        } errorBlock: { error in
            ViewHud.hideLoadView()
        }

    }
    
}
