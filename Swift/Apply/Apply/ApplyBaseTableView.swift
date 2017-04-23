//
//  ApplyBaseTableView.swift
//  Apply
//
//  Created by 刘欢 on 2017/4/21.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ApplyBaseTableView: UITableView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if ((view as? UITextField) != nil) {
            return view
        }
        endEditing(true)
        let isButton = view as? UIButton != nil
        let isImageView = view as? UIImageView != nil
        if isButton || isImageView {
            return view
        }
        return self
    }

}
