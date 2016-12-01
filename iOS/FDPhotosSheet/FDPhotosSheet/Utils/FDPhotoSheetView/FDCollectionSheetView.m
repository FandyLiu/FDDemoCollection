//
//  FDCollectionSheetView.m
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


#define SheetViewH 200
#define CellID @"PhotoCollectionViewCell"
#define SupplementaryView @"SupplementaryView"

#import "FDCollectionSheetView.h"
#import "FDPhotoFlowLayout.h"
#import "FDPhotoCollectionViewCell.h"
#import "FDCollectionFooterView.h"

@interface FDCollectionSheetView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIView *maskView;

@end

@implementation FDCollectionSheetView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = [UIColor blueColor];
    
    UICollectionView *collectionView =  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[FDPhotoFlowLayout new]];
    collectionView.frame = CGRectMake(0, 0, FDScreenWidth, 210);
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    [self addSubview:collectionView];

    // 注册cell
    [collectionView registerClass:[FDPhotoCollectionViewCell class] forCellWithReuseIdentifier:CellID];
    [collectionView registerClass:[FDCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SupplementaryView];

}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FDPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    cell.image = nil;
    
    
 
     cell.backgroundColor = (indexPath.item % 2)?[UIColor redColor]:[UIColor greenColor];
//    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        FDCollectionFooterView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SupplementaryView forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor blackColor];
        return reusableView;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FDPhotoCollectionViewCell *cell = (FDPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    if ([self.delegate respondsToSelector:@selector(selectDefalutImage:view:)]) {
//        [self.delegate selectDefalutImage:cell.button.imageView.image view:self];
//    }
//    [self hideSelf];
}



- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, FDScreenHeight, FDScreenWidth, self.frame.size.height);
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.maskView setHidden:YES];
        [self setHidden:YES];
        [self.maskView removeFromSuperview];
        [self removeFromSuperview];
    }];
}




+ (void)showSheetViewWithDelegate:(UIViewController<FDCollectionSheetViewDelegate> *)controller {
    
    FDCollectionSheetView *sheetView = [[self alloc] initWithFrame:CGRectMake(0, FDScreenHeight, FDScreenWidth,SheetViewH)];
    sheetView.delegate = controller;
    
    UIView *maskView = [[UIView alloc] initWithFrame:FDScreenBounds];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0;
    
    UITapGestureRecognizer *tapSheet = [[UITapGestureRecognizer alloc] initWithTarget:sheetView action:@selector(dismiss)];
    [maskView addGestureRecognizer:tapSheet];
    
    sheetView.maskView = maskView;
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:maskView];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:sheetView];
    
    [UIView animateWithDuration:0.2 animations:^{
        maskView.alpha = 0.4;
        sheetView.frame = CGRectMake(0, FDScreenHeight - SheetViewH, FDScreenWidth, FDScreenHeight);
    }];
}


@end
