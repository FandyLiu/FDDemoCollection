//
//  ApplyHeadView.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/31.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

protocol ApplyHeadViewProtocol {
    var headViewHeight: CGFloat { get }
}

@objc protocol SegmentedHeadViewDelegate: NSObjectProtocol {
    @objc optional func didSelect(_ segmentedHeadView: SegmentedHeadView, index: Int)
}

protocol ApplyHeadViewDelegate: SegmentedHeadViewDelegate {
    
}


extension ApplyHeadViewProtocol {
    var headViewHeight: CGFloat {
        return 50.0
    }
    
}

class ApplyHeadView: UIView, ApplyHeadViewProtocol, ApplyHeadViewDelegate {
    weak open var delegate: ApplyHeadViewDelegate?
}
