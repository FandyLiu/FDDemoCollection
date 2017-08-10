//
//  CustomLayoutable.swift
//  WidgetDemo
//
//  Created by QianTuFD on 2017/6/27.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit
import SnapKit
// MARK: - Margin
/// MarginLayoutable
protocol MarginLayoutable: Layoutable, LeftLayoutable, RightLayoutable, TopLayoutable, BottomLayoutable { }
extension MarginLayoutable {
    var layoutMaker: (ConstraintMaker) -> Void {
        return { maker in
            self.left(maker).right(maker).top(maker).bottom(maker)
        }
    }
}

// MARK: - Left with Rect

// MARK: Top
/// LeftTopRectLayoutable
protocol LeftTopRectLayoutable: Layoutable, RectLayoutable, LeftLayoutable, TopLayoutable { }
extension LeftTopRectLayoutable {
    var layoutMaker: (ConstraintMaker) -> Void {
        return { maker in
            self.rect(maker).left(maker).top(maker)
        }
    }
}
/// LeftTopSquareLayoutable
protocol LeftTopSquareLayoutable: LeftTopRectLayoutable, SquareLayoutable { }


// MARK: Center
/// LeftCenterRectLayoutable
protocol LeftCenterRectLayoutable: Layoutable, RectLayoutable, LeftLayoutable { }
extension LeftCenterRectLayoutable {
    var layoutMaker: (ConstraintMaker) -> Void {
        return { maker in
            self.rect(maker).left(maker)
            maker.centerY.equalToSuperview()
        }
    }
}
/// LeftCenterSquareLayoutable
protocol LeftCenterSquareLayoutable: LeftCenterRectLayoutable, SquareLayoutable { }


// MARK: Bottom
/// LeftBottomRectangleLayoutable
protocol LeftBottomRectLayoutable: Layoutable, RectLayoutable, LeftLayoutable, BottomLayoutable { }
extension LeftBottomRectLayoutable {
    func layoutMaker() -> (ConstraintMaker) -> Void {
        return { maker in
            self.rect(maker).left(maker).bottom(maker)
        }
    }
}
/// LeftBottomSquareLayoutable
protocol LeftBottomSquareLayoutable: LeftBottomRectLayoutable, SquareLayoutable { }

// MARK: - Left Right with Height
protocol LeftTopRightHeightLayoutable: Layoutable, LeftLayoutable, TopLayoutable, RightLayoutable, HeightLayoutable { }
extension LeftTopRightHeightLayoutable {
    var layoutMaker: (ConstraintMaker) -> Void {
        return { maker in
            return self.left(maker).top(maker).right(maker).height(maker)
        }
    }
}




