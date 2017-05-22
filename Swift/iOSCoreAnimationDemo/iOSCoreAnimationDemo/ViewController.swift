//
//  ViewController.swift
//  iOSCoreAnimationDemo
//
//  Created by QianTuFD on 2017/4/24.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    lazy var layerView: UIView = {
        let layerView = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        self.layerView = layerView
        layerView.backgroundColor = UIColor.white
        return layerView
    }()
    lazy var blueLayer: CALayer = {
        let blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.contents = UIImage(named: "icon_change")?.cgImage
        return blueLayer
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
    @IBAction func draw(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(imageView)

        
    }
    

    
    
}






