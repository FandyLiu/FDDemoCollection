//
//  TodayViewController.swift
//  PrettyWidget
//
//  Created by QianTuFD on 2017/6/23.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit
import NotificationCenter
import SnapKit


class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 25)
        
        
    }
    

}


extension TodayViewController {
    func setupUI() {
        
    }
}


extension TodayViewController {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return .zero
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if #available(iOS 10.0, *) {
            extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 125)
        }else {
            preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 325)
        }
    }
    
    
    
    
    func btnClick() {
        /*
         QQ mqq://
         微信 weixin://
         淘宝taobao://
         微博 sinaweibo://
         支付宝alipay://
         */
        let url = URL(string: "fandyTest://action=richScan")
        extensionContext?.open(url!, completionHandler: { (isSus) in
            
        })
    }
}

extension TodayViewController {
    // UserDefaults
    func saveDataByUserDefaults() {
        let shared = UserDefaults(suiteName: "group.fandy")
        shared?.set("add", forKey: "widget")
        shared?.synchronize()
    }
    
    func readDataByUserDefaults() -> Any? {
        let shared = UserDefaults(suiteName: "group.fandy")
        let value = shared?.value(forKey: "add")
        return value
    }
    
    func cleanData() {
        let shared = UserDefaults(suiteName: "group.fandy")
        shared?.removeSuite(named: "group.fandy")
        shared?.synchronize()
    }
    
    
    // FillManager
    func saveDataByFillManager() {
        var containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.fandy")
        containerURL = containerURL?.appendingPathComponent("Library/Caches/widget")
        
        let value = "adfasdfasf"
        
        do {
            try value.write(to: containerURL!, atomically: true, encoding: .utf8)
        } catch let e {
            print(e)
        }
        print("成功")
    }
    
    func readDataByFillManager() -> Any? {
        var containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.fandy")
        containerURL = containerURL?.appendingPathComponent("Library/Caches/widget")
        var value = ""
        do {
            value = try String(contentsOf: containerURL!, encoding: .utf8)
        } catch let e {
            print(e)
        }
        return value
    }
    
    func clean() -> Bool {
        //其实不太规范，应该先判断是否存在该文件，再进行删除
        let path = URL(string: "")!
        do {//开始删除
            try FileManager.default.removeItem(at: path)
            
        } catch _ as NSError{
            
            return false
        }
        return true
    }
}










