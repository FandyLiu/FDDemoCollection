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
        
        cellItems = [.common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉子汉子：", placeholder: "aa")),
                     .common(.input1(title: "汉子汉子：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.verification(placeholder: "verification")),
        ]
        
    }
    
    override func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        print(index)
    }

}
