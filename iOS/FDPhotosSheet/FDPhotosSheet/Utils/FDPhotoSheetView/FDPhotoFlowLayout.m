//
//  FDPhotoFlowLayout.m
//  FDPhotosSheet
//
//  Created by QianTuFD on 2016/11/30.
//  Copyright © 2016年 fandy. All rights reserved.
//
#define FDScreenBounds [UIScreen mainScreen].bounds
#define FDScreenSize FDScreenBounds.size
#define FDScreenHeight FDScreenSize.height
#define FDScreenWidth FDScreenSize.width
#define FDScreenScale [UIScreen mainScreen].scale

#import "FDPhotoFlowLayout.h"


@implementation FDPhotoFlowLayout

- (void)prepareLayout {
    NSInteger margin = 10;
    NSInteger colCount = 4;
    
    self.minimumInteritemSpacing = margin;
    self.minimumLineSpacing = margin;
    
    CGFloat itemW = (FDScreenWidth - (colCount + 1) * margin) / colCount;
    
    CGFloat itemH = itemW;
    self.itemSize = CGSizeMake(itemW, itemH);
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.footerReferenceSize = CGSizeMake(FDScreenWidth, 44);
    
    
}
















@end
