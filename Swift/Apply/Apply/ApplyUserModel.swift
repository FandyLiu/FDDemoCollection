//
//  ApplyUserModel.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyModel {
    static let shareApplyModel = ApplyModel()
    let applySelfModel = ApplySelfModel()
    let applyOtherModel = ApplyOtherModel()
    
}


class ApplySelfModel {
    class SelfStepOne {
        var phone: String?
        var account: String?
        var IDNumber: String?
        var email: String?
        var firstImage: UIImage?
        var secondImage: UIImage?
    }
    class SelfStepTwo {
        var companyName: String?
        var enterpriseName: String?
        var companyAddress: String?
        var companyType: String?
        var image: UIImage?
    }
    class SelfStepThree {
        class Private {
            var bankCard: String?
            var bankCardID: String?
            var bankCardOwner: String?
            var bankCardOwnerID: String?
            var bankCardOwnerPhone: String?
            var bankCardDetail: String?
        }
        class Company {
            var bankCard: String?
            var bankCardID: String?
            var bankCardOwner: String?
            var bankCardDetail: String?
            var image: UIImage?
        }
        let priv = Private()
        let company = Company()
    }
    
    let stepOne = SelfStepOne()
    let stepTwo = SelfStepTwo()
    let stepThree = SelfStepThree()
}

class ApplyOtherModel {
    struct SelfStepOne {
        
    }
    struct SelfStepTwo {
        
    }
    struct SelfStepThree {
        
    }
}




