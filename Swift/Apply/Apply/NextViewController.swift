//
//  NextViewController.swift
//  Apply
//
//  Created by QianTuFD on 2017/4/6.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class NextViewController: ApplyBaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 head 样式
        headViewStyle = .segmented(topImage: "3",images: ["sr_btn", "gs_btn"])
        
        cellItems = [.common(.describe(title: "带有内容的设置", subtitle: "（内容）")),
                     .common(.input0(title: "四个字字：", placeholder: "四个字字")),
                     .common(.input0(title: "三个字：", placeholder: "四个字字")),
                     .common(.input0(title: "两字：", placeholder: "四个字字")),
                     .common(.input1(title: "三字：", rightplaceholder: "三")),
                     .common(.input2(placeholder: "单输入框")),
                     .image(.titleImages(title: "带有一个标题的image 上面默认有5个距离", images: [UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!])),
                     .button(.button(title: "标题 上距离 下距离", top: 100, bottom: 122)),
                     .image(.images(images: [UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!])),
                     .button(.button(title: "标题 上距离 下距离", top: 100, bottom: 122))
        ]
        
        let images = [UIImage( named: "sfzm_btn")!,UIImage( named: "zh_btn")!, UIImage( named: "yyzz_btn")!]
        cellContentDict = [IndexPath(row: 0, section: 0): "哈哈哈哈哈0", //,这种样式没有效果
                           IndexPath(row: 1, section: 0): "哈哈哈哈哈1",// 可以显示
                           IndexPath(row: 2, section: 0): "哈哈哈哈哈2",//可以显示
                           IndexPath(row: 3, section: 0): "哈哈哈哈哈3",// 可以显示
                           IndexPath(row: 4, section: 0): "哈哈哈哈哈4",// image 没效果
                           IndexPath(row: 5, section: 0): "哈哈哈哈哈5",// button 没效果
                           IndexPath(row: 6, section: 0): images,// 正确赋值方式
        ]
        
        
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        print("下一步点击")
        print(cellContentDict)
    }
    
    


}
