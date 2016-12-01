//
//  FDCollectionSheetView.h
//  FDPhotosSheet
//
//  Created by QianTuFD on 2016/11/30.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import <UIKit/UIKit.h>


// 预留协议
@protocol FDCollectionSheetViewDelegate <UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@end

@interface FDCollectionSheetView : UIView


@property (nonatomic, weak) id<FDCollectionSheetViewDelegate> delegate;

+ (void)showSheetViewWithDelegate:(UIViewController<FDCollectionSheetViewDelegate> *)controller;


@end
