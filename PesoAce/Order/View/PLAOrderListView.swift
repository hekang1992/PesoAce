//
//  PLAOrderListView.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit

class PLAOrderListView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(PLAOrderListNormalCell.self, forCellReuseIdentifier: "PLAOrderListNormalCell")
        tableView.register(PLAOrderListCell.self, forCellReuseIdentifier: "PLAOrderListCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PLAOrderListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAOrderListNormalCell", for: indexPath) as? PLAOrderListNormalCell {
            return cell
        }
        return UITableViewCell()
    }
    
    
}
