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
        // 设置 head 样式
//        headViewStyle  = .none(topImage: "3")
//        headViewStyle = .custom(topImage: "3", titles: ["aaa", "aaa"])
        headViewStyle = .segmented(topImage: "3",images: ["sr_btn", "gs_btn"])
        
        cellItems = [.common(.describe(title: "好好好好好好好好", subtitle: "（好好好好好好）")), // 11111
                     .common(.input0(title: "汉字汉字：", placeholder: "aa")),
                     .common(.input1(title: "汉字汉：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉字汉字：", placeholder: "aa")),
                     .common(.input1(title: "汉字汉：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉字汉字：", placeholder: "aa")),
                     .common(.input1(title: "汉字汉：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉字汉字：", placeholder: "aa")),
                     .common(.input1(title: "汉字汉：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉字汉字：", placeholder: "aa")),
                     .common(.input1(title: "汉字汉：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")),
                     .common(.input2(placeholder: "input2")),
                     .common(.describe(title: "describe", subtitle: "aa")),
                     .common(.input0(title: "汉字汉字：", placeholder: "aa")),
                     .common(.input1(title: "汉字汉：", rightplaceholder: "aaa")),
                     .common(.input2(placeholder: "input2")), // 22222222
                     .image(.titleImages(title: "sdfdsfsasa", images: [UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!])),
                     .image(.images(images: [UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!, UIImage( named: "zh_btn")!])),
                     // 3333333333
                     .button(.button(title: "aaaaa", top: 100, bottom: 122))
        ]
        
    }
    
    
}

// MARK: - ApplyHeadViewDelegate 头部代理回调
extension MyselfApplyViewController {
    override func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        // 选择了哪个 cell
        print(index)
    }
}


// MARK: - ApplyTableViewCellDelegate 覆盖父类 Cell 的代理回调
extension MyselfApplyViewController {
    
    /// textfield 编写完毕回调
    override func commonCell(_ commonCell: CommonTableViewCell, textFieldDidEndEditing textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        // cellContentDict 相当于一种数据源.存储数据.和展示数据时候用(已经封装好) commonCell 的 textfeld 传 String ,imageCell 的 image 传 [UIImage](不能传String 由于 有可能从照片中直接选择Image 所以这样子设计的)
        cellContentDict[indexPath] = textField.text
        print("textFieldDidEndEditing\(textField)")
    }
    /// 带箭头的 textfield 点击回调
    override func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        print("第  \(indexPath) 的 arrowCellClick \(textField)")
    }
    /// 获取验证码点击回调
    override func commonCell(_ commonCell: CommonTableViewCell, verificationButtonClick verificationButton: UIButton) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        print("第 \(indexPath) 的 verificationButtonClick\(verificationButton)")
    }
    /// 点击 image 后的回调 可以之后做展示相册选择照片等工作
    override func imageCell(_ imageCell: ImageTableViewCell, imageButtonClick imageButton: UIImageView) {
        guard let indexPath = imageCell.currentIndexPath else {
            return
        }
        print("第 \(indexPath) 的 \(imageButton.tag) verificationButtonClick\(imageButton)")
        
        // 这是改变照片的三步代码
        // 这个 images 为照片的数组. 从cell 中取出
        guard var images = imageCell.images, images.count >= imageButton.tag else {
            print("点击⌚️有病")
            return
        }
        
        // 从image数组中根据点击的照片tag 确定点击的是cell 中的第几个照片.并修改值
        images[imageButton.tag] = UIImage(named: "yyzz_btn")!
        // 赋值给数据源
        cellContentDict[indexPath] = images
    }
    
    /// 下一步,或者确认点击回调
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        print("下一步点击")
        // 打印数据源,内部有所以你想要的数据.
        print(cellContentDict)
    }
}

