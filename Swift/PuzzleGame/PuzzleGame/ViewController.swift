//
//  ViewController.swift
//  PuzzleGame
//
//  Created by QianTuFD on 2017/5/2.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let space: Space
    public static let margin: CGFloat = 80
    
//    lazy var croppedImageViewWidth: CGFloat = {
//        return (UIScreen.main.bounds.width - 2 * margin) / self.space.rows.f
//    }()
//    lazy var croppedImageViewHeight: CGFloat = {
//        return (UIScreen.main.bounds.width - 2 * margin) / self.space.cols.f
//    }()
    
    /// 原图片
    fileprivate lazy var sourceImageView: UIImageView = {
        let sourceImageView = UIImageView()
        sourceImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceImageView.backgroundColor = UIColor.gray
        return sourceImageView
    }()
    
    /// 拆分imageView盛放视图
    fileprivate lazy var imagesContentView: ImagesContentView = {
        let imagesContentView = ImagesContentView(space: self.space)
        imagesContentView.translatesAutoresizingMaskIntoConstraints = false
        imagesContentView.backgroundColor = UIColor.gray
        return imagesContentView
    }()
    
    /// 初始切割后的图片
    fileprivate lazy var originImages: [UIImage] = {
        guard let image: UIImage = self.sourceImageView.image else {
            return [UIImage]()
        }
        return image.cropping(rows: self.space.rows, cols: self.space.cols)
    }()
    
//    /// Images集合
//    fileprivate var puzzleImages = [UIImage]()
    
    
    
    init(space: Space) {
        self.space = space
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sourceImageView)
        view.addSubview(imagesContentView)
        
        addSubViewsConstracts()
        
        guard let image = UIImage(named: "test.jpg") else {
            assertionFailure("图片不存在")
            return
        }
        sourceImageView.image = image
        puzzle()
    }
    
    
    /// 打乱顺序
    func puzzle() {
        var croppedImages = self.originImages
        if croppedImages.count < 1 {
            assertionFailure("count 不能小于1")
        }
        croppedImages.removeLast()
        croppedImages = croppedImages.random()
        imagesContentView.images = croppedImages
    }




}



// MARK: - 约束
extension ViewController {

    /// 添加约束
    func addSubViewsConstracts() {
        // sourceImageView
        ({
            let topConstraint = NSLayoutConstraint(item: sourceImageView,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: 50.0)
            
            let leftConstraint = NSLayoutConstraint(item: sourceImageView,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .left,
                                                    multiplier: 1.0,
                                                    constant: ViewController.margin)
            
            let rightConstraint = NSLayoutConstraint(item: sourceImageView,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: view,
                                                     attribute: .right,
                                                     multiplier: 1.0,
                                                     constant: -ViewController.margin)
            
            let heightConstraint = NSLayoutConstraint(item: sourceImageView,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: sourceImageView,
                                                      attribute: .width,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
            
            view.addConstraints([topConstraint, leftConstraint, rightConstraint])
            sourceImageView.addConstraint(heightConstraint)
            }())
        
        // imagesContentView
        ({
            let bottomConstraint = NSLayoutConstraint(item: imagesContentView,
                                                      attribute: .bottom,
                                                      relatedBy: .equal,
                                                      toItem: view,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: -50.0)
            
            let leftConstraint = NSLayoutConstraint(item: imagesContentView,
                                                    attribute: .left,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .left,
                                                    multiplier: 1.0,
                                                    constant: ViewController.margin)
            
            let rightConstraint = NSLayoutConstraint(item: imagesContentView,
                                                     attribute: .right,
                                                     relatedBy: .equal,
                                                     toItem: view,
                                                     attribute: .right,
                                                     multiplier: 1.0,
                                                     constant: -ViewController.margin)
            
            let heightConstraint = NSLayoutConstraint(item: imagesContentView,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: imagesContentView,
                                                      attribute: .width,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
            
            view.addConstraints([bottomConstraint, leftConstraint, rightConstraint])
            imagesContentView.addConstraint(heightConstraint)
            }())
    }
}

