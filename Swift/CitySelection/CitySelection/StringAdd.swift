//
//  StringAdd.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/25.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

extension String {
    var isContainsChinese: Bool {
        for value in self.unicodeScalars {
            // 0x4e00 < ch  && ch < 0x9fff
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    var pinYin: String {
        let str = NSMutableString(string: self) as CFMutableString
        CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false)
        CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false)
        return (str as String).replacingOccurrences(of: " ", with: "")
    }

}
