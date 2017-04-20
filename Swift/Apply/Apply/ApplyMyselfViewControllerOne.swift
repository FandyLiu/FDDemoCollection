//
//  ApplyMyselfViewControllerOne.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyMyselfViewControllerOne: ApplyBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 head 样式
        headViewStyle = .none(topImage: "jb")
        
        cellItems = [.common(.describe(title: "商户负责人信息", subtitle: "（与营业执照法人姓名相同）")),
                     .common(.input0(title: "手机号码：", placeholder: "请输入负责人手机号码")),
                     .common(.input0(title: "账号名称：", placeholder: "请输入负责人账号名称")),
                     .common(.input0(title: "身份证号：", placeholder: "请输入负责人身份证号")),
                     .common(.input0(title: "邮箱地址：", placeholder: "请输入负责人邮箱地址")),
                     .image(.images(images: [UIImage( named: "sfzm_btn"), UIImage( named: "sc_btn")])),
                     .button(.button(title: "下一步", top: 30, bottom: 25))
        ]
        
        let selfModelStepOne = ApplyModel.shareApplyModel.applySelfModel.stepOne
        let images = [selfModelStepOne.firstImage, selfModelStepOne.secondImage]
        cellContentDict = [IndexPath(row: 1, section: 0): selfModelStepOne.phone,
            IndexPath(row: 2, section: 0): selfModelStepOne.account,
            IndexPath(row: 3, section: 0): selfModelStepOne.IDNumber,
            IndexPath(row: 4, section: 0): selfModelStepOne.email,
            IndexPath(row: 5, section: 0): images
            ]
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
            // 字典转模型
        guard let phone = cellContentDict[IndexPath(row: 1, section: 0)] as? String else {
            showAlertView(with: "请输入负责人手机号码")
            return
        }
        guard let account = cellContentDict[IndexPath(row: 2, section: 0)] as? String else {
            showAlertView(with: "请输入负责人账号名称")
            return
        }
        guard let IDNumber = cellContentDict[IndexPath(row: 3, section: 0)] as? String else {
            showAlertView(with: "请输入负责人身份证号")
            return
        }
        guard let email = cellContentDict[IndexPath(row: 4, section: 0)] as? String else {
            showAlertView(with: "请输入负责人邮箱地址")
            return
        }
        guard let images = cellContentDict[IndexPath(row: 5, section: 0)] as? [UIImage?] else {
            showAlertView(with: "请输入负责人照片")
            return
        }
        let selfModelStepOne = ApplyModel.shareApplyModel.applySelfModel.stepOne

        selfModelStepOne.phone = phone
        selfModelStepOne.account = account
        selfModelStepOne.IDNumber = IDNumber
        selfModelStepOne.email = email
        selfModelStepOne.firstImage = images[0];
        selfModelStepOne.secondImage = images[1];
        // 保存本地
        
        let two = ApplyMyselfViewControllerTwo()
        navigationController?.pushViewController(two, animated: true)

    }

}
