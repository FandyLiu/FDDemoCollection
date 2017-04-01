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

extension UILabel {
    func text(contents: (text: String, font: UIFont) ...) {
        let attriStr: NSMutableAttributedString
        if let originAtrriStr = self.attributedText {
            attriStr = NSMutableAttributedString(attributedString: originAtrriStr)
        }else {
            let textArray = contents.map{ $0.text }
            attriStr = NSMutableAttributedString(string: textArray.joined())
        }
        var location = 0
        for content in contents {
            attriStr.addAttribute(NSFontAttributeName, value: content.font, range: NSRange(location: location, length: content.text.characters.count))
            location += content.text.characters.count
        }
        self.attributedText = attriStr
    }
    
    
    
    func alignmentJustify(withWidth: CGFloat) {
        guard let originText = self.text else {
            return
        }
        let text = originText as NSString
        
        let textSize = text.textSizeWith(contentSize: CGSize(width: withWidth, height: CGFloat(MAXFLOAT)), font: self.font)
        let margin = (withWidth - textSize.width) / CGFloat(originText.characters.count - 1)
        let attriStr: NSMutableAttributedString
        if let originAtrriStr = self.attributedText {
            attriStr = NSMutableAttributedString(attributedString: originAtrriStr)
        }else {
            attriStr = NSMutableAttributedString(string: originText)
        }
        attriStr.addAttribute(kCTKernAttributeName as String, value: margin, range:NSRange(location: 0, length: originText.characters.count - 1))
        self.attributedText = attriStr
    }
    
    func alignmentJustify_colon(withWidth: CGFloat) {
        guard let originText = self.text, originText.characters.count > 2 else {
            assert(false, "Label没有内容或者Lable内容长度小于3")
            return
        }
        
        let text = originText as NSString
        let colon_W = ":".textSizeWith(contentSize: CGSize(width: withWidth, height: CGFloat(MAXFLOAT)), font: self.font).width
        
        let textSize = text.textSizeWith(contentSize: CGSize(width: withWidth, height: CGFloat(MAXFLOAT)), font: self.font)
        let margin = (withWidth - colon_W - textSize.width) / CGFloat((originText.characters.count - 2))
        let attriStr: NSMutableAttributedString
        if let originAtrriStr = self.attributedText {
            attriStr = NSMutableAttributedString(attributedString: originAtrriStr)
        }else {
            attriStr = NSMutableAttributedString(string: originText)
        }
        attriStr.addAttribute(NSKernAttributeName, value: margin, range:NSRange(location: 0, length: originText.characters.count - 2))
        self.attributedText = attriStr
    }
}

extension UITextField {
    func placeholderAlignment(alignment: NSTextAlignment) {
        guard let placeholder = placeholder else {
            return
        }
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        let attriStr: NSMutableAttributedString
        if let originAtrriStr = self.attributedPlaceholder {
            attriStr = NSMutableAttributedString(attributedString: originAtrriStr)
        }else {
            attriStr = NSMutableAttributedString(string: placeholder)
        }
        attriStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: placeholder.characters.count))
        self.attributedPlaceholder = attriStr
    }
    
    
    
}

extension UITableViewCell {
    
    private static var currentIndexPath = "currentIndexPath"
    
    var currentIndexPath: IndexPath? {
        set {
            objc_setAssociatedObject(self, &UITableViewCell.currentIndexPath, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
        get {
            return objc_getAssociatedObject(self, &UITableViewCell.currentIndexPath) as? IndexPath
        }
    }
    
}

extension UIView {
    func screenViewYValue() -> CGFloat {
        var y: CGFloat = 0.0
        var supView: UIView = self
        while let view = supView.superview {
            y += view.frame.origin.y
            if let scrollView = view as? UIScrollView {
                y -= scrollView.contentOffset.y
            }
            supView = view
        }
        return y
    }
    
    var superCell: UITableViewCell? {
        var superView: UIView? = self
        while (superView as? UITableViewCell) == nil {
            superView = superView?.superview
            if superView == nil {
                return nil
            }
        }
        return superView as? UITableViewCell
    }

}



let COLOR_666666 = UIColor.rgbColorWith(hexValue: 0x666666)
let COLOR_222222 = UIColor.rgbColorWith(hexValue: 0x222222)
let COLOR_c3c3c3 = UIColor.rgbColorWith(hexValue: 0xc3c3c3)
let COLOR_dadada = UIColor.rgbColorWith(hexValue: 0xdadada)
let COLOR_1478b8 = UIColor.rgbColorWith(hexValue: 0x1478b8)
let COLOR_efefef = UIColor.rgbColorWith(hexValue: 0xefefef)
//let FONT_28PX = UIFont.fontWith(pixel: 28.0)
//let FONT_24PX = UIFont.fontWith(pixel: 24.0)

let FONT_28PX = UIFont.systemFont(ofSize: 14)
let FONT_24PX = UIFont.systemFont(ofSize: 12)
let FONT_44PX = UIFont.systemFont(ofSize: 22)
