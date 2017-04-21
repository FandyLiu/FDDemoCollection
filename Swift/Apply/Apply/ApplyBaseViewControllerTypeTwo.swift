//
//  ApplyBaseViewControllerTypeTwo.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/20.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit



class ApplyBaseViewControllerTypeTwo: ApplyBaseViewController {
    
    
    var nextVC: UIViewController?
    var applyStepModel: ApplyTypeTwoProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        cellItems = [.common(.input0(title: "公司名称：", placeholder: "请输入营业执照公司全称")),
                     .common(.input0(title: "企业名称：", placeholder: "请输入企业名称缩写")),
                     .common(.input0(title: "公司地址：", placeholder: "请输入公司详细地址(省市区街道)")),
                     .common(.input1(title: "行业类别", rightplaceholder: "请选择行业类别")),
                     .image(.images(images: [UIImage( named: "yyzz_btn")])),
                     .button(.button(title: "下一步", top: 30, bottom: 25))
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let applyStepModel = applyStepModel else {
            return
        }
        let images = [applyStepModel.image?.image]
        cellContentDict = [IndexPath(row: 0, section: 0): applyStepModel.companyName,
                           IndexPath(row: 1, section: 0): applyStepModel.enterpriseName,
                           IndexPath(row: 2, section: 0): applyStepModel.companyAddress,
                           IndexPath(row: 3, section: 0): applyStepModel.companyType,
                           IndexPath(row: 4, section: 0): images
        ]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 字典转模型
        if let companyName = cellContentDict[IndexPath(row: 0, section: 0)] as? String {
            applyStepModel?.companyName = companyName
        }
        if let enterpriseName = cellContentDict[IndexPath(row: 1, section: 0)] as? String {
            applyStepModel?.enterpriseName = enterpriseName
        }
        if let companyAddress = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
            applyStepModel?.companyAddress = companyAddress
        }
        if let companyType = cellContentDict[IndexPath(row: 3, section: 0)] as? String {
            applyStepModel?.companyType = companyType
        }
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        // 字典转模型
        guard (cellContentDict[IndexPath(row: 0, section: 0)] as? String) != nil else {
            showAlertView(with: "请输入营业执照公司全称")
            return
        }
        guard (cellContentDict[IndexPath(row: 1, section: 0)] as? String) != nil else {
            showAlertView(with: "请输入企业名称缩写")
            return
        }
        guard (cellContentDict[IndexPath(row: 2, section: 0)] as? String) != nil else {
            showAlertView(with: "请输入公司详细地址(省市区街道)")
            return
        }
        guard (cellContentDict[IndexPath(row: 3, section: 0)] as? String) != nil else {
            showAlertView(with: "请选择行业类别")
            return
        }
        guard var applyStepModel = applyStepModel, let _ = applyStepModel.image?.path else {
            showAlertView(with: "请上传照片")
            return
        }
        
        guard let vc = nextVC else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)

    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        textField.text = "ahhdfsahdfhs"
        cellContentDict[indexPath] = textField.text
    }
    
    override func imageCell(_ imageCell: ImageTableViewCell, imageButtonClick imageButton: UIImageView) {
        guard let indexPath = imageCell.currentIndexPath else {
            return
        }
        guard let image = UIImage(named: "yyzz_btn") else {
            return
        }
        // 上传照片如果成功就保存
        
        imageCell.images[imageButton.tag] = image
        cellContentDict[indexPath] = imageCell.images
        if imageButton.tag == 0 {
            applyStepModel?.image = (image, "")
        }
        
    }

    


}
