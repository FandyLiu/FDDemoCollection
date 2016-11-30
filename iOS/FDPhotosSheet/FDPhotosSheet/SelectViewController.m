//
//  SelectViewController.m
//  FDPhotoDemo
//
//  Created by QianTuFD on 2016/11/29.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "SelectViewController.h"
#import "FDPhotoSheetView.h"
#import "FDImageArchiver.h"
#import "UIButton+FDAdd.h"



@interface SelectViewController ()<FDPhotoSheetViewDelegate>

@property (nonatomic, weak) UIImageView *selectImageView;

@property (nonatomic, strong) FDImageArchiver  *imageArchiver;

@end

@implementation SelectViewController


- (FDImageArchiver *)imageArchiver {
    if (_imageArchiver == nil) {
        _imageArchiver = [[FDImageArchiver alloc] init];
    }
    return _imageArchiver;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // 读取归档数据
    [self initData];
}

- (void)setupView {
    for (int i = 0; i < 4; i++) {
        int col = i / 2;
        int row = i % 2;
        int gap = 10;
        int width = 100;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + row * (width + gap), 64 + col * (width + gap), width, width)];
        imageView.tag = i;
        imageView.backgroundColor = [UIColor blueColor];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [imageView addGestureRecognizer:ges];
        [self.view addSubview:imageView];
    }
    
    UIButton *pushButton = [UIButton createButtonWithFrame:CGRectMake(220, 200, 90, 30)
                                                buttonType:FDButtonTypeNormal
                                                     title:@"Save"
                                                       tag:0
                                                    target:self
                                                    action:@selector(save:)];
    [self.view addSubview:pushButton];
}

- (void)initData {
    FDImageArchiver *imageArchiver = [FDImageArchiver unarchiver];
    self.imageArchiver = imageArchiver;
    if (imageArchiver) {
        for (UIImageView *imageView in self.view.subviews) {
            if ([imageView isKindOfClass:[UIImageView class]]) {
                [self readImageView:imageView];
            }
        }
    }
}

// 点击保存按钮 (如果想点击导航条返回也调用这个方法的话,也调用这个方法)
- (void)save:(UIButton *)button {
    [self.imageArchiver archiver];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


// 点击图片选择图片
- (void)imageTap:(UITapGestureRecognizer *)ges {
    self.selectImageView = (UIImageView *)ges.view;
    [FDPhotoSheetView showSheetViewWithDelegate:self];
}

#pragma mark 归档工具

// 保存到模型
- (void)saveImage:(UIImage *)image {
    switch (self.selectImageView.tag) {
        case 0:
            self.imageArchiver.image1 = image;
            break;
        case 1:
            self.imageArchiver.image2 = image;
            break;
        case 2:
            self.imageArchiver.image3 = image;
            break;
        case 3:
            self.imageArchiver.image4 = image;
            break;
        default:
            break;
    }
}

// 读取数据
- (void)readImageView:(UIImageView *)imageView {
    switch (imageView.tag) {
        case 0:
            imageView.image = self.imageArchiver.image1;
            break;
        case 1:
            imageView.image = self.imageArchiver.image2;
            break;
        case 2:
            imageView.image = self.imageArchiver.image3;
            break;
        case 3:
            imageView.image = self.imageArchiver.image4;
            break;
        default:
            break;
    }
}


#pragma mark delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.selectImageView.image = image;
    [self saveImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
