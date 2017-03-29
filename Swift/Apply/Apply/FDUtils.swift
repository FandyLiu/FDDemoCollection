//
//  FDUtils.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

extension Int {
    var f: CGFloat {
        return CGFloat(self)
    }
}

extension UIColor {
    class func rgbColorWith(hexValue: Int) -> UIColor {
        return UIColor(red: ((hexValue & 0xFF0000) >> 16).f / 255.0,
                       green: ((hexValue & 0xFF00) >> 8).f / 255.0,
                       blue: (hexValue & 0xFF).f / 255.0,
                       alpha: 1.0)
    }
}

extension UIFont {
    class func fontWith(pixel: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: pixel / 96.f * 72.f)
    }
}

extension NSString {
    func textSizeWith(contentSize:CGSize, font: UIFont) -> CGSize {
        let attrs = [NSFontAttributeName: font]
        return self.boundingRect(with: contentSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
}


let COLOR_666666 = UIColor.rgbColorWith(hexValue: 0x666666)
let COLOR_222222 = UIColor.rgbColorWith(hexValue: 0x222222)

let FONT_28PX = UIFont.fontWith(pixel: 28.0)



