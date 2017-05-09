//
//  ImagesContentView.swift
//  PuzzleGame
//
//  Created by QianTuFD on 2017/5/3.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit


/// 子图片总共行列数
struct Space {
    let rows: UInt
    let cols: UInt
}

protocol ImagesContentViewDelegate: NSObjectProtocol {
    
    /// 回复原图回调
    ///
    /// - Parameter imagesContentView: 回复原图回调
    func imagesContentViewDidFinishRecover(_ imagesContentView: ImagesContentView)
}

class ImagesContentView: UIView {
    /// 子图片总共行列数
    fileprivate let space: Space
    
    /// 是否已经更新过子视图
    private var isSetupSubViews: Bool
    
    /// 所有子视图集合
    private(set) var imageViews = [UIImageView]()
    
    /// 没有图片的空方块 frame
    private var lastRect: CGRect?
    
    /// key为打乱后位置,value打乱前位置
    private lazy var placeDict = [Int: Int]()
    
    /// 代理
    weak open var delegate: ImagesContentViewDelegate?
    
    /// 子视图原始图片内容
    var originImages = [UIImage]() {
        didSet {
            for i in 0..<originImages.count {
                placeDict[i] = i
            }
            images = originImages
        }
    }
    
    /// 子视图显示的图片内容
    private var images = [UIImage]() {
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
        isSetupSubViews = false
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
        if !isSetupSubViews {
            let subViewWidth = self.frame.width / space.cols.f
            let subViewHeight = self.frame.height / space.rows.f
            for imageView in imageViews {
                let currenRow = imageView.tag / Int(space.cols)
                let currenCol = imageView.tag % Int(space.cols)
                imageView.frame = CGRect(x: subViewWidth * currenCol.f, y: subViewHeight * currenRow.f, width: subViewWidth, height: subViewHeight)
            }
            lastRect = CGRect(x: self.frame.width - subViewWidth, y: self.frame.height - subViewHeight, width: subViewWidth, height: subViewHeight)
            isSetupSubViews = true
        }
    }
    
    
    @objc fileprivate func imageViewClick(ges: UIGestureRecognizer) {
        // 移动图片
        let tapImageView = ges.view
        
        let tapFrame = tapImageView?.frame
        let isOnTheSpaceTop = tapFrame?.minX ≈≈≈ lastRect?.minX && tapFrame?.maxY ≈≈≈ lastRect?.minY
        let isOnTheSpaceBottom = tapFrame?.minX ≈≈≈ lastRect?.minX && tapFrame?.minY ≈≈≈ lastRect?.maxY
        let isOnTheSpaceLeft = tapFrame?.maxX ≈≈≈ lastRect?.minX && tapFrame?.minY ≈≈≈ lastRect?.minY
        let isOnTheSpaceRight = tapFrame?.minX ≈≈≈ lastRect?.maxX && tapFrame?.minY ≈≈≈ lastRect?.minY
        
        if isOnTheSpaceTop || isOnTheSpaceLeft || isOnTheSpaceRight || isOnTheSpaceBottom {
            guard let lastRect = lastRect else {
                assertionFailure("最后Rect妹纸")
                return
            }
            let temp = tapImageView?.frame
            tapImageView?.frame = lastRect
            self.lastRect = temp
            
            let isFinish = checkOutIsFinish()
            if isFinish {
                delegate?.imagesContentViewDidFinishRecover(self)
            }
        }
    }
    
    /// 打乱子视图图片顺序
    func disorganizeSubimageViews() {
        placeDict.removeAll()
        let randomImages = originImages.random()
        for (i, image) in randomImages.enumerated() {
            let index = originImages.index(of: image)
            placeDict[i] = index
        }
        images = randomImages
    }
    
    func checkOutIsFinish() -> Bool {
        let subViewWidth = self.frame.width / space.cols.f
        let subViewHeight = self.frame.height / space.rows.f
        for imageView in imageViews {
            guard let placeOfImageView = placeDict[imageView.tag] else {
                assertionFailure("先初始化 placeDict")
                return false
            }
            let currenRow = placeOfImageView / Int(space.cols)
            let currenCol = placeOfImageView % Int(space.cols)
            let correctFrame = CGRect(x: subViewWidth * currenCol.f, y: subViewHeight * currenRow.f, width: subViewWidth, height: subViewHeight)
            let rectIsEqual = imageView.frame ≈≈≈ (correctFrame)
            guard rectIsEqual else {
                return false
            }
        }
        return true
    }
}


infix operator ≈≈≈: ComparisonPrecedence
func ≈≈≈(lhs: CGFloat?, rhs: CGFloat?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
        return false
    }
    let l = String(format: "%.5f", lhs)
    let r = String(format: "%.5f", rhs)
    return l == r
}

func ≈≈≈(lhs: CGRect?, rhs: CGRect?) -> Bool {
    guard let lhs = lhs, let rhs = rhs else {
        return false
    }
    if lhs.origin.x ≈≈≈ rhs.origin.x &&
        lhs.origin.y ≈≈≈ rhs.origin.y &&
        lhs.width ≈≈≈ rhs.width &&
        lhs.height ≈≈≈ rhs.height
    {
        return true
    }
    return false
}







