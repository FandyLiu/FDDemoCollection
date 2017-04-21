//
//  ApplyUserModel.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

typealias ApplyImage = (image: UIImage,path: String)

protocol ApplyTypeOneProtocol {
    var phone: String? { get set }
    var account: String? { get set  }
    var IDNumber: String? { get set  }
    var email: String? { get set  }
    var firstImage: ApplyImage? { get set  }
    var secondImage: ApplyImage? { get set  }
}

protocol ApplyTypeTwoProtocol {
    var companyName: String? { get set  }
    var enterpriseName: String? { get set  }
    var companyAddress: String? { get set  }
    var companyType: String? { get set  }
    var image: ApplyImage? { get set  }
}

protocol ApplyTypeThreeProtocol {
    var bankCard: String? { get set  }
    var bankCardID: String? { get set  }
    var bankCardOwner: String? { get set  }
    var bankCardOwnerID: String? { get set  }
    var bankCardOwnerPhone: String? { get set  }
    var bankCardDetail: String? { get set  }
    var image: ApplyImage? { get set  }
}

extension ApplyTypeThreeProtocol {
    var bankCardOwnerID: String? {
        get {
            return bankCardOwnerID
        }
        set {
            bankCardOwnerID = newValue
        }
    }
    var bankCardOwnerPhone: String? {
        get {
            return bankCardOwnerPhone
        }
        set {
            bankCardOwnerPhone = newValue
        }
    }
    var image: ApplyImage? {
        get {
            return image
        }
        set {
            image = newValue
        }
    }
}

class ApplyModelTool {
    private static let component = "ApplyModel.fd"
    
    private static var path: String? {
        get {
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/").appending(ApplyModelTool.component)
        }
    }
    
    static func save(model: ApplyModel) {
        guard let path = path else {
            return
        }
        NSKeyedArchiver.archiveRootObject(model, toFile: path)
    }
    static func readModel() -> ApplyModel {
        guard let path = path else {
            return ApplyModel()
        }
        guard let model = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? ApplyModel else {
            return ApplyModel()
        }
        return model
    }
}



class ApplyModel:NSObject, NSCoding {
    private static let applySelfModelKey = "applySelfModelKey"
    private static let applyOtherModelKey = "applyOtherModelKey"
    
    static let shareApplyModel = ApplyModelTool.readModel()
    
    
    var applySelfModel = ApplySelfModel()
    var applyOtherModel = ApplyOtherModel()
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let applySelfModel = aDecoder.decodeObject(forKey: ApplyModel.applySelfModelKey) as? ApplySelfModel else {
            return nil
        }
        guard let applyOtherModel = aDecoder.decodeObject(forKey: ApplyModel.applyOtherModelKey) as? ApplyOtherModel else {
            return nil
        }
        self.applySelfModel = applySelfModel
        self.applyOtherModel = applyOtherModel
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(applySelfModel, forKey: ApplyModel.applySelfModelKey)
        aCoder.encode(applyOtherModel, forKey: ApplyModel.applyOtherModelKey)
    }

}


class ApplySelfModel: NSObject, NSCoding {

    var stepOne = StepOne()
    var stepTwo = StepTwo()
    var stepThree = StepThree()
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        guard let stepOne = aDecoder.decodeObject(forKey: "stepOne") as? StepOne else {
            return nil
        }
        guard let stepTwo = aDecoder.decodeObject(forKey: "stepTwo") as? StepTwo  else {
            return nil
        }
        guard let stepThree = aDecoder.decodeObject(forKey: "stepThree") as? StepThree  else {
            return nil
        }
        self.stepOne = stepOne
        self.stepTwo = stepTwo
        self.stepThree = stepThree
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(stepOne, forKey: "stepOne")
        aCoder.encode(stepTwo, forKey: "stepTwo")
        aCoder.encode(stepThree, forKey: "stepThree")
    }
}

class ApplyOtherModel: NSObject, NSCoding {
    
    class OtherStepOne: NSObject, NSCoding {
        var verificationPhone: String?
        override init() {
            super.init()
        }
        required init?(coder aDecoder: NSCoder) {
            verificationPhone = aDecoder.decodeObject(forKey: "verificationPhone") as? String
        }
        func encode(with aCoder: NSCoder) {
            aCoder.encode(verificationPhone, forKey: "verificationPhone")
        }
        
    }
    var stepOne = OtherStepOne()
    var stepTwo = StepOne()
    var stepThree = StepTwo()
    var stepFour = StepThree()
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        guard let stepOne = aDecoder.decodeObject(forKey: "stepOne") as? OtherStepOne else {
            return nil
        }
        guard let stepTwo = aDecoder.decodeObject(forKey: "stepTwo") as? StepOne  else {
            return nil
        }
        guard let stepThree = aDecoder.decodeObject(forKey: "stepThree") as? StepTwo  else {
            return nil
        }
        guard let stepFour = aDecoder.decodeObject(forKey: "stepFour") as? StepThree  else {
            return nil
        }
        self.stepOne = stepOne
        self.stepTwo = stepTwo
        self.stepThree = stepThree
        self.stepFour = stepFour
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(stepOne, forKey: "stepOne")
        aCoder.encode(stepTwo, forKey: "stepTwo")
        aCoder.encode(stepThree, forKey: "stepThree")
        aCoder.encode(stepFour, forKey: "stepFour")

        
    }
}






class StepOne: NSObject, ApplyTypeOneProtocol, NSCoding {
    var phone: String?
    var account: String?
    var IDNumber: String?
    var email: String?
    var firstImage: ApplyImage?
    var secondImage: ApplyImage?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        account = aDecoder.decodeObject(forKey: "account") as? String
        IDNumber = aDecoder.decodeObject(forKey: "IDNumber") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        firstImage = aDecoder.decodeObject(forKey: "firstImage") as? ApplyImage
        secondImage = aDecoder.decodeObject(forKey: "secondImage") as? ApplyImage
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(account, forKey: "account")
        aCoder.encode(IDNumber, forKey: "IDNumber")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(firstImage, forKey: "firstImage")
        aCoder.encode(secondImage, forKey: "secondImage")
    }
}


class StepTwo: NSObject, NSCoding, ApplyTypeTwoProtocol {
    var companyName: String?
    var enterpriseName: String?
    var companyAddress: String?
    var companyType: String?
    var image: ApplyImage?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        companyName = aDecoder.decodeObject(forKey: "companyName") as? String
        enterpriseName = aDecoder.decodeObject(forKey: "enterpriseName") as? String
        companyAddress = aDecoder.decodeObject(forKey: "companyAddress") as? String
        companyType = aDecoder.decodeObject(forKey: "companyType") as? String
        image = aDecoder.decodeObject(forKey: "image") as? ApplyImage
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(companyName, forKey: "companyName")
        aCoder.encode(enterpriseName, forKey: "enterpriseName")
        aCoder.encode(companyAddress, forKey: "companyAddress")
        aCoder.encode(companyType, forKey: "companyType")
        aCoder.encode(image, forKey: "image")
    }
}

class StepThree: NSObject, NSCoding {
    
    class Private: NSObject, NSCoding, ApplyTypeThreeProtocol {
        var bankCard: String?
        var bankCardID: String?
        var bankCardOwner: String?
        var bankCardOwnerID: String?
        var bankCardOwnerPhone: String?
        var bankCardDetail: String?
        
        override init() {
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            bankCard = aDecoder.decodeObject(forKey: "bankCard") as? String
            bankCardID = aDecoder.decodeObject(forKey: "bankCardID") as? String
            bankCardOwner = aDecoder.decodeObject(forKey: "bankCardOwner") as? String
            bankCardOwnerID = aDecoder.decodeObject(forKey: "bankCardOwnerID") as? String
            bankCardOwnerPhone = aDecoder.decodeObject(forKey: "bankCardOwnerPhone") as? String
            bankCardDetail = aDecoder.decodeObject(forKey: "bankCardDetail") as? String
        }
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(bankCard, forKey: "bankCard")
            aCoder.encode(bankCardID, forKey: "bankCardID")
            aCoder.encode(bankCardOwner, forKey: "bankCardOwner")
            aCoder.encode(bankCardOwnerID, forKey: "bankCardOwnerID")
            aCoder.encode(bankCardOwnerPhone, forKey: "bankCardOwnerPhone")
            aCoder.encode(bankCardDetail, forKey: "bankCardDetail")
        }
    }
    
    class Company: NSObject, NSCoding, ApplyTypeThreeProtocol {
        var bankCard: String?
        var bankCardID: String?
        var bankCardOwner: String?
        var bankCardDetail: String?
        var image: ApplyImage?
        
        override init() {
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            bankCard = aDecoder.decodeObject(forKey: "bankCard") as? String
            bankCardID = aDecoder.decodeObject(forKey: "bankCardID") as? String
            bankCardOwner = aDecoder.decodeObject(forKey: "bankCardOwner") as? String
            bankCardDetail = aDecoder.decodeObject(forKey: "bankCardDetail") as? String
            image = aDecoder.decodeObject(forKey: "image") as? ApplyImage
            
        }
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(bankCard, forKey: "bankCard")
            aCoder.encode(bankCardID, forKey: "bankCardID")
            aCoder.encode(bankCardOwner, forKey: "bankCardOwner")
            aCoder.encode(bankCardDetail, forKey: "bankCardDetail")
            aCoder.encode(image, forKey: "image")
        }
    }
    
    var priv = Private()
    var company = Company()
    
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        guard let priv = aDecoder.decodeObject(forKey: "priv") as? Private else {
            return nil
        }
        guard let company = aDecoder.decodeObject(forKey: "company") as? Company else {
            return nil
        }
        self.priv = priv
        self.company = company
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(priv, forKey: "priv")
        aCoder.encode(company, forKey: "company")
    }
}



