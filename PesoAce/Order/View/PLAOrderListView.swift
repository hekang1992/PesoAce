//
//  PLAOrderListView.swift
//  PesoAce
//
//  Created by apple on 2024/8/6.
//

import UIKit

class PLAOrderListView: UIView {
    
    var modelArray: [cleanerModel]?
    
    var block: ((String) -> Void)?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.px()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(css: "#F6F6F7")
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelArray?[indexPath.row]
        if let typeStr = model?.paws, !typeStr.isEmpty {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAOrderListCell", for: indexPath) as? PLAOrderListCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model = modelArray?[indexPath.row]
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PLAOrderListNormalCell", for: indexPath) as? PLAOrderListNormalCell {
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                cell.model = modelArray?[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = modelArray?[indexPath.row] {
            self.block?(model.thwiiiiit ?? "")
        }
    }
    
}
