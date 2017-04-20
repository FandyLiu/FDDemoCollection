//
//  ApplyOtherViewControllerOne.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyOtherViewControllerOne: ApplyBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 head 样式
        let account = "13685475986"
        let name = "李瑞"
        headViewStyle = .custom(topImage: "1", titles: ["申请人账号:" + account,
                                                       "申请人姓名:" + name])

        
        cellItems = [.common(.describe(title: "商户负责人信息", subtitle: "（与营业执照法人姓名相同）")),
                     .common(.input2(placeholder: "请输入已经实名认证通过的手机号码")),
                     .common(.verification(placeholder: "请点击获取短信验证码")),
                     .button(.button(title: "下一步", top: 50, bottom: 0))
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
