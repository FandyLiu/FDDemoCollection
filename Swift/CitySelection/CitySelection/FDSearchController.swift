//
//  FDSearchController.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/25.
//  Copyright © 2017年 fandy. All rights reserved.
//  搜索控制器

import UIKit

class FDSearchController: UISearchController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)

        dimsBackgroundDuringPresentation = true
        //        searchController.obscuresBackgroundDuringPresentation = true
        hidesNavigationBarDuringPresentation = true
        searchBar.placeholder = "城市/行政区/拼音";
        searchBar.searchBarStyle = .prominent
        searchBar.returnKeyType = .done
        searchBar.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FDSearchController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        let btn = searchBar.value(forKey: "_cancelButton") as! UIButton
        btn.setTitle("取消", for: .normal)
        return true
    }
    

}
