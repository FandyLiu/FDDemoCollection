//
//  ApplyOtherViewControllerTwo.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyOtherViewControllerTwo: ApplyBaseViewControllerTypeOne {

    override func viewDidLoad() {
        super.viewDidLoad()
         title = "帮人申请"
        // 设置 head 样式
        let account = "13685475986"
        let name = "李瑞"
        headViewStyle = .custom(topImage: "2j", titles: ["申请人账号:" + account,
                                                        "申请人姓名:" + name])
        nextVC = ApplyOtherViewControllerThree()
        applyStepModel = ApplyModel.shareApplyModel.applyOtherModel.stepTwo
        
    }
}
