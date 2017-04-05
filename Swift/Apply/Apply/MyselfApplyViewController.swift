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
        headViewStyle  = .none(topImage: "3")
        headViewStyle = .custom(topImage: "3", titles: ["aaa", "aaa"])
//        headViewStyle = .segmented(topImage: "3",images: ["sr_btn", "gs_btn"])
        
        cellItems = [.common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉子汉子：", placeholder: "aa")),
                     .common(.input1(title: "汉子汉子：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.verification(placeholder: "verification")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉子汉子：", placeholder: "aa")),
                     .common(.input1(title: "汉子汉子：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.verification(placeholder: "verification")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉子汉子：", placeholder: "aa")),
                     .common(.input1(title: "汉子汉子：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.verification(placeholder: "verification")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉子汉子：", placeholder: "aa")),
                     .common(.input1(title: "汉子汉子：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.verification(placeholder: "verification")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉子汉子：", placeholder: "aa")),
                     .common(.input1(title: "汉子汉子：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.verification(placeholder: "verification")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉子汉子：", placeholder: "aa")),
                     .common(.input1(title: "汉子汉子：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.verification(placeholder: "verification")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉子汉子：", placeholder: "aa")),
                     .common(.input1(title: "汉子汉子：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.verification(placeholder: "verification")),
                     .image(.images(images: ["zh_btn", "zh_btn", "zh_btn"])),
                     .image(.titleImages(title: "sdfdsfsasa", images: ["zh_btn", "zh_btn", "zh_btn"]))
        ]
        
    }
    
    override func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        print(index)
    }

}
