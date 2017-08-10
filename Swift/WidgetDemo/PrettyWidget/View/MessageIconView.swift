//
//  MessageIconView.swift
//  WidgetDemo
//
//  Created by QianTuFD on 2017/6/26.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class MessageIconView: UIView {
    /// Icon
    fileprivate lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.makeLayout(LeftCenterSquareLayout(leftView: self, length: 50))
        return icon
    }()
    

}
