//
//  FDAlertViewTool.m
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/20.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDAlertViewTool.h"

@interface FDAlertViewTool ()<FDAlertNoteViewDelegate>

//@property (nonatomic, strong) UIView *showView;

@end

@implementation FDAlertViewTool

+ (FDAlertViewTool *)shareInstance {
    static FDAlertViewTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[FDAlertViewTool alloc] init];
    });
    return tool;
}
static UIView *showView;
+ (FDAlertNoteView *)showAlertBottomViewWithTitle:(NSString *)title content:(NSString *)content {
    [showView removeFromSuperview];
    FDAlertNoteView *view = [FDAlertNoteView alertBottomViewWithTitle:title content:content];
    view.delegate = [FDAlertViewTool shareInstance];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    showView = view;
    return view;
}

+ (FDAlertNoteView *)showAlertCenterViewWithTitle:(NSString *)title content:(NSString *)content {
    [showView removeFromSuperview];
    FDAlertNoteView *view = [FDAlertNoteView alertCenterViewWithTitle:title content:content];
    view.delegate = [FDAlertViewTool shareInstance];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    showView = view;
    return view;
}

+ (void)dismiss {
    [showView removeFromSuperview];
}

#pragma mark FDAlertNoteViewDelegate

- (void)alertNoteViewConfirmButtonClick:(FDAlertNoteView *)view {
    [showView removeFromSuperview];
}



@end
