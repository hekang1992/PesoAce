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
