//
//  FDMainTabBarController.m
//  FDTransitonAnimation
//
//  Created by QianTuFD on 2016/12/29.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDMainTabBarController.h"
#import "FDTableViewController.h"
#import "FDTableViewController1.h"

@interface FDMainTabBarController ()

@end

@implementation FDMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildVC];
}


- (void)setupAllChildVC {
    FDTableViewController *vc0 = [[FDTableViewController alloc] init];
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:vc0];
    vc0.title = @"push";
    nav0.tabBarItem.title = @"push";
    [self addChildViewController:nav0];
    
    FDTableViewController1 *vc1 = [[FDTableViewController1 alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    vc1.title = @"modal";
    nav1.tabBarItem.title = @"modal";
    [self addChildViewController:nav1];
}



@end
