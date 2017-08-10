//
//  BaseLayoutable.swift
//  WidgetDemo
//
//  Created by QianTuFD on 2017/6/27.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit
import SnapKit


// MARK: - Rect
/// RectLayoutable 带有 Rect 的布局协议
protocol WidthLayoutable {
    var width: CGFloat { get }
    var widthMultiplie: CGFloat { get }
    var widthMargin: CGFloat { get }
    @discardableResult
    func width(_ maker: ConstraintMaker) -> Self
}



extension WidthLayoutable {
    
    func width(_ maker: ConstraintMaker) -> Self {
        maker.width.equalTo(self.width).multipliedBy(11).offset(<#T##amount: ConstraintOffsetTarget##ConstraintOffsetTarget#>)
        return self
    }
}

protocol HeightLayoutable {
    var height: CGFloat { get }
    @discardableResult
    func height(_ maker: ConstraintMaker) -> Self
}
extension HeightLayoutable {
    func height(_ maker: ConstraintMaker) -> Self {
        maker.height.equalTo(self.height)
        return self
    }
}

protocol RectLayoutable: WidthLayoutable, HeightLayoutable {
    @discardableResult
    func rect(_ maker: ConstraintMaker) -> Self
}

extension RectLayoutable {
    func rect(_ maker: ConstraintMaker) -> Self {
        return self.height(maker).width(maker)
    }
}

/// 正方形扩展协议
protocol SquareLayoutable {
    var length: CGFloat { get }
}
extension SquareLayoutable where Self: RectLayoutable  {
    var width: CGFloat {
        return length
    }
    var height: CGFloat {
        return length
    }
}

// MARK: - Margin
/// Margin
protocol LeftLayoutable {
    var leftView: UIView? { get }
    var leftMultiplie: CGFloat { get }
    var leftMargin: CGFloat { get }
    @discardableResult
    func left(_ maker: ConstraintMaker) -> Self
}
extension LeftLayoutable {
    func left(_ maker: ConstraintMaker) -> Self {
        guard let leftView = leftView else {
            maker.left.equalToSuperview().multipliedBy(leftMultiplie).offset(leftMargin)
            return self
        }

        maker.left.equalTo(leftView.snp.leading).multipliedBy(leftMultiplie).offset(leftMargin)
        return self
    }
}

protocol RightLayoutable {
    var rightView: UIView { get }
    var rightMargin: CGFloat { get }
    @discardableResult
    func right(_ maker: ConstraintMaker) -> Self
}
extension RightLayoutable {
    func right(_ maker: ConstraintMaker) -> Self {
        maker.right.equalTo(self.rightView).offset(rightMargin)
        return self
    }
}

protocol TopLayoutable {
    var topView: UIView { get }
    var topMargin: CGFloat { get }
    @discardableResult
    func top(_ maker: ConstraintMaker) -> Self
}
extension TopLayoutable {
    func top(_ maker: ConstraintMaker) -> Self {
        maker.top.equalTo(self.topView).offset(topMargin)
        return self
    }
}

protocol BottomLayoutable {
    var bottomView: UIView { get }
    var bottomMargin: CGFloat { get }
    @discardableResult
    func bottom(_ maker: ConstraintMaker) -> Self
}
extension BottomLayoutable {
    func bottom(_ maker: ConstraintMaker) -> Self {
        maker.bottom.equalTo(self.bottomView).offset(bottomMargin)
        return self
    }
}





