//
//  ApplyBaseViewControllerTypeOne.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/20.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyBaseViewControllerTypeOne: ApplyBaseViewController {
    
    var nextVC: UIViewController?
    var applyStepModel: ApplyTypeOneProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellItems = [.common(.describe(title: "商户负责人信息", subtitle: "（与营业执照法人姓名相同）")),
                     .common(.input0(title: "手机号码：", placeholder: "请输入负责人手机号码")),
                     .common(.input0(title: "账号名称：", placeholder: "请输入负责人账号名称")),
                     .common(.input0(title: "身份证号：", placeholder: "请输入负责人身份证号")),
                     .common(.input0(title: "邮箱地址：", placeholder: "请输入负责人邮箱地址")),
                     .image(.images(images: [UIImage( named: "sfzm_btn"), UIImage( named: "sc_btn")])),
                     .button(.button(title: "下一步", top: 30, bottom: 25))
        ]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let applyStepModel = applyStepModel else {
            return
        }
        let images = [applyStepModel.firstImage?.image, applyStepModel.secondImage?.image]
        cellContentDict = [IndexPath(row: 1, section: 0): applyStepModel.phone,
                           IndexPath(row: 2, section: 0): applyStepModel.account,
                           IndexPath(row: 3, section: 0): applyStepModel.IDNumber,
                           IndexPath(row: 4, section: 0): applyStepModel.email,
                           IndexPath(row: 5, section: 0): images
        ]
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let phone = cellContentDict[IndexPath(row: 1, section: 0)] as? String {
            applyStepModel?.phone = phone
        }
        if let account = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
            applyStepModel?.account = account
        }
        if let IDNumber = cellContentDict[IndexPath(row: 3, section: 0)] as? String {
            applyStepModel?.IDNumber = IDNumber
        }
        if let email = cellContentDict[IndexPath(row: 4, section: 0)] as? String {
            applyStepModel?.email = email
        }
        // 本地保存
        
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, textFieldShouldBeginEditing textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        if indexPath.row == 1 {
            textField.keyboardType = .numberPad
        }
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, textFieldDidEndEditing textField: UITextField) {
        super.commonCell(commonCell, textFieldDidEndEditing: textField)
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        if indexPath.row == 1 {
            /* 上传手机号码 */
            if textField.text != "110" {
                showAlertView(with: "手机号码有问题")
            }
        }
    
    }
    
    override func imageCell(_ imageCell: ImageTableViewCell, imageButtonClick imageButton: UIImageView) {
        guard let indexPath = imageCell.currentIndexPath else {
            return
        }
        showPhotoPickerView { [weak self] (image) in
            /* image */
            //  上传照片网络请求
            
            //上传照片如果上传成功回调
            let tag = imageButton.tag
            imageCell.images[tag] = image
            self?.cellContentDict[indexPath] = imageCell.images
            
            if tag == 0 {
                self?.applyStepModel?.firstImage = ApplyImage(image: image, path: "")
            }else if tag == 1 {
                self?.applyStepModel?.secondImage = ApplyImage(image: image, path: "")
            }
        }
    }
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        // 字典转模型
        guard (cellContentDict[IndexPath(row: 1, section: 0)] as? String) != nil else {
            showAlertView(with: "请输入负责人手机号码")
            return
        }
        guard (cellContentDict[IndexPath(row: 2, section: 0)] as? String) != nil else {
            showAlertView(with: "请输入负责人账号名称")
            return
        }
        guard (cellContentDict[IndexPath(row: 3, section: 0)] as? String) != nil else {
            showAlertView(with: "请输入负责人身份证号")
            return
        }
        guard (cellContentDict[IndexPath(row: 4, section: 0)] as? String) != nil else {
            showAlertView(with: "请输入负责人邮箱地址")
            return
        }
        guard var applyStepModel = applyStepModel, let _ = applyStepModel.firstImage?.path, let _ = applyStepModel.secondImage?.path else {
            showAlertView(with: "请上传照片")
            return
        }
        guard let vc = nextVC else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}
