//
//  PLALoginViewController.swift
//  PesoAce
//
//  Created by apple on 2024/8/4.
//

import UIKit

class PLALoginViewController: PLABaseViewController {
    
    lazy var loginView: PLALoginView = {
        let loginView = PLALoginView()
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
