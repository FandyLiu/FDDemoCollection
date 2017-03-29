//
//  CustomTableViewCell.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

enum CustomTableViewCellType {
    case describe(title: String, subtitle: String)
    case input0(title: String, placeholder: String)
    case input1(title: String, rightplaceholder: String)
}


class CustomTableViewCell: UITableViewCell {
    
    static let indentifier = "CustomTableViewCell"
    
    /// 最外层view
    let mycontentView: UIView = {
        let mycontentView = UIView()
        mycontentView.translatesAutoresizingMaskIntoConstraints = false
        mycontentView.backgroundColor = UIColor.gray
        return mycontentView
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.backgroundColor = UIColor.red
        descriptionLabel.text = "aaaa"
        descriptionLabel.textColor = COLOR_666666
        descriptionLabel.font = FONT_28PX
        return descriptionLabel
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.backgroundColor = UIColor.green
        titleLabel.text = "你好你好："
        titleLabel.textColor = COLOR_222222
        titleLabel.font = FONT_28PX
        return titleLabel
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.blue
        textField.text = "你好你好："
        textField.textColor = COLOR_222222
        textField.font = FONT_28PX
        return textField
    }()
    
    let arrowImageView: UIImageView = {
        let arrow = UIImageView(image: UIImage(named: "icon"))
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        contentView.addSubview(mycontentView)
        mycontentView.addSubview(descriptionLabel)
        mycontentView.addSubview(titleLabel)
        mycontentView.addSubview(textField)
        mycontentView.addSubview(arrowImageView)
        
        // mycontentView
        ({
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[mycontentView]-25-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["mycontentView" : mycontentView]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mycontentView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["mycontentView" : mycontentView]))
            }())
        // descriptionLabel
        ({
            let leftConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let rightConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: descriptionLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([leftConstraint, rightConstraint, centerYConstraint])
            }())
        
        
        // titleLabel
        ({
            let text: NSString = "你好你好："
            let contentSize = CGSize(width: CGFloat(MAXFLOAT) , height: CGFloat(MAXFLOAT))
            let width = text.textSizeWith(contentSize: contentSize, font: titleLabel.font).width + 2
            
            let leftConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            let widthConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: width)
            mycontentView.addConstraints([leftConstraint, centerYConstraint])
            titleLabel.addConstraint(widthConstraint)
            }())
        
        // textField
        
        ({
            let leftConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 2.0)
            let rightConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -25.0)
            let centerYConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([leftConstraint, rightConstraint, centerYConstraint])
            }())
        // arrowImageView
        
        ({
            let rightConstraint = NSLayoutConstraint(item: arrowImageView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -2.0)
            let centerYConstraint = NSLayoutConstraint(item: arrowImageView , attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([rightConstraint, centerYConstraint])
            }())
        
    }
    
    
    var type: CustomTableViewCellType = .describe(title: "", subtitle: "")
    
}
