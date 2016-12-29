//
//  FDModalTransition.m
//  FDTransitonAnimation
//
//  Created by QianTuFD on 2016/12/29.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDModalTransition.h"
#import "FDTableViewController1.h"

@interface FDModalTransition ()<UIViewControllerAnimatedTransitioning>


@end

@implementation FDModalTransition


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}
#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = [transitionContext containerView];
    UITabBarController *fromRootVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 第1个是modal
    FDTableViewController1 *fromVC = fromRootVC.childViewControllers[1];
    for (FDTableViewController1 *vc in fromVC.childViewControllers) {
        if ([vc isKindOfClass:[FDTableViewController1 class]]) {
            fromVC = vc;
        }
    }
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //目的遮住tabBar
    UIView *coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor yellowColor];
    [contentView addSubview:coverView];
    
    
    UIView *tempView = [[UIView alloc] init];
    tempView.frame = [contentView convertRect:fromVC.startRect fromView:fromVC.tableView];
    tempView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView  *snapShotView = [fromVC.tabBarController.view snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [contentView convertRect:fromVC.tabBarController.view.frame fromView:fromVC.tabBarController.view];
    
    fromVC.view.alpha = 0;
    toVC.view.alpha = 0;
    
    
    [contentView addSubview:snapShotView];
    [contentView addSubview:tempView];
    [contentView addSubview:toVC.view];
    
    [UIView animateWithDuration:0.2 animations:^{
        snapShotView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] - 0.2 animations:^{
            tempView.frame = contentView.bounds;
        } completion:^(BOOL finished) {
            [coverView removeFromSuperview];
            [tempView removeFromSuperview];
            [snapShotView removeFromSuperview];
            toVC.view.alpha = 1.0;
            fromVC.view.alpha = 1.0;
            //告诉系统动画结束
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }];
}


@end
