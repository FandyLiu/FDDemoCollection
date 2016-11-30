//
//  FDPhotoSheetView.m
//  FDPhotoDemo
//
//  Created by QianTuFD on 2016/11/29.
//  Copyright © 2016年 fandy. All rights reserved.
//

#define FDScreenBounds [UIScreen mainScreen].bounds
#define FDScreenSize FDScreenBounds.size
#define FDScreenHeight FDScreenSize.height
#define FDScreenWidth FDScreenSize.width
#define FDScreenScale [UIScreen mainScreen].scale


#define SheetViewH 200


#import "FDPhotoSheetView.h"

@interface FDPhotoSheetView()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSArray *btnTitleArray;

@end

@implementation FDPhotoSheetView

- (NSArray *)btnTitleArray {
    if (_btnTitleArray == nil) {
        _btnTitleArray = @[@"拍照", @"相册", @"其他"];
    }
    return _btnTitleArray;
}

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
    
    NSInteger buttonCount = 3;
    CGFloat gap = 20.f;
    CGFloat btnWidth = (FDScreenWidth - (buttonCount + 1) * gap) / buttonCount;
    
    
    for (int i = 0; i < buttonCount; i++) {
        CGFloat x = (i + 1) * gap + i * btnWidth;
        CGFloat y = gap;
        UIButton *btn = ({
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(x, y, btnWidth, btnWidth);
            btn.backgroundColor = [UIColor grayColor];
            [btn setTitle:self.btnTitleArray[i] forState:UIControlStateNormal];
            btn.tag = i;
            [btn addTarget:self action:@selector(sheetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
        [self addSubview:btn];
    }
    //创建取消的按钮
    UIButton *cancelBtn = ({
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat y =  btnWidth + 2 * gap;
        btn.frame = CGRectMake(0, y, FDScreenWidth, SheetViewH - y);
        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self addSubview:cancelBtn];
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

- (void)sheetBtnClick:(UIButton *)button {
    switch (button.tag) {
        case 0: {
            [self dismiss];
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self.delegate;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing = YES;
            imagePicker.modalTransitionStyle = UIModalPresentationPopover;
            UIViewController *vc = (UIViewController *)(self.delegate);
            [vc presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        case 1: {
            [self dismiss];
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self.delegate;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            imagePicker.modalTransitionStyle = UIModalPresentationPopover;
            UIViewController *vc = (UIViewController *)(self.delegate);
            [vc presentViewController:imagePicker animated:YES completion:nil];
        }
        case 2:
            
            break;
            
        default:
            break;
    }
}



+ (void)showSheetViewWithDelegate:(UIViewController<FDPhotoSheetViewDelegate> *)controller {
    
    FDPhotoSheetView *sheetView = [[self alloc] initWithFrame:CGRectMake(0, FDScreenHeight, FDScreenWidth,SheetViewH)];
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
