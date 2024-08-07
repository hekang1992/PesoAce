//
//  PLAFaceViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit

class PLAFaceViewController: PLABaseViewController {
    
    lazy var faceView: PLAFaceView = {
        let faceView = PLAFaceView()
        return faceView
    }()
    
    var productID: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(faceView)
        faceView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        faceView.block = { [weak self ] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        faceView.block1 = { [weak self ] btn in
            let idVc = PLAAuThAbcController()
            self?.navigationController?.pushViewController(idVc, animated: true)
        }
        faceView.block2 = { [weak self ] btn in
            
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
