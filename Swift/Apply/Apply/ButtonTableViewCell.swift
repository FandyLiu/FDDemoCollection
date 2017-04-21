//
//  ButtonTableViewCell.swift
//  Apply
//
//  Created by QianTuFD on 2017/4/1.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

enum ButtonTableViewCellType {
    case button(title: String, top: CGFloat, bottom: CGFloat)
}

class ButtonTableViewCell: ApplyTableViewCell, ApplyTableViewCellProtocol {
    static var indentifier: String = "ButtonTableViewCell"
    
    fileprivate var buttonTopConstract: NSLayoutConstraint?
    var myType: ButtonTableViewCellType = .button(title: "", top: 0.0, bottom: 0.0) {
        didSet {
            cellType = ApplyTableViewCellType.button(myType)
            switch myType {
            case let .button(title: title, top: top, bottom: _):
                button.setTitle(title, for: UIControlState.normal)
                buttonTopConstract?.constant = top
            }
        
        }
    }
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = COLOR_1478b8
        button.layer.cornerRadius = 10.f
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mycontentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(ButtonTableViewCell.nextButtonClick(btn:)), for: UIControlEvents.touchUpInside)
        let topConstract = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: mycontentView, attribute: .top, multiplier: 1.0, constant: 20.0)
        let centerXConstract = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: mycontentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        mycontentView.addConstraints([topConstract, centerXConstract])
        let widthConstract = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 320)
        let heightConstract = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 45.0)
        buttonTopConstract = topConstract
        button.addConstraints([widthConstract, heightConstract])
        mycontentView.addConstraints([topConstract, centerXConstract])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func nextButtonClick(btn: UIButton) {
        delegate?.buttonCell?(self, nextButtonClick: btn)
    }

}
