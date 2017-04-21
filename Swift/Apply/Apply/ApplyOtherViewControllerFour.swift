//
//  ApplyOtherViewControllerFour.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyOtherViewControllerFour: ApplyBaseViewControllerTypeThree {

    override func viewDidLoad() {
        super.viewDidLoad()
         title = "帮人申请"
        // 设置 head 样式
        headViewStyle = .segmented(topImage: "4",images: ["sr_btn", "gs_btn"])
        applyStepModelPriv = ApplyModel.shareApplyModel.applyOtherModel.stepFour.priv
        applyStepModelCompany = ApplyModel.shareApplyModel.applyOtherModel.stepFour.company

    }
}
