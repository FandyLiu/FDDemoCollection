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
    
    var myType: ImageTableViewCellType = .images(images: [String]())

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }

}
