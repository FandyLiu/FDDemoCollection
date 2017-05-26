//
//  ChooseViewModel.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/23.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit


typealias CityDataTupleArray = [(String, [String])]


class ChooseViewModel {
    static let shareInstance = ChooseViewModel()
    
    private init() {
        cityDataTupleArray = CityDataTupleArray()
        allCityArray = [String]()
        allPinYinCityArray = [String]()
        
        upDateCityDataTupleArray()
        
    }
    
    var currentCity = "未知" {
        didSet {
            cityDataTupleArray[0].1 = [currentCity]
        }
    }
    
    var recentCity = ["青岛市", "济南市", "深圳市", "长沙市", "无锡市"] {
        didSet {
            cityDataTupleArray[1].1 = recentCity
        }
    }
    
    var hotCity = ["广州市", "北京市", "天津市", "西安市", "重庆市", "沈阳市", "青岛市", "济南市", "深圳市", "长沙市", "无锡市"] {
        didSet {
            cityDataTupleArray[2].1 = recentCity
        }
    }
    
    private(set) var cityDataTupleArray: CityDataTupleArray
    
    private(set) var allCityArray: [String]
    private(set) var allPinYinCityArray: [String]
    
    func upDateCityDataTupleArray() {
        let start = Date()

        cityDataTupleArray.removeAll()
        allCityArray.removeAll()
        allPinYinCityArray.removeAll()
        
        
        cityDataTupleArray.append(("Θ", [currentCity]))
        cityDataTupleArray.append(("♡", recentCity))
        cityDataTupleArray.append(("◎", hotCity))
        
        guard let path = Bundle.main.path(forResource: "citydict", ofType: "plist"),
            let dict: [String: [String]] = NSDictionary(contentsOfFile: path) as? [String: [String]] else {
                assertionFailure("citydict 文件不存在")
                return
        }
        let sortKeys = dict.keys.sorted(by: <)
        for key in sortKeys {
            allCityArray.append(contentsOf: dict[key]!)
            cityDataTupleArray.append((key, dict[key]!))
        }
        allPinYinCityArray = allCityArray.map{ $0.pinYin }
        let interval = Date().timeIntervalSince(start)
        print(interval) // 0.84087198972702  0.0313370227813721
    }
}



