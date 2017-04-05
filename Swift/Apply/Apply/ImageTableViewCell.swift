//
//  ImageTableViewCell.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/31.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

enum ImageTableViewCellType {
    case images(images: [String])
    case titleImages(title: String, images: [String])
}

class ImageTableViewCell: ApplyTableViewCell, ApplyTableViewCellProtocol {

    
    static let indentifier = "ImageTableViewCell"
    
    fileprivate var images = [String]()
    fileprivate var title: String?
    fileprivate var imageViews = [UIImageView]()
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FONT_28PX
        label.textColor = COLOR_666666
        return label
    }()
    
    var myType: ImageTableViewCellType = .images(images: [String]()) {
        didSet {
            for view in mycontentView.subviews {
                view.removeFromSuperview()
            }
            imageViews.removeAll()
            
            switch myType {
            case let .images(images: images):
                mycontentViewTopConstraint?.constant = 5
                self.images = images
//                self.title = nil
            case let .titleImages(title, images):
                mycontentViewTopConstraint?.constant = 0
                self.images = images
                self.title = title
            }
            setupUI()
        }
    }

    
    func setupUI() {
        guard let title = title else {
            setupConstraint(of: images, firstToItem: mycontentView, firstC: 25)
           return
        }
        
        titleLabel.text = title
        mycontentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        mycontentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: mycontentView, attribute: .top, multiplier: 1.0, constant: 11.0))
        mycontentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: mycontentView, attribute: .left, multiplier: 1.0, constant: 0.0))
        setupConstraint(of: images, firstToItem: titleLabel, firstC: 13)
        
    }
    
    func setupConstraint(of images: [String], firstToItem: UIView, firstC: CGFloat) {
        for image in images {
            let image = UIImage(named: image)
            let imageView = UIImageView(image: image)
            mycontentView.addSubview(imageView)
            var toItem = firstToItem
            var c: CGFloat = firstC
            var toAttribute: NSLayoutAttribute = .bottom
            if let lastImageView = imageViews.last {
                toItem = lastImageView
                c = 22
            }
            if toItem == mycontentView {
                toAttribute = .top
            }
            
            imageViews.append(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            guard let size = image?.size else {
                print("image size 有问题,或没有image")
                return
            }
            mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: mycontentView, attribute: .width, multiplier: 1.0, constant: 0.0))
            mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: mycontentView, attribute: .width, multiplier: size.height / size.width, constant: 0.0))
            
            mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: toAttribute, multiplier: 1.0, constant: c))
            mycontentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: mycontentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            
        }

    }
    

}
