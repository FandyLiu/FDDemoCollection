//
//  ViewController.swift
//  PuzzleGame
//
//  Created by QianTuFD on 2017/5/2.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var sourceImageView: UIImageView = {
        let sourceImageView = UIImageView()
        sourceImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceImageView.backgroundColor = UIColor.gray
        return sourceImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sourceImageView)
        
        let topConstraint = NSLayoutConstraint(item: sourceImageView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .top,
                                               multiplier: 1.0,
                                               constant: 50.0)
        
        let leftConstraint = NSLayoutConstraint(item: sourceImageView,
                                                attribute: .left,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .left,
                                                multiplier: 1.0,
                                                constant: 80.0)
        
        let rightConstraint = NSLayoutConstraint(item: sourceImageView,
                                                 attribute: .right,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .right,
                                                 multiplier: 1.0,
                                                 constant: -80.0)
        
        let heightConstraint = NSLayoutConstraint(item: sourceImageView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: sourceImageView,
                                                  attribute: .width,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
        view.addConstraints([topConstraint, leftConstraint, rightConstraint])
        sourceImageView.addConstraint(heightConstraint)
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

