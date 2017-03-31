//
//  ApplyBaseViewController.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

enum ApplyHeadViewStyle {
    case none
    case custom(titles: [String])
    case segmented(images: [String])
}


class ApplyBaseViewController: UIViewController {
    
    var headViewStyle: ApplyHeadViewStyle = .none {
        didSet {
            switch headViewStyle {
            case let .custom(titles: titles):
                tableView.tableHeaderView = CustomHeadView(titles: titles)
            case let .segmented(images: images):
                let segmentor = SegmentedHeadView(images: images)
                segmentor.delegate = self
                tableView.tableHeaderView = segmentor
            default: break
            }
            guard let headView = tableView.tableHeaderView as? ApplyHeadView else {
                return
            }
            var height = headView.headViewHeight
            if  let headView = headView as? CustomHeadView {
                height = headView.headViewHeight
            }else if let headView = headView as? SegmentedHeadView  {
                height = headView.headViewHeight
            }
            
            headView.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraint(NSLayoutConstraint(item: headView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: tableView, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0.0))
            headView.addConstraint(NSLayoutConstraint(item: headView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 0.0, constant: height))
            headView.setNeedsLayout()
            headView.layoutIfNeeded()
            tableView.tableHeaderView = headView
        }
    }
    
    var cellItems: [CustomTableViewCellType] = [CustomTableViewCellType]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.rowHeight = 50.0
        tableView.backgroundColor = COLOR_efefef
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.indentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
    }

    func setupUI() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["tableView": tableView]))
    }
}

extension ApplyBaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else {
            return 0.1
        }
        switch headViewStyle {
        case .custom:
            return 10
        default:
            return 0.1
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension ApplyBaseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.indentifier) as! CustomTableViewCell
        cell.myType = cellItems[indexPath.row]
        return cell
    }
}

extension ApplyBaseViewController: ApplyHeadViewDelegate {
    func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        print(index)
    }
}
