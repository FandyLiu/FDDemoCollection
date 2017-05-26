//
//  FDSearchTool.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/25.
//  Copyright © 2017年 fandy. All rights reserved.
//  筛选工具类

import UIKit

class FDSearchTool {
    
    
    /// 在datalist中筛选 searchText 异步
    ///
    /// - Parameters:
    ///   - searchText: 要搜索的文字
    ///   - dataList: 搜索的数组
    ///   - result: 含有搜索文字的数组
    class func getSearchResult(by searchText: String, dataList: [String], result: @escaping ([String]) -> ()) {
        DispatchQueue.global().async {
            var searchResult = [String]()
            guard searchText.characters.count > 0 else {
                DispatchQueue.main.async {
                    result(searchResult)
                }
                return
            }
            
            guard searchText.isContainsChinese else {
                searchResult = dataList.filter({ (filterStr) -> Bool in
                    if filterStr.isContainsChinese { // 有中文有英文
                        return filterStr.pinYin.lowercased().contains(searchText.lowercased())
                    }else { // 都没有中文
                        return filterStr.lowercased().replacingOccurrences(of: " ", with: "").contains(searchText.lowercased())
                    }
                })
                
                DispatchQueue.main.async {
                    result(searchResult)
                }
                return
            }
            
            searchResult = dataList.filter({ (filterStr) -> Bool in
                filterStr.contains(searchText)
            })
            
            DispatchQueue.main.async {
                result(searchResult)
            }
            
            return
        }
    }
    
    
    /// 在datalist中筛选 searchText 异步 (传入搜索的数组(拼音形式) 将提高搜索的效率)
    ///
    /// - Parameters:
    ///   - searchText: 要搜索的文字
    ///   - dataList: 搜索的数组
    ///   - dataPinYinList: 搜索的数组(拼音形式)
    ///   - result: 含有搜索文字的数组
    class func getSearchResult(by searchText: String, dataList: [String], dataPinYinList: [String]?, result: @escaping ([String]) -> ()) {
        DispatchQueue.global().async {
            var searchResult = [String]()
            guard searchText.characters.count > 0 else {
                DispatchQueue.main.async {
                    result(searchResult)
                }
                return
            }
            
            guard searchText.isContainsChinese else { // 搜索中不包含中文全为英文
                guard let pinYinList = dataPinYinList else { // 没有拼音 list 参数
                    searchResult = dataList.filter({ (filterStr) -> Bool in
                        if filterStr.isContainsChinese { // datalist 有中文有英文
                            return filterStr.pinYin.lowercased().contains(searchText.lowercased())
                        }else { // 都没有中文
                            return filterStr.lowercased().replacingOccurrences(of: " ", with: "").contains(searchText.lowercased())
                        }
                    })
                    
                    DispatchQueue.main.async {
                        result(searchResult)
                    }
                    return
                }
                
                // 有pinyinlist
                searchResult = zip(dataList, pinYinList).filter({ (filter) -> Bool in
                    guard filter.1.lowercased().replacingOccurrences(of: " ", with: "").contains(searchText.lowercased()) else {
                        return false
                    }
                    return true
                }).map{ return $0.0 }
                
                DispatchQueue.main.async {
                    result(searchResult)
                }
                return
            }
            
            searchResult = dataList.filter({ (filterStr) -> Bool in
                filterStr.contains(searchText)
            })
            
            DispatchQueue.main.async {
                result(searchResult)
            }
            
            return
        }
    }


}
