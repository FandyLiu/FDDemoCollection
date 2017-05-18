//
//  ImageTableViewCell.swift
//  RunLoop
//
//  Created by QianTuFD on 2017/3/22.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier = "cell"

    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    @IBOutlet weak var imageView3: UIImageView!
    
    @IBOutlet weak var imageView4: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
