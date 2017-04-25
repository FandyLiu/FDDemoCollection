//
//  ViewController.swift
//  iOSCoreAnimationDemo
//
//  Created by QianTuFD on 2017/4/24.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        let rect = CGRect(x: 50, y: 50, width: 100, height: 100)
        let layerView = UIView(frame: rect)
        layerView.backgroundColor = UIColor.white
        view.addSubview(layerView)
        // 添加蓝色子图层
//        let blueLayer = CALayer()
//        blueLayer.frame = CGRect(x: 50, y: 50, width: 150, height: 150)
//        blueLayer.backgroundColor = UIColor.blue.cgColor
//        layerView.layer .addSublayer(blueLayer)
        
        let image = UIImage(named: "ic_close_video")
        layerView.layer.contents = image?.cgImage
        // layerView.contentMode 对应
        layerView.layer.contentsGravity = "center"
        // “因为contents由于设置了contentsGravity属性，所以它已经被拉伸以适应图层的边界” // 默认是1  "resize" 会影响他
        /*
         contentsScale属性其实属于支持高分辨率（又称Hi-DPI或Retina）屏幕机制的一部分。它用来判断在绘制图层的时候应该为寄宿图创建的空间大小，和需要显示的图片的拉伸度（假设并没有设置contentsGravity属性）。UIView有一个类似功能但是非常少用到的contentScaleFactor属性。”
         “如果contentsScale设置为1.0，将会以每个点1个像素绘制图片，如果设置为2.0，则会以每个点2个像素绘制图片，这就是我们熟知的Retina屏幕。（如果你对像素和点的概念不是很清楚的话，这个章节的后面部分将会对此做出解释）。”
         
         “当用代码的方式来处理寄宿图的时候，一定要记住要手动的设置图层的contentsScale属性，否则，你的图片在Retina设备上就显示得不正确啦。”
         layer.contentsScale = [UIScreen mainScreen].scale;
         */
        layerView.layer.contentsScale = image!.scale
        dump(layerView)
        print(layerView)
        /*
         “UIView有一个叫做clipsToBounds的属性可以用来决定是否显示超出边界的内容，CALayer对应的属性叫做masksToBounds，”
 */
//        layerView.clipsToBounds = true
        layerView.layer.masksToBounds = true
        
        /*
         “CALayer的contentsRect属性允许我们在图层边框里显示寄宿图的一个子域。这涉及到图片是如何显示和拉伸的，所以要比contentsGravity灵活多了”
         
         “contentsRect不是按点来计算的，它使用了单位坐标，单位坐标指定在0到1之间，是一个相对值（像素和点就是绝对值）。所以他们是相对与寄宿图的尺寸的。iOS使用了以下的坐标系统：”
         */
        Dictionary
        let b = Acan()
        print(b)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension Dictionary {
    
}


class Acan {
    let a: String = "qqq"
    let b: String = "dddd"
}
