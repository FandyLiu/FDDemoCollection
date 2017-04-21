//
//  ApplyMyselfViewControllerOne.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit



class ApplyMyselfViewControllerOne: ApplyBaseViewControllerTypeOne {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我要申请"
        headViewStyle = .none(topImage: "jb")
        nextVC = ApplyMyselfViewControllerTwo()
        applyStepModel = ApplyModel.shareApplyModel.applySelfModel.stepOne
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    
}
