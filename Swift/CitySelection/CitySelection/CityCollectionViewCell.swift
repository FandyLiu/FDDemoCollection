//
//  CityCollectionViewCell.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/22.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CityCollectionViewCellIdentifier"
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.layer.cornerRadius = 5.5
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        layer.cornerRadius = 5.5
        layer.masksToBounds = true
        
        addSubview(label)
        let bindings = ["label": label]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[label]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[label]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: bindings))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
