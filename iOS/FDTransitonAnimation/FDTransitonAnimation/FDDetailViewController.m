//
//  FDDetailViewController.m
//  FDTransitonAnimation
//
//  Created by QianTuFD on 2016/12/5.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDDetailViewController.h"

@interface FDDetailViewController ()

@end

@implementation FDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    
    if(self.presentingViewController) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"dissmiss" forState:UIControlStateNormal];
        
        button.frame = CGRectMake(100, 100, 100, 100);
        [self.view addSubview:button];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


- (void)buttonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
