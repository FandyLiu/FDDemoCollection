//
//  CellExtension.swift
//  RunLoop
//
//  Created by QianTuFD on 2017/3/23.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

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
