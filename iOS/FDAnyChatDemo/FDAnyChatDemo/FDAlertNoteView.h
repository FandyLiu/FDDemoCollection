//
//  FDAlertNoteView.h
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/20.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FDAlertNoteView;

@protocol FDAlertNoteViewDelegate <NSObject>

- (void)alertNoteViewConfirmButtonClick:(FDAlertNoteView *)view;

@end


@interface FDAlertNoteView : UIView


@property (nonatomic, weak) id<FDAlertNoteViewDelegate> delegate;


+ (FDAlertNoteView *)alertCenterViewWithTitle:(NSString *)title content:(NSString *)content;
+ (FDAlertNoteView *)alertBottomViewWithTitle:(NSString *)title content:(NSString *)content;

@end
