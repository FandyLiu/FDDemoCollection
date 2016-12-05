//
//  FDPushTransition.m
//  FDTransitonAnimation
//
//  Created by QianTuFD on 2016/12/5.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDPushTransition.h"
#import "FDTableViewController.h"

@implementation FDPushTransition


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *contentView = [transitionContext containerView];
    FDTableViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *tempView = [[UIView alloc] init];
    tempView.frame = [contentView convertRect:fromVC.startRect fromView:fromVC.view];
    tempView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView  *snapShotView = [fromVC.navigationController.view snapshotViewAfterScreenUpdates:NO];
    snapShotView.frame = [contentView convertRect:fromVC.navigationController.view.frame fromView:fromVC.navigationController.view];
    
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
