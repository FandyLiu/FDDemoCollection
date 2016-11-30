//
//  MainViewController.m
//  FDPhotoDemo
//
//  Created by QianTuFD on 2016/11/29.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "MainViewController.h"
#import "UIButton+FDAdd.h"
#import "SelectViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    UIButton *pushButton = [UIButton createButtonWithFrame:CGRectMake(100, 100, 90, 30)
                                                buttonType:FDButtonTypeNormal
                                                     title:@"Push"
                                                       tag:0
                                                    target:self
                                                    action:@selector(buttonsEvent:)];
    [self.view addSubview:pushButton];
}

- (void)buttonsEvent:(UIButton *)button {
    [self.navigationController pushViewController:[[SelectViewController alloc] init] animated:YES];     
}

@end
