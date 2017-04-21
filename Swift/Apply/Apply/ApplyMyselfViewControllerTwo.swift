//
//  ApplyMyselfViewControllerTwo.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyMyselfViewControllerTwo: ApplyBaseViewControllerTypeTwo {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我要申请"
        // 设置 head 样式
        headViewStyle = .none(topImage: "qy")
        nextVC = ApplyMyselfViewControllerThree()
        applyStepModel = ApplyModel.shareApplyModel.applySelfModel.stepTwo
    }
}
