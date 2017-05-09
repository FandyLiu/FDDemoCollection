//
//  LayerTreeViewController.swift
//  iOSCoreAnimationDemo
//
//  Created by QianTuFD on 2017/4/24.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class LayerTreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        let rect = CGRect(x: 100, y: 100, width: 100, height: 100)
        let layerView = UIView(frame: rect)
        view.addSubview(layerView)
        let blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        layerView.layer .addSublayer(blueLayer)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
