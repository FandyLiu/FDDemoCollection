//
//  CustomHeadView.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/30.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit



class CustomHeadView: ApplyHeadView {
    
    fileprivate var headViewCells = [HeadViewCell]()
    
    fileprivate let cellHeight: CGFloat = 50.0
    
    fileprivate var titles = [String]()
    
    override var headViewHeight: CGFloat {
        return cellHeight * titles.count.f + 17.f + topViewHeight
    }
    
    
    init(_ topImage: String, _ titles: [String]) {
        super.init(topImage: topImage)
        backgroundColor = UIColor.white
        self.titles = titles
        for title in titles {
            let headViewCell = HeadViewCell(title: title)
            addSubview(headViewCell)
            headViewCells.append(headViewCell)
            setupConstraint(of: headViewCell)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension CustomHeadView {
    fileprivate func setupConstraint(of headViewCell: HeadViewCell) {
        ({
            headViewCell.translatesAutoresizingMaskIntoConstraints = false
            let leftConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let rightConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            let topConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: topView, attribute: .bottom, multiplier: 1.0, constant: (headViewCells.count - 1).f * cellHeight)
            let heightConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cellHeight)
            headViewCell.addConstraint(heightConstraint)
            self.addConstraints([leftConstraint, rightConstraint, topConstraint])
            }())
    }
}
