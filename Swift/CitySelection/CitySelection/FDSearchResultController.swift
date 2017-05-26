//
//  FDSearchResultController.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/25.
//  Copyright © 2017年 fandy. All rights reserved.
//  搜索结果控制器

import UIKit

protocol FDSearchResultControllerDelegate: NSObjectProtocol {
    func searchResultController(_ searchResultController: FDSearchResultController, didSelectItemWith text: String)
}

class FDSearchResultController: UITableViewController {
    private static let reuseIdentifier = "reuseIdentifier"

    weak var delegate: FDSearchResultControllerDelegate?
    
    var dataSource: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: FDSearchResultController.reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FDSearchResultController.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)
        delegate?.searchResultController(self, didSelectItemWith: dataSource[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }


}
