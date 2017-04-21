//
//  ApplyOtherViewControllerThree.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyOtherViewControllerThree: ApplyBaseViewControllerTypeTwo {

    override func viewDidLoad() {
        super.viewDidLoad()
         title = "帮人申请"
        // 设置 head 样式
        headViewStyle = .none(topImage: "3")
        nextVC = ApplyOtherViewControllerFour()
        applyStepModel = ApplyModel.shareApplyModel.applyOtherModel.stepThree
    }

}
