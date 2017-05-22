//
//  main.swift
//  iOSCoreAnimationDemo
//
//  Created by QianTuFD on 2017/5/15.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

class MyApplication: UIApplication {
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
//        print("Entry Point")
    }
    
}

// http://stackoverflow.com/questions/24020000/subclass-uiapplication-with-swift
// /Users/liuhuan/Documents/github/FDDemoCollection/Swift/iOSCoreAnimationDemo/iOSCoreAnimationDemo/main.swift:17:33: Use of unresolved identifier 'Process'

// swift 3.0
UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(MyApplication.self),
    NSStringFromClass(AppDelegate.self)
)
