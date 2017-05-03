//
//  ImageExtension.swift
//  PuzzleGame
//
//  Created by QianTuFD on 2017/5/3.
//  Copyright © 2017年 fandy. All rights reserved.
//

import UIKit

extension Int {
    var f: CGFloat {
        return CGFloat(self)
    }
}

extension UInt {
    var f: CGFloat {
        return CGFloat(self)
    }
}

extension UIImage {
    
    /// 将图片进行切割并返回切割后的小图片有序集合
    ///
    /// - Parameters:
    ///   - rows: 要切割的行数
    ///   - cols: 要切割的列数
    /// - Returns: 切割完成的小图片集合
    func cropping(rows: UInt, cols: UInt) -> [UIImage] {
        var croppedImagesArray = [UIImage]()
        let width = self.size.width / rows.f
        let height = self.size.height / cols.f
        let count = rows * cols
        
        let scale = UIScreen.main.scale
        for i in 0..<count {
            let x = (i % cols).f * width
            let y = (i / cols).f * height
            let rect = CGRect(x: x, y: y, width: width, height: height)
            guard let croppingCGImage = self.cgImage?.cropping(to: rect) else {
                assertionFailure("转CGImage失败")
                return croppedImagesArray
            }
            
            let croppingImage = UIImage(cgImage: croppingCGImage, scale: scale, orientation: .up)
            croppedImagesArray.append(croppingImage)
        }
        return croppedImagesArray
    }
}


extension Array {
    
    /// 返回一个打乱了顺序的新数组原数组不变
    ///
    /// - Returns: 返回一个打乱了顺序的新数组
    func random() -> [Element] {
        let randomBase = 10 // 越大数组越乱
        var randomArray = self
        for _ in 0..<randomArray.count * randomBase {
            let indexA = Int(arc4random_uniform(UInt32(randomArray.count)))
            let indexB = Int(arc4random_uniform(UInt32(randomArray.count)))
            (randomArray[indexA], randomArray[indexB]) = (randomArray[indexB], randomArray[indexA])
        }
        return randomArray
    }
}
