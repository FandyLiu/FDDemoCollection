//
//  ApplyMyselfViewControllerThree.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyMyselfViewControllerThree: ApplyBaseViewControllerTypeThree {
    
    
    var applytype: ApplyTypeThreeStyle = ApplyTypeThreeStyle.priv

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我要申请"
        // 设置 head 样式
        headViewStyle = .segmented(topImage: "yhk",images: ["sr_btn", "gs_btn"])
        applyStepModelPriv = ApplyModel.shareApplyModel.applySelfModel.stepThree.priv
        applyStepModelCompany = ApplyModel.shareApplyModel.applySelfModel.stepThree.company

        

    }

}
