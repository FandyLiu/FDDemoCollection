//
//  Util.swift
//  Contact
//
//  Created by 刘欢 on 2017/5/13.
//  Copyright © 2017年 fandy. All rights reserved.
//

import Foundation
extension String {
    func phoneNumberFormat() -> String {
        var phoneNumber = self
        if phoneNumber.hasPrefix("86") {
            let rang = phoneNumber.index(phoneNumber.startIndex, offsetBy: 2) ..< phoneNumber.endIndex
            phoneNumber = phoneNumber.substring(with: rang)
        }
        phoneNumber = phoneNumber.replacingOccurrences(of: "+86", with: "")
        phoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
        phoneNumber = phoneNumber.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        phoneNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
        return phoneNumber;
    }
    
    func pinYin() -> String{
        let str = NSMutableString(string: self) as CFMutableString
        CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
        return str as String
    }
}
