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
    
    lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 200, y: 50, width: 100, height: 100)
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.frame = CGRect(x: 20, y: 20, width: 150, height: 150)
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "12345"
        label.backgroundColor = UIColor.white
        label.frame = CGRect(x: 20, y: 20, width: 100, height: 100)
        return label
    }()
    /*
     

     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        view.addSubview(imageView)
//        view.addSubview(imageView2)

        
        
        
    }
    

    
    
}






