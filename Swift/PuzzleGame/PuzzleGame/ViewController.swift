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
    
    /// 原图片
    fileprivate lazy var sourceImageView: UIImageView = {
        let sourceImageView = UIImageView()
        sourceImageView.backgroundColor = UIColor.gray
        sourceImageView.translatesAutoresizingMaskIntoConstraints = false
        guard let image = UIImage(named: "test.jpg") else {
            assertionFailure("图片不存在")
            return sourceImageView
        }
        sourceImageView.image = image
        return sourceImageView
    }()
    
    /// 拆分imageView盛放视图
    fileprivate lazy var imagesContentView: ImagesContentView = {
        let imagesContentView = ImagesContentView(space: self.space)
        imagesContentView.translatesAutoresizingMaskIntoConstraints = false
        imagesContentView.backgroundColor = UIColor.gray
        return imagesContentView
    }()
    
    fileprivate lazy var resetButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("重置", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(puzzle), for: .touchUpInside)
        return button
    }()
    
    /// 初始切割后的图片集合
    fileprivate lazy var originImages: [UIImage] = {
        guard let image: UIImage = self.sourceImageView.image else {
            return [UIImage]()
        }
        return image.cropping(rows: self.space.rows, cols: self.space.cols)
    }()
    
    
    
    
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
        view.addSubview(resetButton)
        
        imagesContentView.delegate = self
        addSubViewsConstracts()
        
        
        
        var croppedImages = self.originImages
        if croppedImages.count < 1 {
            assertionFailure("count 不能小于1")
        }
        croppedImages.removeLast()
        imagesContentView.originImages = croppedImages
        puzzle()
    }
    
    
    /// 打乱顺序
    func puzzle() {
        imagesContentView.disorganizeSubimageViews()
    }

}

extension ViewController: ImagesContentViewDelegate {
    func imagesContentViewDidFinishRecover(_ imagesContentView: ImagesContentView) {
        print("完成")
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
        
        // imagesContentView
        ({
            let centerXConstraint = NSLayoutConstraint(item: resetButton,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: view,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
            
            let centerYConstraint = NSLayoutConstraint(item: resetButton,
                                                    attribute: .centerY,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .centerY,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
            
            view.addConstraints([centerXConstraint, centerYConstraint])
            }())
    }
}

