//
//  ApplyMyselfViewControllerTwo.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyMyselfViewControllerTwo: ApplyBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 head 样式
        headViewStyle = .none(topImage: "qy")
        
        cellItems = [.common(.input0(title: "公司名称：", placeholder: "请输入营业执照公司全称")),
                     .common(.input0(title: "企业名称：", placeholder: "请输入企业名称缩写")),
                     .common(.input0(title: "公司地址：", placeholder: "请输入公司详细地址(省市区街道)")),
                     .common(.input1(title: "行业类别", rightplaceholder: "请选择行业类别")),
                     .image(.images(images: [UIImage( named: "yyzz_btn")])),
                     .button(.button(title: "下一步", top: 30, bottom: 25))
        ]
        
        let selfModelStepTwo = ApplyModel.shareApplyModel.applySelfModel.stepTwo
        let images = [selfModelStepTwo.image]
        cellContentDict = [IndexPath(row: 0, section: 0): selfModelStepTwo.companyName,
            IndexPath(row: 1, section: 0): selfModelStepTwo.enterpriseName,
            IndexPath(row: 2, section: 0): selfModelStepTwo.companyAddress,
            IndexPath(row: 3, section: 0): selfModelStepTwo.companyType,
            IndexPath(row: 4, section: 0): images
        ]
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        // 字典转模型
        guard let companyName = cellContentDict[IndexPath(row: 0, section: 0)] as? String else {
            showAlertView(with: "请输入营业执照公司全称")
            return
        }
        guard let enterpriseName = cellContentDict[IndexPath(row: 1, section: 0)] as? String else {
            showAlertView(with: "请输入企业名称缩写")
            return
        }
        guard let companyAddress = cellContentDict[IndexPath(row: 2, section: 0)] as? String else {
            showAlertView(with: "请输入公司详细地址(省市区街道)")
            return
        }
        guard let companyType = cellContentDict[IndexPath(row: 3, section: 0)] as? String else {
            showAlertView(with: "请选择行业类别")
            return
        }
        guard let images = cellContentDict[IndexPath(row: 4, section: 0)] as? [UIImage?] else {
            showAlertView(with: "请上传照片照片")
            return
        }
        let selfModelStepTwo = ApplyModel.shareApplyModel.applySelfModel.stepTwo
        selfModelStepTwo.companyName = companyName
        selfModelStepTwo.enterpriseName = enterpriseName
        selfModelStepTwo.companyAddress = companyAddress
        selfModelStepTwo.companyType = companyType
        selfModelStepTwo.image = images[0];
        // 保存本地
        let three = ApplyMyselfViewControllerThree()
        navigationController?.pushViewController(three, animated: true)
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        textField.text = "ahhdfsahdfhs"
        cellContentDict[indexPath] = textField.text
        
    }

}
