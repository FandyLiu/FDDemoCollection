//
//  FDImageArchiver.h
//  FDPhotosSheet
//
//  Created by QianTuFD on 2016/11/30.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDImageArchiver : NSObject

@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, strong) UIImage *image3;
@property (nonatomic, strong) UIImage *image4;


- (void)archiver;

+ (FDImageArchiver *)unarchiver;

@end
