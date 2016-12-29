//
//  FDTableViewController1.m
//  FDTransitonAnimation
//
//  Created by QianTuFD on 2016/12/29.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDTableViewController1.h"
#import "FDDetailViewController.h"
#import "FDModalTransition.h"

@interface FDTableViewController1 ()

@property (nonatomic, strong) FDModalTransition *modalTransition;

@end

@implementation FDTableViewController1
static NSString *const reuseID = @"reuseID";

- (FDModalTransition *)modalTransition {
    if (_modalTransition == nil) {
        _modalTransition = [[FDModalTransition alloc] init];
    }
    return _modalTransition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.startRect = [tableView rectForRowAtIndexPath:indexPath];
    FDDetailViewController *detailVC = [[FDDetailViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVC];
    nav.transitioningDelegate = self.modalTransition;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    
//    self.tabBarController.tabBar.hidden = YES;
    [self presentViewController:nav animated:YES completion:nil];

}

@end
