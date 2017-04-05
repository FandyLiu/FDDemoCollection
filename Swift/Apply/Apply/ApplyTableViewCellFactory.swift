//
//  ApplyTableViewCellFactory.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/31.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

enum ApplyTableViewCellType {
    case common(CommonTableViewCellType)
    case image(ImageTableViewCellType)
}

class ApplyTableViewCellFactory {
    class func registerApplyTableViewCell(_ tableView: UITableView) {
        register(tableView, cellClass: CommonTableViewCell.self)
        register(tableView, cellClass: ImageTableViewCell.self)
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, indexPath: IndexPath, cellItems: [ApplyTableViewCellType], cellContentDict: [IndexPath]) -> ApplyTableViewCell? {
        
        switch cellItems[indexPath.row] {
        case let .common(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: CommonTableViewCell.self)
            cell?.myType = type
            return cell
        case let .image(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: ImageTableViewCell.self)
            cell?.myType = type
            return cell
        }
    }
    
    class func dequeueReusableCell(withTableView tableView: UITableView, type: ApplyTableViewCellType) -> ApplyTableViewCell? {
        switch type {
        case let .common(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: CommonTableViewCell.self)
            cell?.myType = type
            return cell
        case let .image(type):
            let cell = dequeueReusableCell(withTableView: tableView, cellClass: ImageTableViewCell.self)
            cell?.myType = type
            return cell
        }
    }
    
    
    fileprivate class func register<T: ApplyTableViewCell>(_ tableView: UITableView, cellClass: T.Type) where T: ApplyTableViewCellProtocol {
        tableView.register(cellClass.self, forCellReuseIdentifier: cellClass.indentifier)
    }
    
    fileprivate class func dequeueReusableCell<Cell: ApplyTableViewCell>(withTableView tableView: UITableView,  cellClass: Cell.Type) -> Cell? where Cell: ApplyTableViewCellProtocol {
        return tableView.dequeueReusableCell(withIdentifier: cellClass.indentifier) as? Cell
    }
    
}





