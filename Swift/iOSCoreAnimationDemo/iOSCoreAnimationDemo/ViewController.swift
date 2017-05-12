//
//  ViewController.swift
//  iOSCoreAnimationDemo
//
//  Created by QianTuFD on 2017/4/24.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    var blueLayer: CALayer?
    
    @IBAction func draw(_ sender: UIButton) {
        blueLayer?.display()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
       /*
         Z坐标轴
         
             和UIView严格的二维坐标系不同，CALayer存在于一个三维空间当中。除了我们已经讨论过的position和anchorPoint属性之外，CALayer还有另外两个属性，zPosition和anchorPointZ，二者都是在Z轴上描述图层位置的浮点类型。
         
             注意这里并没有更深的属性来描述由宽和高做成的bounds了，图层是一个完全扁平的对象，你可以把它们想象成类似于一页二维的坚硬的纸片，用胶水粘成一个空洞，就像三维结构的折纸一样。
         
             zPosition属性在大多数情况下其实并不常用。在第五章，我们将会涉及CATransform3D，你会知道如何在三维空间移动和旋转图层，除了做变换之外，zPosition最实用的功能就是改变图层的显示顺序了。
         
         “通常，图层是根据它们子图层的sublayers出现的顺序来类绘制的，这就是所谓的画家的算法--就像一个画家在墙上作画--后被绘制上的图层将会遮盖住之前的图层，但是通过增加图层的zPosition，就可以把图层向相机方向前置，于是它就在所有其他图层的前面了（或者至少是小于它的zPosition值的图层的前面）。
         
             这里所谓的“相机”实际上是相对于用户是视角，这里和iPhone背后的内置相机没任何关系。”
         
         “我们希望在真实的应用中也能显示出绘图的顺序，同样地，如果我们提高绿色视图的zPosition（清单3.3），我们会发现顺序就反了（图3.9）。其实并不需要增加太多，视图都非常地薄，所以给zPosition提高一个像素就可以让绿色视图前置，当然0.1或者0.0001也能够做到，但是最好不要这样，因为浮点类型四舍五入的计算可能会造成一些不便的麻烦。”
         */
        
        let greenView = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        greenView.backgroundColor = UIColor.green
        view.addSubview(greenView)
        let redView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        greenView.layer.zPosition = 1.0
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}






