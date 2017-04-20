//
//  ApplyMyselfViewControllerThree.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyMyselfViewControllerThree: ApplyBaseViewController {
    
    
    var applytype: ApplyType = ApplyType.priv

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 head 样式
        headViewStyle = .segmented(topImage: "yhk",images: ["sr_btn", "gs_btn"])
        setupPrivate()
    }

    
    override func buttonCell(_ buttonCell: ButtonTableViewCell, nextButtonClick nextButton: UIButton) {
        // 字典转模型
        
        switch self.applytype {
        case .priv:
            guard let bankCard = cellContentDict[IndexPath(row: 0, section: 0)] as? String else {
                showAlertView(with: "请选择银行卡")
                return
            }
            guard let bankCardID = cellContentDict[IndexPath(row: 1, section: 0)] as? String else {
                showAlertView(with: "请输入银行卡号")
                return
            }
            guard let bankCardOwner = cellContentDict[IndexPath(row: 2, section: 0)] as? String else {
                showAlertView(with: "请输入开户人姓名")
                return
            }
            guard let bankCardOwnerID = cellContentDict[IndexPath(row: 3, section: 0)] as? String else {
                showAlertView(with: "请输入银行预留身份证号")
                return
            }
            guard let bankCardOwnerPhone = cellContentDict[IndexPath(row: 4, section: 0)] as? String else {
                showAlertView(with: "请输入银行预留手机号码")
                return
            }
            guard let bankCardDetail = cellContentDict[IndexPath(row: 5, section: 0)] as? String else {
                showAlertView(with: "请输入开户行所在省市区及名")
                return
            }

            let selfModelStepThreePrivate = ApplyModel.shareApplyModel.applySelfModel.stepThree.priv
            selfModelStepThreePrivate.bankCard = bankCard
            selfModelStepThreePrivate.bankCardID = bankCardID
            selfModelStepThreePrivate.bankCardOwner = bankCardOwner
            selfModelStepThreePrivate.bankCardOwnerID = bankCardOwnerID
            selfModelStepThreePrivate.bankCardOwnerPhone = bankCardOwnerPhone;
            selfModelStepThreePrivate.bankCardDetail = bankCardDetail;
   
        case .company:
            guard let bankCard = cellContentDict[IndexPath(row: 0, section: 0)] as? String else {
                showAlertView(with: "请选择银行卡")
                return
            }
            guard let bankCardID = cellContentDict[IndexPath(row: 1, section: 0)] as? String else {
                showAlertView(with: "请输入银行卡号")
                return
            }
            guard let bankCardOwner = cellContentDict[IndexPath(row: 2, section: 0)] as? String else {
                showAlertView(with: "请输入开户人姓名")
                return
            }
            guard let bankCardDetail = cellContentDict[IndexPath(row: 3, section: 0)] as? String else {
                showAlertView(with: "请输入开户行所在省市区及名")
                return
            }
            guard let image = cellContentDict[IndexPath(row: 4, section: 0)] as? UIImage? else {
                showAlertView(with: "请输入照片")
                return
            }
            
            let selfModelStepThreeCompany = ApplyModel.shareApplyModel.applySelfModel.stepThree.company
            selfModelStepThreeCompany.bankCard = bankCard
            selfModelStepThreeCompany.bankCardID = bankCardID
            selfModelStepThreeCompany.bankCardOwner = bankCardOwner
            selfModelStepThreeCompany.bankCardDetail = bankCardDetail;
            selfModelStepThreeCompany.image = image
        }
        // 保存本地
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField) {
        guard let indexPath = commonCell.currentIndexPath else {
            return
        }
        textField.text = "ahhdfsahdfhs"
        cellContentDict[indexPath] = textField.text
        
    }
    
    
    override func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int) {
        if index == 0 { // 私人
            setupPrivate()

        }else if index == 1 { // 公司
            setupCompany()
        }
    }
    
    
    func setupPrivate() {
        
        cellItems = [.common(.input1(title: "银行卡：", rightplaceholder: "请选择银行卡")),
                     .common(.input0(title: "银行卡号：", placeholder: "请输入银行卡号")),
                     .common(.input0(title: "开户人：", placeholder: "请输入开户人姓名")),
                     .common(.input0(title: "身份证号：", placeholder: "请输入银行预留身份证号码")),
                     .common(.input0(title: "手机号码：", placeholder: "请输入银行预留手机号码")),
                     .common(.input0(title: "银行详情", placeholder: "请输入开户行所在省市区及名称")),
                     .button(.button(title: "提交", top: 30, bottom: 25))
        ]
        
        let selfModelStepThreePrivate = ApplyModel.shareApplyModel.applySelfModel.stepThree.priv
        cellContentDict = [IndexPath(row: 0, section: 0): selfModelStepThreePrivate.bankCard,
                           IndexPath(row: 1, section: 0): selfModelStepThreePrivate.bankCardID,
                           IndexPath(row: 2, section: 0): selfModelStepThreePrivate.bankCardOwner,
                           IndexPath(row: 3, section: 0): selfModelStepThreePrivate.bankCardOwnerID,
                           IndexPath(row: 4, section: 0): selfModelStepThreePrivate.bankCardOwnerPhone,
                           IndexPath(row: 5, section: 0): selfModelStepThreePrivate.bankCardDetail
        ]
        
    }
    func setupCompany() {
        
        cellItems = [.common(.input1(title: "银行卡：", rightplaceholder: "请选择银行卡")),
                     .common(.input0(title: "银行卡号：", placeholder: "请输入银行卡号")),
                     .common(.input0(title: "开户人：", placeholder: "请输入开户人姓名")),
                     .common(.input0(title: "银行详情", placeholder: "请输入开户行所在省市区及名称")),
                     .image(.titleImages(title: "快捷开通", images: [UIImage(named:"zh_btn")])),
                     .button(.button(title: "下一步", top: 30, bottom: 25))
        ]
        let selfModelStepThreeCompany = ApplyModel.shareApplyModel.applySelfModel.stepThree.company
        cellContentDict = [IndexPath(row: 0, section: 0): selfModelStepThreeCompany.bankCard,
                           IndexPath(row: 1, section: 0): selfModelStepThreeCompany.bankCardID,
                           IndexPath(row: 2, section: 0): selfModelStepThreeCompany.bankCardOwner,
                           IndexPath(row: 3, section: 0): selfModelStepThreeCompany.bankCardDetail,
                           IndexPath(row: 4, section: 0): [selfModelStepThreeCompany.image],
        ]
        
    }
}
