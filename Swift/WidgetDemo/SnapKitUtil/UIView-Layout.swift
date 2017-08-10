//
//  UIView-Layout.swift
//  EPlus_Swift
//
//  Created by QianTuFD on 2017/6/14.
//  Copyright © 2017年 frontpay. All rights reserved.
//  SnapKit 的可复用布局封装

import SnapKit


/****************** Layout 默认常量 ******************/
// MARK: - Layout 默认常量
/// Layout 默认常量
struct LayoutConst {
    static let margin: CGFloat = 8.0
    static let leftMargin: CGFloat = 8.0
    static let rightMargin: CGFloat = 8.0
    static let topMargin: CGFloat = 8.0
    static let bottomMargin: CGFloat = 8.0
}


/****************** Layoutable 协议 ******************/
// MARK: - Layoutable 协议
/// Layoutable 的协议, 只有遵守协议的类才能在封装中使用
protocol Layoutable {
    var layoutMaker: (ConstraintMaker) -> Void { get }
}


/****************** UIView 布局扩展 ******************/
// MARK: - UIView 布局扩展
extension UIView {
    /// UIView 布局扩展
    ///
    /// - Parameter layouter: 遵守 Layoutable 的自定义可 复用 布局
    func makeLayout(_ layouter: Layoutable) {
        snp.makeConstraints(layouter.layoutMaker)
    }
}



