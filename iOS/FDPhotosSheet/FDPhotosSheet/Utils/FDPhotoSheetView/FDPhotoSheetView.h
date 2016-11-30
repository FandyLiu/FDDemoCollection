//
//  FDPhotoSheetView.h
//  FDPhotoDemo
//
//  Created by QianTuFD on 2016/11/29.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDPhotoSheetView;

// 预留协议
@protocol FDPhotoSheetViewDelegate <UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@end

@interface FDPhotoSheetView : UIView


@property (nonatomic, weak) id<FDPhotoSheetViewDelegate> delegate;

+ (void)showSheetViewWithDelegate:(UIViewController<FDPhotoSheetViewDelegate> *)controller;

@end
