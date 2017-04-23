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
        title = "帮人申请"
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
        
        let otherModelStepOne = ApplyModel.shareApplyModel.applyOtherModel.stepOne
        cellContentDict = [IndexPath(row: 1, section: 0): otherModelStepOne.verificationPhone,
        ]
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let phone = cellContentDict[IndexPath(row: 1, section: 0)] as? String {
            let otherModelStepOne = ApplyModel.shareApplyModel.applyOtherModel.stepOne
            otherModelStepOne.verificationPhone = phone
            return
        }
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, textFieldDidEndEditing textField: UITextField) {
        super.commonCell(commonCell, textFieldDidEndEditing: textField)
        
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, verificationButtonClick verificationButton: UIButton) {
        /* 110  custom */
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        // 字典转模型
        guard let phone = cellContentDict[IndexPath(row: 1, section: 0)] as? String else {
            showAlertView(with: "请输入已经实名认证通过的手机号码")
            return
        }
        guard let verification = cellContentDict[IndexPath(row: 2, section: 0)] as? String else {
            showAlertView(with: "请输入正确的短信验证码")
            return
        }
        // 网络请求判断验证码正确否
        if verification == "110" {
            let two = ApplyOtherViewControllerTwo()
            navigationController?.pushViewController(two, animated: true)
        }else {
            showAlertView(with: "验证码不正确")
        }
    }
    


}
