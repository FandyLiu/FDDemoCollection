//
//  ChooseViewController.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/22.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {
    
    fileprivate static let reuseIdentifier = "common"
    
    fileprivate var selectHandle: ((String) -> ())

    /// tableView
    fileprivate lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionIndexBackgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        tableView.sectionIndexColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tableView.tableHeaderView = self.searchController.searchBar
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.register(TitleHeadView.self, forHeaderFooterViewReuseIdentifier: TitleHeadView.reuseIdentifier)
        return tableView
    }()
    
    ///  搜索控制器
    fileprivate lazy var searchController: UISearchController = { [unowned self] in
        let searchController = FDSearchController(searchResultsController: self.searchResultsController)
        searchController.searchResultsUpdater = self
        return searchController
    }()
    
    /// 搜索结果控制器
    fileprivate lazy var searchResultsController: FDSearchResultController = { [unowned self] in
        let searchResultController = FDSearchResultController()
        searchResultController.delegate = self
        return searchResultController
    }()
    /// 当前城市
    fileprivate var currentCity: String {
        return ChooseViewModel.shareInstance.currentCity
    }
    
    /// 全部数据源
    fileprivate var cityDataTupleArray: CityDataTupleArray {
        return ChooseViewModel.shareInstance.cityDataTupleArray
    }
    
    fileprivate var allCityArray: [String] {
        return  ChooseViewModel.shareInstance.allCityArray
    }
    fileprivate var allCityPinYinArray: [String] {
        return  ChooseViewModel.shareInstance.allPinYinCityArray
    }
    
    init(selectHandle: @escaping (String) -> ()) {
        self.selectHandle = selectHandle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        FDLocationManager.startUpdatingLocation({[weak self] (err) in
            print(err.description)
            if err == .denied {
                guard let strongSelf = self else { return }
                let vc = FDLocationManager.defaultAlertController()
                strongSelf.present(vc, animated: true, completion: nil)
            }
        }) {[weak self] (str) in
            ChooseViewModel.shareInstance.currentCity = str
//            let indexSet = IndexSet(integer: 0)
//            self.tableView.reloadSections(indexSet, with: .none)
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
    }
    
    fileprivate func popViewController(_ selectCity: String) {
        selectHandle(selectCity)
        navigationController?.popViewController(animated: true)
    }

}



// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChooseViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - cell
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityDataTupleArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 3 {
            return 1
        }else {
            return cityDataTupleArray[section].1.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier) as! CityTableViewCell
            cell.cityArray = cityDataTupleArray[indexPath.section].1
            cell.delegate = self
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChooseViewController.reuseIdentifier)!
            cell.textLabel?.text = cityDataTupleArray[indexPath.section].1[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < 3 {
            return CityTableViewCell.getCellHeight(cityDataTupleArray[indexPath.section].1)
        }else {
            return 44
        }
    }
    
    // MARK: - header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeadView.reuseIdentifier) as! TitleHeadView
        switch section {
        case 0:
            headView.title = "当前城市"
        case 1:
            headView.title = "最近城市"
        case 2:
            headView.title = "热门城市"
        default:
            headView.title = cityDataTupleArray[section].0
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = cityDataTupleArray[indexPath.section].1[indexPath.row]
        popViewController(text)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let indexTitles = cityDataTupleArray.map { return $0.0 }
        return indexTitles
    }
    
}


// MARK: - CityTableViewCellDelegate
extension ChooseViewController: CityTableViewCellDelegate {
    func cityTableViewCell(_ cityTableViewCell: CityTableViewCell, didSelectItemWith text: String) {
        popViewController(text)
    }
}

// MARK: - FDSearchResultControllerDelegate
extension ChooseViewController: FDSearchResultControllerDelegate {
    func searchResultController(_ searchResultController: FDSearchResultController, didSelectItemWith text: String) {
        searchController.dismiss(animated: true, completion: nil)
        popViewController(text)
    }
}



// MARK: - UISearchResultsUpdating
extension ChooseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        FDSearchTool.getSearchResult(by: searchString, dataList: allCityArray, dataPinYinList: allCityPinYinArray) { [weak self] (searchList) in
            guard let strongSelf = self else { return }
            strongSelf.searchResultsController.dataSource = searchList
            strongSelf.searchResultsController.tableView.reloadData()
        }
    }
}

