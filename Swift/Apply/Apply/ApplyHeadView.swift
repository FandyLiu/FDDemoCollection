//
//  ApplyHeadView.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/31.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

enum ApplyHeadViewStyle {
    case none
    case custom(titles: [String])
    case segmented(images: [String])
}

protocol ApplyHeadViewProtocol {
    var headViewHeight: CGFloat { get }
}

protocol ApplyHeadViewDelegate: SegmentedHeadViewDelegate {
    
}

// sub
@objc protocol SegmentedHeadViewDelegate: NSObjectProtocol {
    @objc optional func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int)
}

class ApplyHeadView: UIView {
    weak open var delegate: ApplyHeadViewDelegate?
}
