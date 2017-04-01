//
//  CustomTableViewCell.swift
//  Apply
//
//  Created by QianTuFD on 2017/3/28.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit


enum CommonTableViewCellType {
    case describe(title: String, subtitle: String)
    case input0(title: String, placeholder: String)
    case input1(title: String, rightplaceholder: String)
    case input2(placeholder: String)
    case verification(placeholder: String)
}


class CommonTableViewCell: ApplyTableViewCell, ApplyTableViewCellProtocol {

    
    static let indentifier = "CommonTableViewCell"
    
    var titleLabelWidth: CGFloat {
        let text: NSString = "你好你好："
        let contentSize = CGSize(width: CGFloat(MAXFLOAT) , height: CGFloat(MAXFLOAT))
        return text.textSizeWith(contentSize: contentSize, font: titleLabel.font).width
    }
    
    var separatorLeftConstraint: NSLayoutConstraint?
    var textFieldRightConstraint: NSLayoutConstraint?
    var textFieldLeftConstraint: NSLayoutConstraint?
    
    var myType: CommonTableViewCellType = .describe(title: "", subtitle: "") {
        didSet {
            switch self.myType {
            case let .describe(title: title, subtitle: subtitle):
                
                self.descriptionLabel.text(contents: (text: title, font: FONT_28PX), (text: subtitle, font: FONT_24PX))
                
                separatorLeftConstraint?.constant = 0
                
                show(views: descriptionLabel)
                
            case let .input0(title: title, placeholder: placeholder):
                titleLabel.text = title
                textField.placeholder = placeholder
                separatorLeftConstraint?.constant = 15
                textFieldLeftConstraint?.constant = 0.0
                textFieldRightConstraint?.constant = 0.0
                
                titleLabel.alignmentJustify_colon(withWidth: titleLabelWidth)
                
                show(views: titleLabel, textField)
                
            case let .input1(title: title, rightplaceholder: rightplaceholder):
                titleLabel.text = title
                textField.placeholder = rightplaceholder
                separatorLeftConstraint?.constant = 15
                textFieldLeftConstraint?.constant = 0.0
                textFieldRightConstraint?.constant = 0.0
                
                show(views: titleLabel, textField, arrowImageView)
            case let .input2(placeholder: placeholder):
                textField.placeholder = placeholder
                separatorLeftConstraint?.constant = 15
                textFieldLeftConstraint?.constant = -titleLabelWidth
                textFieldRightConstraint?.constant = 0.0
                show(views: textField)
            case let .verification(placeholder: placeholder):
                textField.placeholder = placeholder
                separatorLeftConstraint?.constant = 15
                textFieldLeftConstraint?.constant = -titleLabelWidth
                textFieldRightConstraint?.constant = -100.0
                show(views: textField, verificationButton)
            }
        }
    }
    
    override var textFieldText: String? {
        didSet {
            textField.text = textFieldText
        }
    }
    
    func show(views: UIView...) {
        for view in mycontentView.subviews {
            if views.contains(view) {
                view.isHidden = false
            }else {
                view.isHidden = true
            }
        }
    }

    let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = COLOR_dadada
        return separatorView
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        descriptionLabel.backgroundColor = UIColor.red
        descriptionLabel.textColor = COLOR_666666
        descriptionLabel.font = FONT_28PX
        return descriptionLabel
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.backgroundColor = UIColor.green
        titleLabel.textColor = COLOR_222222
        titleLabel.font = FONT_28PX
        return titleLabel
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = UIColor.blue
        textField.textColor = COLOR_222222
        textField.font = FONT_28PX
        return textField
    }()
    
    let arrowImageView: UIImageView = {
        let arrow = UIImageView(image: UIImage(named: "icon"))
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    let verificationButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("获取验证码", for: .normal)
        btn.backgroundColor = COLOR_1478b8
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = FONT_24PX
        btn.layer.cornerRadius = 5.f
        btn.layer.masksToBounds = true
        return btn
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.delegate = self
        verificationButton.addTarget(self, action: #selector(CommonTableViewCell.btnClick(btn:)), for: .touchUpInside)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnClick(btn: UIButton) {
        self.window?.endEditing(true)
        delegate?.commonCell?(self, verificationButtonClick: btn)
    }
}

// MARK: - UITextFieldDelegate
extension CommonTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.commonCell?(self, textFieldDidEndEditing: textField)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch myType {
        case .input1:
            window?.endEditing(true)
            delegate?.commonCell?(self, arrowCellClick: textField)
            return false
        default:
            return true
        }
    }
}


// MARK: - UI
extension CommonTableViewCell {
    fileprivate func setupUI() {
        
        contentView.addSubview(separatorView)
        mycontentView.addSubview(descriptionLabel)
        mycontentView.addSubview(titleLabel)
        mycontentView.addSubview(textField)
        mycontentView.addSubview(arrowImageView)
        mycontentView.addSubview(verificationButton)

                
        // separatorView
        ({
            let leftConstraint = NSLayoutConstraint(item: separatorView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            separatorLeftConstraint = leftConstraint
            let rightConstraint = NSLayoutConstraint(item: separatorView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            let bottomConstraint = NSLayoutConstraint(item: separatorView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
            let heightConstraint = NSLayoutConstraint(item: separatorView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 1)
            separatorView.addConstraint(heightConstraint)
            contentView.addConstraints([leftConstraint, rightConstraint, bottomConstraint])
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
            
            let leftConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
            let centerYConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            let widthConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: titleLabelWidth + 0.5)
            mycontentView.addConstraints([leftConstraint, centerYConstraint])
            titleLabel.addConstraint(widthConstraint)
            }())
        
        // textField
        
        ({
            let leftConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            textFieldLeftConstraint = leftConstraint
            let rightConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: 0.0)
            textFieldRightConstraint = rightConstraint
            let centerYConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([leftConstraint, rightConstraint, centerYConstraint])
            }())
        // arrowImageView
        
        ({
            let rightConstraint = NSLayoutConstraint(item: arrowImageView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -2.0)
            let centerYConstraint = NSLayoutConstraint(item: arrowImageView , attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            mycontentView.addConstraints([rightConstraint, centerYConstraint])
            }())
        
        // verificationButton
        
        ({
            let widthConstraint = NSLayoutConstraint(item: verificationButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 80)
            let heightConstraint = NSLayoutConstraint(item: verificationButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 27)
            let rightConstraint = NSLayoutConstraint(item: verificationButton, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -3.0)
            let centerYConstraint = NSLayoutConstraint(item: verificationButton , attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: mycontentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
            verificationButton.addConstraints([widthConstraint, heightConstraint])
            mycontentView.addConstraints([rightConstraint, centerYConstraint])
            }())
    }
}
