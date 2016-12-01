//
//  FDPhotoSheetView.h
//  FDPhotoDemo
//
//  Created by QianTuFD on 2016/11/29.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDCollectionSheetView.h"

@class FDPhotoSheetView;

// 预留协议
@protocol FDPhotoSheetViewDelegate <FDCollectionSheetViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@end

@interface FDPhotoSheetView : UIView


@property (nonatomic, weak) UIViewController<FDPhotoSheetViewDelegate>* delegate;

+ (void)showSheetViewWithDelegate:(UIViewController<FDPhotoSheetViewDelegate> *)controller;


@end
