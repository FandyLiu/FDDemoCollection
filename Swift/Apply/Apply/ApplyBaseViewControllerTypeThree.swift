//
//  ApplyBaseViewControllerTypeThree.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/20.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

enum ApplyTypeThreeStyle {
    case priv
    case company
}

class ApplyBaseViewControllerTypeThree: ApplyBaseViewController {
    
    var applyType: ApplyTypeThreeStyle = ApplyTypeThreeStyle.priv
    
    var nextVC: UIViewController?
    
    var applyStepModelPriv: ApplyTypeThreeProtocol?
    var applyStepModelCompany: ApplyTypeThreeProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPrivateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPrivate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        switch self.applyType {
        case .priv:
            if let bankCard = cellContentDict[IndexPath(row: 0, section: 0)] as? String {
                applyStepModelPriv?.bankCard = bankCard
            }
            if let bankCardID = cellContentDict[IndexPath(row: 1, section: 0)] as? String {
                applyStepModelPriv?.bankCardID = bankCardID
            }
            if let bankCardOwner = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
                applyStepModelPriv?.bankCardOwner = bankCardOwner
            }
            if let bankCardOwnerID = cellContentDict[IndexPath(row: 3, section: 0)] as? String {
                applyStepModelPriv?.bankCardOwnerID = bankCardOwnerID
            }
            if let bankCardOwnerPhone = cellContentDict[IndexPath(row: 4, section: 0)] as? String {
                applyStepModelPriv?.bankCardOwnerPhone = bankCardOwnerPhone;
            }
            if let bankCardDetail = cellContentDict[IndexPath(row: 5, section: 0)] as? String {
                applyStepModelPriv?.bankCardDetail = bankCardDetail;
            }
            
        case .company:
            if let bankCard = cellContentDict[IndexPath(row: 0, section: 0)] as? String {
                applyStepModelCompany?.bankCard = bankCard
            }
            if let bankCardID = cellContentDict[IndexPath(row: 1, section: 0)] as? String {
                applyStepModelCompany?.bankCardID = bankCardID
            }
            if let bankCardOwner = cellContentDict[IndexPath(row: 2, section: 0)] as? String {
                applyStepModelCompany?.bankCardOwner = bankCardOwner
            }
            if let bankCardDetail = cellContentDict[IndexPath(row: 3, section: 0)] as? String {
                applyStepModelCompany?.bankCardDetail = bankCardDetail;
            }
        }
        // 保存本地
        ApplyModelTool.save(model: ApplyModel.shareApplyModel)
    }
    
    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        // 字典转模型
        
        switch self.applyType {
        case .priv:
            guard (cellContentDict[IndexPath(row: 0, section: 0)] as? String) != nil else {
                showAlertView(with: "请选择银行卡")
                return
            }
            guard (cellContentDict[IndexPath(row: 1, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入银行卡号")
                return
            }
            guard (cellContentDict[IndexPath(row: 2, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入开户人姓名")
                return
            }
            guard (cellContentDict[IndexPath(row: 3, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入银行预留身份证号")
                return
            }
            guard (cellContentDict[IndexPath(row: 4, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入银行预留手机号码")
                return
            }
            guard (cellContentDict[IndexPath(row: 5, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入开户行所在省市区及名")
                return
            }
        case .company:
            guard (cellContentDict[IndexPath(row: 0, section: 0)] as? String) != nil else {
                showAlertView(with: "请选择银行卡")
                return
            }
            guard (cellContentDict[IndexPath(row: 1, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入银行卡号")
                return
            }
            guard (cellContentDict[IndexPath(row: 2, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入开户人姓名")
                return
            }
            guard (cellContentDict[IndexPath(row: 3, section: 0)] as? String) != nil else {
                showAlertView(with: "请输入开户行所在省市区及名")
                return
            }
            guard var applyStepModel = applyStepModelCompany, let _ = applyStepModel.image?.path else {
                showAlertView(with: "请上传照片")
                return
            }
        }
        navigationController?.popToRootViewController(animated: true)
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
            applyStepModelCompany?.image = (image, "")
        }
        
    }
    
    
    override func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        if index == 0 { // 私人
            setupPrivateUI()
            setupPrivate()
            self.applyType = .priv
        }else if index == 1 { // 公司
            setupCompanyUI()
            setupCompany()
            self.applyType = .company
        }
    }
    
    
    /// 私有设置
    func setupPrivateUI() {
        cellItems = [.common(.input1(title: "银行卡：", rightplaceholder: "请选择银行卡")),
                     .common(.input0(title: "银行卡号：", placeholder: "请输入银行卡号")),
                     .common(.input0(title: "开户人：", placeholder: "请输入开户人姓名")),
                     .common(.input0(title: "身份证号：", placeholder: "请输入银行预留身份证号码")),
                     .common(.input0(title: "手机号码：", placeholder: "请输入银行预留手机号码")),
                     .common(.input0(title: "银行详情", placeholder: "请输入开户行所在省市区及名称")),
                     .button(.button(title: "提交", top: 30, bottom: 25))
        ]
        
    }
    func setupPrivate() {
        guard let applyStepModel = applyStepModelPriv else {
            return
        }
        cellContentDict = [IndexPath(row: 0, section: 0): applyStepModel.bankCard,
                           IndexPath(row: 1, section: 0): applyStepModel.bankCardID,
                           IndexPath(row: 2, section: 0): applyStepModel.bankCardOwner,
                           IndexPath(row: 3, section: 0): applyStepModel.bankCardOwnerID,
                           IndexPath(row: 4, section: 0): applyStepModel.bankCardOwnerPhone,
                           IndexPath(row: 5, section: 0): applyStepModel.bankCardDetail
        ]
    }
    func setupCompanyUI() {
        cellItems = [.common(.input1(title: "银行卡：", rightplaceholder: "请选择银行卡")),
                     .common(.input0(title: "银行卡号：", placeholder: "请输入银行卡号")),
                     .common(.input0(title: "开户人：", placeholder: "请输入开户人姓名")),
                     .common(.input0(title: "银行详情", placeholder: "请输入开户行所在省市区及名称")),
                     .image(.titleImages(title: "快捷开通", images: [UIImage(named:"zh_btn")])),
                     .button(.button(title: "下一步", top: 30, bottom: 25))
        ]
    }
    func setupCompany() {
        guard let applyStepModel = applyStepModelCompany else {
            return
        }
        cellContentDict = [IndexPath(row: 0, section: 0): applyStepModel.bankCard,
                           IndexPath(row: 1, section: 0): applyStepModel.bankCardID,
                           IndexPath(row: 2, section: 0): applyStepModel.bankCardOwner,
                           IndexPath(row: 3, section: 0): applyStepModel.bankCardDetail,
                           IndexPath(row: 4, section: 0): [applyStepModel.image?.image],
        ]
    }
}
