//
//  TitleHeadView.swift
//  CitySelection
//
//  Created by QianTuFD on 2017/5/23.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class TitleHeadView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "TitleHeadViewIdentifier"
    
    var title: String = "" {
        didSet {
            label.text = title
        }
    }
    
    /// titlelabel
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(label)
        
        let bindings = ["label": label]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[label]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[label]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: bindings))
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
