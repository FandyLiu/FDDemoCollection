//
//  SegmentedHeadView.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/31.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit




class SegmentedHeadView: ApplyHeadView {
    
    fileprivate var images = [String]()

    init(images: [String]) {
        self.images = images
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        let segmentedImageView = SegmentedImageView(segmentedImageStrs: images) { [weak self] (index) in
            self?.delegate?.didSelect?(self!, index: index)
        }
        addSubview(segmentedImageView)
        segmentedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 15 5
        let topConstraint = NSLayoutConstraint(item: segmentedImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 15.0)
        let centerXConstraint = NSLayoutConstraint(item: segmentedImageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0)
        self.addConstraints([topConstraint, centerXConstraint])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
