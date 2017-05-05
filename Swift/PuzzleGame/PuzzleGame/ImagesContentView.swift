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
        
        for i in 0..<Int(space.rows * space.cols - 1) {
            let imageView = UIImageView()
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let subViewWidth = self.frame.width / space.cols.f
        let subViewHeight = self.frame.height / space.rows.f
        for imageView in imageViews {
            let currenRow = imageView.tag / Int(space.rows)
            let currenCol = imageView.tag % Int(space.rows)
            imageView.frame = CGRect(x: subViewWidth * currenCol.f, y: subViewHeight * currenRow.f, width: subViewWidth, height: subViewHeight)
        }
    }
    
    func imageViewClick(ges: UIGestureRecognizer) {
        // 移动图片
//        let tapImageView = ges.view
//        
//        let tapFrame = tapView?.frame
//        let isOnTheSpaceTop = tapFrame?.minX == lastRect?.minX && tapFrame?.maxY == lastRect?.minY
//        let isOnTheSpaceBottom = tapFrame?.minX == lastRect?.minX && tapFrame?.minY == lastRect?.maxY
//        let isOnTheSpaceLeft = tapFrame?.maxY == lastRect?.minX && tapFrame?.minY == lastRect?.minY
//        let isOnTheSpaceRight = tapFrame?.minX == lastRect?.maxY && tapFrame?.minY == lastRect?.minY
//        
//        if isOnTheSpaceTop || isOnTheSpaceLeft || isOnTheSpaceRight || isOnTheSpaceBottom {
//            let toRect = lastRect
//            lastRect = tapView?.frame
//            for constraint in self.constraints {
//                guard constraint.firstItem.isEqual(tapView) else {
//                    continue
//                }
//                if constraint.firstAttribute == .top {
//                    constraint.constant = (toRect?.minY)!
//                }else if constraint.firstAttribute == .left {
//                    constraint.constant = (toRect?.minX)!
//                }
//            }
//            print("count = \(self.constraints.count)")
//        }
    }

    /*
    func addSubViewsConstracts(width: CGFloat, height: CGFloat) {
        for imageView in imageViews {
            guard space.rows > 0 && space.cols > 0 else {
                assertionFailure("列数或者行数不能小于0")
                return
            }
            
            let currenRows = imageView.tag / Int(space.rows)
            let currenCols = imageView.tag % Int(space.rows)
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
 */
}
