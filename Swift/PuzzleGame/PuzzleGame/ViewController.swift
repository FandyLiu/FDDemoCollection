//
//  ViewController.swift
//  PuzzleGame
//
//  Created by QianTuFD on 2017/5/2.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "test.jpg")
        self.imageView.image = image
//        self.imageView.layer.contentsGravity = kCAGravityResizeAspect;
//        self.imageView.layer.contentsRect = CGRect(x: 0, y: 0, width: 0.5, height: 0.5)
//        let image = UIImage(named: "test.jpg")?.cgImage
//        let width = image?.width
//        let height = image?.height
//        let rect = CGRect(x: 0, y: 0, width: width! / 2, height: height! / 2)
//        let ai = image!.cropping(to: rect)
//        self.imageView.image = UIImage(cgImage: ai!)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

