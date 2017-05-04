//
//  ImagesContentView.swift
//  PuzzleGame
//
//  Created by QianTuFD on 2017/5/3.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

struct Space {
    let rows: UInt
    let cols: UInt
}

class ImagesContentView: UIView {
    fileprivate let space: Space
    private(set) var imageViews = [UIImageView]()
    private(set) var topConstraint = [NSLayoutConstraint]()
    private(set) var leftConstraint = [NSLayoutConstraint]()
    var images = [UIImage]() {
        didSet {
            if images.count > imageViews.count {
                assertionFailure("图片数量太多了")
            }
            for (index, image) in images.enumerated() {
                imageViews[index].image = image
            }
            
        }
    }
    
    init(space: Space) {
        self.space = space
        super.init(frame: .zero)
        for i in 0..<Int(space.rows * space.cols) {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            imageView.tag = i
            imageViews.append(imageView)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(imageViewClick(ges:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGes)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageViewClick(ges: UIGestureRecognizer) {
        // 移动图片
        let tapView = ges.view
        dump(tapView?.constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        addSubViewsConstracts()
    }
    


    func addSubViewsConstracts() {
        for imageView in imageViews {
            guard space.rows > 0 && space.cols > 0 else {
                assertionFailure("列数或者行数不能小于0")
                return
            }
            
            let currenRows = imageView.tag / Int(space.rows)
            let currenCols = imageView.tag % Int(space.rows)
            let width = self.frame.width / space.cols.f
            let height = self.frame.height / space.rows.f
            
            let topConstraint = NSLayoutConstraint(item: imageView,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: currenRows.f * height)
            
            let leftConstraint = NSLayoutConstraint(item: imageView,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .left,
                                                    multiplier: 1.0,
                                                    constant: currenCols.f * width)
            
            let widthConstraint = NSLayoutConstraint(item: imageView,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 0.0,
                                                     constant: width)
            
            let heightConstraint = NSLayoutConstraint(item: imageView,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 0.0,
                                                      constant: height)
            imageView.addConstraints([widthConstraint, heightConstraint])
            addConstraints([topConstraint, leftConstraint])
        }
        
    }

}
