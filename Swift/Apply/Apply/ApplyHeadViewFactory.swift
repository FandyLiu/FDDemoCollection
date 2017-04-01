//
//  ApplyHeadViewFactory.swift
//  Apply
//
//  Created by QianTuFD on 2017/4/1.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyHeadViewFactory {
    class func applyHeadView<Head: ApplyHeadView>(style: ApplyHeadViewStyle) -> Head? where Head: ApplyHeadViewProtocol {
        switch style {
        case let .custom(titles: titles):
            return CustomHeadView(titles: titles) as? Head
        case let .segmented(images: images):
            return SegmentedHeadView(images: images) as? Head
        case .none:
            return nil
        }

    }
}
