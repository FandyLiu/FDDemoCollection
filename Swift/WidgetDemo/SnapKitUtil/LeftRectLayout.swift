//
//  File.swift
//  EPlus_Swift
//
//  Created by QianTuFD on 2017/6/14.
//  Copyright © 2017年 frontpay. All rights reserved.
//

import SnapKit

struct LeftCenterSquareLayout: LeftCenterSquareLayoutable {
    var leftView: UIView
    var leftMargin: CGFloat
    var length: CGFloat
    
    init(leftView: UIView, leftMargin: CGFloat = LayoutConst.leftMargin,
         length: CGFloat) {
        self.leftView = leftView
        self.leftMargin = leftMargin
        self.length = length
    }
}

typealias LeftTopRectLayout = L_T_R_Layout
struct LeftTopRectLayout: LeftTopRectLayoutable {
    var leftView: UIView
    var leftMargin: CGFloat
    var topView: UIView
    var topMargin: CGFloat
    var width: CGFloat
    var height: CGFloat
    
    init(leftView: UIView, leftMargin: CGFloat = LayoutConst.leftMargin,
         topView: UIView, topMargin: CGFloat = LayoutConst.topMargin,
         width: CGFloat, height: CGFloat) {
        self.leftView = leftView
        self.leftMargin = leftMargin
        self.topView = topView
        self.topMargin = topMargin
        self.width = width
        self.height = height
    }
}

struct LeftTopRightHeightLayout: LeftTopRightHeightLayoutable {
    var leftView: UIView
    var leftMargin: CGFloat
    var topView: UIView
    var topMargin: CGFloat
    var rightView: UIView
    var rightMargin: CGFloat
    var height: CGFloat
    init(leftView: UIView, leftMargin: CGFloat = LayoutConst.leftMargin,
         topView: UIView, topMargin: CGFloat = LayoutConst.topMargin,
         rightView: UIView, rightMargin: CGFloat = LayoutConst.rightMargin,
         height: CGFloat) {
        self.leftView = leftView
        self.leftMargin = leftMargin
        self.topView = topView
        self.topMargin = topMargin
        self.rightView = rightView
        self.rightMargin = rightMargin
        self.height = height
    }
}



//struct MiddelCenterRectangleLayout: Layoutable {
//    func layoutMaker() -> (ConstraintMaker) -> Void {
//        return { maker in
//        }
//    }
//
//    var leftView: CGFloat
//    var superView: UIView
//    var leftMargin: CGFloat
//
//}
