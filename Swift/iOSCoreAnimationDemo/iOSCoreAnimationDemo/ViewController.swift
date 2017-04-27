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
        // 图层几何学
        /*
         
         “UIView有三个比较重要的布局属性：frame，bounds和center，CALayer对应地叫做frame，bounds和position。为了能清楚区分，图层用了“position”，视图用了“center”，但是他们都代表同样的值。”
         
         “frame代表了图层的外部坐标（也就是在父图层上占据的空间），bounds是内部坐标（{0, 0}通常是图层的左上角），center和position都代表了相对于父图层anchorPoint所在的位置。”
         
         “视图的frame，bounds和center属性仅仅是存取方法，当操纵视图的frame，实际上是在改变位于视图下方CALayer的frame，不能够独立于图层之外改变视图的frame。
         
             对于视图或者图层来说，frame并不是一个非常清晰的属性，它其实是一个虚拟属性，是根据bounds，position和transform计算而来，所以当其中任何一个值发生改变，frame都会变化。相反，改变frame的值同样会影响到他们当中的值”
         
         
         “  记住当对图层做变换的时候，比如旋转或者缩放，frame实际上代表了覆盖在图层旋转之后的整个轴对齐的矩形区域，也就是说frame的宽高可能和bounds的宽高不再一致了（图3.2）”
         
         */

        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - CALayerDelegate
extension ViewController: CALayerDelegate {
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.setLineWidth(10.0)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokeEllipse(in: layer.bounds)
    }
}






extension CALayer {
    func add(_ spriteImage: UIImage, with contentsRect: CGRect) {
        contents = spriteImage.cgImage
        contentsGravity = kCAGravityResizeAspect
        self.contentsRect = contentsRect
    }
}



// MARK: - layer
extension ViewController {
    func layer() {
        /*
         图层
         ```
         和UIView最大的不同是CALayer不处理用户的交互
         
         实际上，这里并不是两个层级关系，而是四个，每一个都扮演不同的角色，除了视图层级和图层树之外，还存在呈现树和渲染树，”
         ```
         “我们已经证实了图层不能像视图那样处理触摸事件，那么他能做哪些视图不能做的呢？这里有一些UIView没有暴露出来的CALayer的功能：
         
         阴影，圆角，带颜色的边框
         3D变换
         非矩形范围
         透明遮罩
         多级非线性动画
         
             我们将会在后续章节中探索这些功能，首先我们要关注一下在应用程序当中CALayer是怎样被利用起来的。”
         
         ```
         
         使用图层关联的视图而不是CALayer的好处在于，你能在使用所有CALayer底层特性的同时，也可以使用UIView的高级API（比如自动排版，布局和事件处理）。
         
             然而，当满足以下条件的时候，你可能更需要使用CALayer而不是UIView:
         
         开发同时可以在Mac OS上运行的跨平台应用
         使用多种CALayer的子类（见第六章，“特殊的图层“），并且不想创建额外的UIView去包封装它们所有
         做一些对性能特别挑剔的工作，比如对UIView一些可忽略不计的操作都会引起显著的不同（尽管如此，你可能会直接想使用OpenGL绘图）”
         */
        
        let rect = CGRect(x: 50, y: 50, width: 100, height: 100)
        let layerView = UIView(frame: rect)
        layerView.backgroundColor = UIColor.white
        view.addSubview(layerView)
        // 添加蓝色子图层
        //        let blueLayer = CALayer()
        //        blueLayer.frame = CGRect(x: 50, y: 50, width: 150, height: 150)
        //        blueLayer.backgroundColor = UIColor.blue.cgColor
        //        layerView.layer .addSublayer(blueLayer)
        
        /*
         “CALayer 有一个属性叫做contents，这个属性的类型被定义为id，意味着它可以是任何类型的对象。在这种情况下，你可以给contents属性赋任何值，你的app仍然能够编译通过。但是，在实践中，如果你给contents赋的不是CGImage，那么你得到的图层将是空白的。
         
         contents这个奇怪的表现是由Mac OS的历史原因造成的。它之所以被定义为id类型，是因为在Mac OS系统上，这个属性对CGImage和NSImage类型的值都起作用。如果你试图在iOS平台上将UIImage的值赋给它，只能得到一个空白的图层。一些初识Core Animation的iOS开发者可能会对这个感到困惑。”
         
         “头疼的不仅仅是我们刚才提到的这个问题。事实上，你真正要赋值的类型应该是CGImageRef，它是一个指向CGImage结构的指针。UIImage有一个CGImage属性，它返回一个"CGImageRef",如果你 想把这个值直接赋值给CALayer的contents，那你将会得到一个编译错误。因为CGImageRef并不是一个真正的Cocoa对象，而是一个Core Foundation类型。”
         
         “尽管Core Foundation类型跟Cocoa对象在运行时貌似很像（被称作toll-free bridging），他们并不是类型兼容的，不过你可以通过bridged关键字转换。如果要给图层的寄宿图赋值，你可以按照以下这个方法：”
         
         layer.contents = (__bridge id)image.CGImage;”
         */
        let image = UIImage(named: "avatar")
        layerView.layer.contents = image?.cgImage
        
        // layerView.contentMode 对应
        //        layerView.layer.contentsGravity = kCAGravityBottomRight
        
        
        // “因为contents由于设置了contentsGravity属性，所以它已经被拉伸以适应图层的边界” // 默认是1  "resize" 会影响他
        /*
         contentsScale属性其实属于支持高分辨率（又称Hi-DPI或Retina）屏幕机制的一部分。它用来判断在绘制图层的时候应该为寄宿图创建的空间大小，和需要显示的图片的拉伸度（假设并没有设置contentsGravity属性）。UIView有一个类似功能但是非常少用到的contentScaleFactor属性。”
         “如果contentsScale设置为1.0，将会以每个点1个像素绘制图片，如果设置为2.0，则会以每个点2个像素绘制图片，这就是我们熟知的Retina屏幕。（如果你对像素和点的概念不是很清楚的话，这个章节的后面部分将会对此做出解释）。”
         
         “当用代码的方式来处理寄宿图的时候，一定要记住要手动的设置图层的contentsScale属性，否则，你的图片在Retina设备上就显示得不正确啦。”
         layer.contentsScale = [UIScreen mainScreen].scale;
         */
        //        layerView.layer.contentsScale = image!.scale
        
        
        
        /*
         “UIView有一个叫做clipsToBounds的属性可以用来决定是否显示超出边界的内容，CALayer对应的属性叫做masksToBounds，”
         */
        //        layerView.clipsToBounds = true
        //        layerView.layer.masksToBounds = true
        
        /*
         “CALayer的contentsRect属性允许我们在图层边框里显示寄宿图的一个子域。这涉及到图片是如何显示和拉伸的，所以要比contentsGravity灵活多了”
         
         “contentsRect不是按点来计算的，它使用了单位坐标，单位坐标指定在0到1之间，是一个相对值（像素和点就是绝对值）。所以他们是相对与寄宿图的尺寸的。iOS使用了以下的坐标系统：”
         */
        
        /*
         “它使用了单位坐标，单位坐标指定在0到1之间，是一个相对值（像素和点就是绝对值）。所以他们是相对与寄宿图的尺寸的。iOS使用了以下的坐标系统：
         
         点 —— 在iOS和Mac OS中最常见的坐标体系。点就像是虚拟的像素，也被称作逻辑像素。在标准设备上，一个点就是一个像素，但是在Retina设备上，一个点等于2*2个像素。iOS用点作为屏幕的坐标测算体系就是为了在Retina设备和普通设备上能有一致的视觉效果。
         像素 —— 物理像素坐标并不会用来屏幕布局，但是仍然与图片有相对关系。UIImage是”
         
         “一个屏幕分辨率解决方案，所以指定点来度量大小。但是一些底层的图片表示如CGImage就会使用像素，所以你要清楚在Retina设备和普通设备上，他们表现出来了不同的大小。
         单位 —— 对于与图片大小或是图层边界相关的显示，单位坐标是一个方便的度量方式， 当大小改变的时候，也不需要再次调整。单位坐标在OpenGL这种纹理坐标系统中用得很多，Core Animation中也用到了单位坐标。”
         
         */
        
        /*
         
         “事实上给contentsRect设置一个负数的原点或是大于{1, 1}的尺寸也是可以的。这种情况下，最外面的像素会被拉伸以填充剩下的区域。”
         “contentsRect在app中最有趣的地方在于一个叫做image sprites（图片拼合）的用法。如果你有游戏编程的经验，那么你一定对图片拼合的概念很熟”
         
         典型地，图片拼合后可以打包整合到一张大图上一次性载入。相比多次载入不同的图片，这样做能够带来很多方面的好处：内存使用，载入时间，渲染性能等等”
         
         “2D游戏引擎入Cocos2D使用了拼合技术，它使用OpenGL来显示图片。不过我们可以使用拼合在一个普通的UIKit应用中，对！就是使用contentsRect”
         
         摘录来自: 钟声. “ios核心动画高级技巧”。 iBooks.
         “拼合不仅给app提供了一个整洁的载入方式，还有效地提高了载入性能（单张大图比多张小图载入地更快），但是如果有手动安排的话，他们还是有一些不方便的，如果你需要在一个已经创建好的品和图上做一些尺寸上的修改或者其他变动，无疑是比较麻烦的。”
         */
        
        //        layerView.layer.contentsRect = CGRect(x: 0, y: 0, width: 1.2, height: 1.2)
        layerView.layer.add(image!, with: CGRect(x: 0.2, y: 0.2, width: 0.5, height: 0.5))
        
        /*
         
         “本章我们介绍的最后一个和内容有关的属性是contentsCenter，看名字你可能会以为它可能跟图片的位置有关，不过这名字着实误导了你。contentsCenter其实是一个CGRect，它定义了一个固定的边框和一个在图层上可拉伸的区域。 改变contentsCenter的值并不会影响到寄宿图的显示，除非这个图层的大小改变了，你才看得到效果。
         
         默认情况下，contentsCenter是{0, 0, 1, 1}，这意味着如果大小（由conttensGravity决定）改变了,那么寄宿图将会均匀地拉伸开。但是如果我们增加原点的值并减小尺寸。我们会在图片的周围创造一个边框。”
         
         “这意味着我们可以随意重设尺寸，边框仍然会是连续的。他工作起来的效果和UIImage里的-resizableImageWithCapInsets: 方法效果非常类似，只是它可以运用到任何寄宿图，甚至包括在Core Graphics运行时绘制的图形（本章稍后会讲到）。”
         
         
         下面就可以讲CALayer的contentsCenter属性了，因为contentsCenter属性只有在图片被拉伸后才会起作用，contentsCenter可以用来定义全面拉伸的范围。什么是“全面拉伸”？
         
         */
        
        //        layerView.layer.contentsCenter = CGRect(x: 0.25, y: 0.25, width: 0.8, height: 0.8)
        
        
        
        
        
        /*
         “给contents赋CGImage的值不是唯一的设置寄宿图的方法。我们也可以直接用Core Graphics直接绘制寄宿图。能够通过继承UIView并实现-drawRect:方法来自定义绘制。”
         “它不在意那到底是单调的颜色还是有一个图片的实例。如果UIView检测到-drawRect: 方法被调用了，它就会为视图分配一个寄宿图，这个寄宿图的像素尺寸等于视图大小乘以 contentsScale的值。”
         
         如果你不需要寄宿图，那就不要创建这个方法了，这会造成CPU资源和内存的浪费，这也是为什么苹果建议：如果没有自定义绘制的任务就不要在子类中写一个空的-drawRect:方法。”
         
         “当视图在屏幕上出现的时候 -drawRect:方法就会被自动调用。-drawRect:方法里面的代码利用Core Graphics去绘制一个寄宿图，然后内容就会被缓存起来直到它需要被更新（通常是因为开发者调用了-setNeedsDisplay方法，尽管影响到表现效果的属性值被更改时，一些视图类型会被自动重绘，如bounds属性）。虽然-drawRect:方法是一个UIView方法，事实上都是底层的CALayer安排了重绘工作和保存了因此产生的图片。”
         
         “CALayer有一个可选的delegate属性，实现了CALayerDelegate协议，当CALayer需要一个内容特定的信息时，就会从协议中请求。CALayerDelegate是一个非正式协议，其实就是说没有CALayerDelegate @protocol可以让你在类里面引用啦。你只需要调用你想调用的方法，CALayer会帮你做剩下的。（delegate属性被声明为id类型，所有的代理方法都是可选的）。”
         
         
         “当需要被重绘时，CALayer会请求它的代理给他一个寄宿图来显示。它通过调用下面这个方法做到的:
         
         (void)displayLayer:(CALayerCALayer *)layer;
             趁着这个机会，如果代理想直接设置contents属性的话，它就可以这么做，不然没有别的方法可以调用了。如果代理不实现-displayLayer:方法，CALayer就会转而尝试调用下面这个方法：
         
         - (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;
             在调用这个方法之前，CALayer创建了一个合适尺寸的空寄宿图（尺寸由bounds和contentsScale决定）和一个Core Graphics的绘制上下文环境，为绘制寄宿图做准备，他作为ctx参数传入。”
         
         摘录来自: 钟声. “ios核心动画高级技巧”。 iBooks.
         
         
         */
//        let rect = CGRect(x: 50, y: 50, width: 100, height: 100)
//        let layerView = UIView(frame: rect)
//        layerView.backgroundColor = UIColor.white
//        view.addSubview(layerView)
        // 添加蓝色子图层
        let blueLayer = CALayer()
        blueLayer.frame = CGRect(x: 50, y: 50, width: 150, height: 150)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        layerView.layer.addSublayer(blueLayer)
        
        blueLayer.delegate = self
        blueLayer.contentsScale = UIScreen.main.scale
        
        /*
         “我们在blueLayer上显式地调用了-display。不同于UIView，当图层显示在屏幕上时，CALayer不会自动重绘它的内容。它把重绘的决定权交给了开发者。
         尽管我们没有用masksToBounds属性，绘制的那个圆仍然沿边界被裁剪了。这是因为当你使用CALayerDelegate绘制寄宿图的时候，并没有对超出边界外的内容提供绘制支持。”
         
         
         “ 现在你理解了CALayerDelegate，并知道怎么使用它。但是除非你创建了一个单独的图层，你几乎没有机会用到CALayerDelegate协议。因为当UIView创建了它的宿主图层时，它就会自动地把图层的delegate设置为它自己，并提供了一个-displayLayer:的实现，那所有的问题就都没了。
         
             当使用寄宿了视图的图层的时候，你也不必实现-displayLayer:和-drawLayer:inContext:方法来绘制你的寄宿图。通常做法是实现UIView的-drawRect:方法，UIView就会帮你做完剩下的工作，包括在需要重绘的时候调用-display方法。”
         
         摘录来自: 钟声. “ios核心动画高级技巧”。 iBooks.
         */
        
        //        blueLayer.display()

    }
}
