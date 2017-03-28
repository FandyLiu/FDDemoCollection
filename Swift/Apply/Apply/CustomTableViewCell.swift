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
    case input(title: String)
    case inputWithPlaceholder(title: String, placeholder: String)
    case inputWithRightPlaceholder(title: String, rightplaceholder: String)
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
        descriptionLabel.textColor = 
        descriptionLabel.font = UIFont.systemFont(ofSize: 28.0)
        return descriptionLabel
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let arrowImageView: UIImageView = {
        let arrow = UIImageView(image: UIImage(named: "icon"))
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(mycontentView)
        mycontentView.addSubview(descriptionLabel)
        mycontentView.addSubview(titleLabel)
        
        // mycontentView
        ({
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-50-[mycontentView]-50-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["mycontentView" : mycontentView]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mycontentView]-0-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["mycontentView" : mycontentView]))
            }())
        
        // descriptionLabel
        ({
            mycontentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[descriptionLabel]-0-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["descriptionLabel" : descriptionLabel]))
            mycontentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[descriptionLabel]-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: ["descriptionLabel" : descriptionLabel]))
            }())
        
    }
    
    
    var type: CustomTableViewCellType = .describe(title: "", subtitle: "")
    
}
