//
//  ApplyBaseViewController.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyBaseViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }

    func setupUI() {
        view.addSubview(tableView)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.indentifier)
        tableView.rowHeight = 50.0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let headView = HeadViewCell(title: "3333")
        headView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 118)
        headView.title = "wfwefwewefef"
        tableView.tableHeaderView = headView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["tableView": tableView]))
    }

}

extension ApplyBaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

extension ApplyBaseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.indentifier) as! CustomTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.myType = .describe(title: "商户负责人信息", subtitle: "（与营业执照法人姓名相同）")
        case 1:
            cell.myType = .input0(title: "你你：", placeholder: "请输入邮箱地址")
        case 2:
            cell.myType = .input0(title: "你你：", placeholder: "请输入邮箱地址")
        case 3:
            cell.myType = .input0(title: "你你你：", placeholder: "请输入邮箱地址")
        case 4:
            cell.myType = .input0(title: "你你你你：", placeholder: "请输入邮箱地址")
        default:
            cell.myType = .input0(title: "你你：", placeholder: "请输入邮箱地址")
        }
        

        return cell
    }

}
