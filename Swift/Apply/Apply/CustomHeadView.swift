//
//  CustomHeadView.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/30.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit



class CustomHeadView: ApplyHeadView, ApplyHeadViewProtocol {
    
    fileprivate var headViewCells = [HeadViewCell]()
    
    var cellHeight: CGFloat = 50.0
    
    fileprivate var titles = [String]()
    
    var headViewHeight: CGFloat {
        return cellHeight * titles.count.f + 17.f
    }
    
    
    init(titles: [String]) {
        super.init(frame: .zero)
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
            let topConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .top, multiplier: 1.0, constant: (headViewCells.count - 1).f * cellHeight)
            let heightConstraint = NSLayoutConstraint(item: headViewCell, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cellHeight)
            headViewCell.addConstraint(heightConstraint)
            self.addConstraints([leftConstraint, rightConstraint, topConstraint])
            }())
    }
}
