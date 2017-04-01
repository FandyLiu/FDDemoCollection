//
//  ApplyTableViewCell.swift
//  Apply
//
//  Created by QianTuFD on 2017/4/1.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

protocol ApplyTableViewCellProtocol {
    associatedtype TableViewCellType
    static var indentifier: String { get }
    var myType: TableViewCellType { get set }
}


@objc protocol CommonTableViewCellDelegate: NSObjectProtocol {
    @objc optional func commonCell(_ commonCell: CommonTableViewCell, textFieldDidEndEditing textField: UITextField)
    @objc optional func commonCell(_ commonCell: CommonTableViewCell, verificationButtonClick verificationButton: UIButton)
    @objc optional func commonCell(_ commonCell: CommonTableViewCell, arrowCellClick textField: UITextField)
}

protocol ApplyTableViewCellDelegate: CommonTableViewCellDelegate {
    
}


class ApplyTableViewCell: UITableViewCell {
    
    weak var delegate: ApplyTableViewCellDelegate?
    var textFieldText: String?
    /// 最外层view
    let mycontentView: UIView = {
        let mycontentView = UIView()
        return mycontentView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(mycontentView)
        // mycontentView
        ({
            mycontentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-25-[mycontentView]-25-|", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: ["mycontentView" : mycontentView]))
            
            let bottomConstraint = NSLayoutConstraint(item: mycontentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
            let topConstraint = NSLayoutConstraint(item: mycontentView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
            contentView.addConstraints([bottomConstraint, topConstraint])
            }())

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
