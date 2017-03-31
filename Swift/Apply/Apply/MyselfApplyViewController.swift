//
//  MyselfApplyViewController.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/31.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class MyselfApplyViewController: ApplyBaseViewController {
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        headViewStyle = .custom(titles: ["aaaa", "aaa"])
//        headViewStyle = .segmented(images: ["sr_btn", "gs_btn"])
        cellItems = [.describe(title: "describe", subtitle: "aa"),
                     .input0(title: "汉子汉子：", placeholder: "aa"),
                     .input1(title: "汉子汉子：", rightplaceholder: "aaa"),
                     .input2(placeholder: "input2"),
                     .verification(placeholder: "verification"),
                        .describe(title: "describe", subtitle: "aa"),
                     .input0(title: "汉子汉子：", placeholder: "aa"),
                     .input1(title: "汉子汉子：", rightplaceholder: "aaa"),
                     .input2(placeholder: "input2"),
                     .verification(placeholder: "verification"),
                        .describe(title: "describe", subtitle: "aa"),
                     .input0(title: "汉子汉子：", placeholder: "aa"),
                     .input1(title: "汉子汉子：", rightplaceholder: "aaa"),
                     .input2(placeholder: "input2"),
                     .verification(placeholder: "verification")
        ]
        
    }
    
    override func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        print(index)
    }

}
