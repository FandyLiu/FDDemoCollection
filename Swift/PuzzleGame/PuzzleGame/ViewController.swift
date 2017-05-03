//
//  ViewController.swift
//  PuzzleGame
//
//  Created by QianTuFD on 2017/5/2.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit


struct Space {
    let rows: UInt
    let cols: UInt
}

class ViewController: UIViewController {
    
    fileprivate let space: Space
    static let margin: CGFloat = 80
    
    lazy var croppedImageViewWidth: CGFloat = {
        return (UIScreen.main.bounds.width - 2 * margin) / self.space.rows.f
    }()
    lazy var croppedImageViewHeight: CGFloat = {
        return (UIScreen.main.bounds.width - 2 * margin) / self.space.cols.f
    }()
    
    /// 原图片
    fileprivate lazy var sourceImageView: UIImageView = {
        let sourceImageView = UIImageView()
        sourceImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceImageView.backgroundColor = UIColor.gray
        return sourceImageView
    }()
    
    /// 拆分imageView盛放视图
    fileprivate lazy var imagesContentView: UIView = {
        let imagesContentView = UIView()
        imagesContentView.translatesAutoresizingMaskIntoConstraints = false
        imagesContentView.backgroundColor = UIColor.gray
        return imagesContentView
    }()
    
    /// 初始切割后的图片
    fileprivate lazy var originImagesArray: [UIImage] = {
        guard let image: UIImage = self.sourceImageView.image else {
            return [UIImage]()
        }
        return image.cropping(rows: self.space.rows, cols: self.space.cols)
    }()
    
    /// contentView 中 ImagView集合
    fileprivate var puzzleImageViewsArray = [UIImageView]()
    
    
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
        var croppedImagesArray = self.originImagesArray
        if croppedImagesArray.count < 1 {
            assertionFailure("count 不能小于1")
        }
//        croppedImagesArray.removeLast()
        croppedImagesArray = croppedImagesArray.random()
        for i in 0..<Int(space.rows * space.cols) {
            let image = croppedImagesArray[i]
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imagesContentView.addSubview(imageView)
            
            imageView.tag = i
            addConstracts(of: imageView)
            puzzleImageViewsArray.append(imageView)
        }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}



// MARK: - 约束
extension ViewController {
    func addConstracts(of imageView: UIImageView) {
        guard space.rows > 0 && space.cols > 0 else {
            assertionFailure("列数或者行数不能为0")
            return
        }
        
        let currenRows = puzzleImageViewsArray.count / Int(space.rows)
        let currenCols = puzzleImageViewsArray.count % Int(space.rows)
        
        let topConstraint = NSLayoutConstraint(item: imageView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: imagesContentView,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: currenRows.f * croppedImageViewHeight)
        
        let leftConstraint = NSLayoutConstraint(item: imageView,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: imagesContentView,
                                                attribute: .left,
                                                multiplier: 1.0,
                                                constant: currenCols.f * croppedImageViewWidth)
        
        let widthConstraint = NSLayoutConstraint(item: imageView,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 0.0,
                                                 constant: croppedImageViewWidth)
        
        let heightConstraint = NSLayoutConstraint(item: imageView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 0.0,
                                                  constant: croppedImageViewHeight)
        imageView.addConstraints([widthConstraint, heightConstraint])
        imagesContentView.addConstraints([topConstraint, leftConstraint])
    }
    
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

