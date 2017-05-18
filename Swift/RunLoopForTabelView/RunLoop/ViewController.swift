//
//  ViewController.swift
//  RunLoop
//
//  Created by QianTuFD on 2017/3/22.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var tasks: [() -> Bool] = [() -> Bool]()
    
        
    var openTask: Bool = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100.0
        if openTask {
            addRunloopObserver()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                
            })
        }
        
        
    }
    
    // 添加监听在线程休眠前执行任务
    func addRunloopObserver() {
        
        let pSelf = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        
//        withUnsafeMutablePointer(to: &_self) { (pSelf) -> Void in
            var observerContext = CFRunLoopObserverContext(version: 0,
                                                           info: pSelf,
                                                           retain: nil,
                                                           release: nil,
                                                           copyDescription: nil)
            
            withUnsafeMutablePointer(to: &observerContext, { (pObserverContext) -> Void in
                let observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                                       CFRunLoopActivity.beforeWaiting.rawValue,
                                                       true,
                                                       0,
                                                       { (observer, activity, context) in
                                                        guard let context = context else {
                                                            return
                                                        }
                                                        
                                                        let myself = unsafeBitCast(context, to: ViewController.self)

//                                                        let myself = Unmanaged<ViewController>.fromOpaque(context).takeRetainedValue()

                                                        if myself.tasks.count == 0 {
                                                            return
                                                        }
                                                        
                                                        // 有可能cell循环运用循环到 cell 用上后才执行这个任务，导致先出现下面现出来
                                                        var result = false
                                                        
                                                        while !result && myself.tasks.count > 0 {
                                                            result = myself.tasks.removeFirst()()
                                                        }
                                                        

                                                    
                                                        
                },pObserverContext)
                
                CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, CFRunLoopMode.defaultMode)
            })
//        }
    }
    
    func addTask(task: @escaping () -> Bool) -> Void {
        // 限定最大任务为 40
        if tasks.count > 40 {
            let _ = tasks.removeFirst()
        }
        tasks.append(task)
    }
}


extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
        cell.imageView1.image = UIImage(named: "placeholder.png")
        cell.imageView2.image = UIImage(named: "placeholder.png")
        cell.imageView3.image = UIImage(named: "placeholder.png")
        cell.imageView4.image = UIImage(named: "placeholder.png")
        let aPath = Bundle.main.path(forResource: "taylor.jpeg", ofType: nil)
        guard let path = aPath else {
            return cell
        }
        
        cell.currentIndexPath = indexPath
        
        if openTask {
            self.addTask(task: { () -> Bool in
                if cell.currentIndexPath == indexPath {
                    cell.imageView1.image = UIImage(contentsOfFile: path)
                    return true
                }else {
                    return false
                }
            })
            self.addTask(task: { () -> Bool in
                if cell.currentIndexPath == indexPath {
                    cell.imageView2.image = UIImage(contentsOfFile: path)
                    return true
                }else {
                    return false
                }
            })
            self.addTask(task: { () -> Bool in
                if cell.currentIndexPath == indexPath {
                    cell.imageView3.image = UIImage(contentsOfFile: path)
                    return true
                }else {
                    return false
                }
            })
            self.addTask(task: { () -> Bool in
                if cell.currentIndexPath == indexPath {
                    cell.imageView4.image = UIImage(contentsOfFile: path)
                    return true
                }else {
                    return false
                }
            })
            

        }else {
            cell.imageView1.image = UIImage(contentsOfFile: path)
            cell.imageView2.image = UIImage(contentsOfFile: path)
            cell.imageView3.image = UIImage(contentsOfFile: path)
            cell.imageView4.image = UIImage(contentsOfFile: path)
        }
        return cell
    }
}








