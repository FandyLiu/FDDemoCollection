//
//  FDAlertNoteView.m
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/20.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDAlertNoteView.h"
#import "NSString+FDTextSize.h"

@interface FDAlertNoteView ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewH;


@end

@implementation FDAlertNoteView


+ (FDAlertNoteView *)alertCenterViewWithTitle:(NSString *)title content:(NSString *)content {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    FDAlertNoteView *view = [nibContents firstObject];
    view.title.text = title;
    view.content.text = content;
    // frame
    
    CGFloat besideMargin = CGRectGetMinX(view.content.frame);
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.8;
    CGFloat contentH = [content fd_textHeightWithContentWidth:width - besideMargin * 2 font:[UIFont systemFontOfSize:18]];
    // 字体18 3行高度大概是64.44
    if (contentH < 65) {
        contentH = 65;
    }
    view.scrollViewH.constant = contentH;
    CGFloat bottomMargin = 15;
    CGFloat height = contentH + CGRectGetMinY(view.content.frame) + (CGRectGetMaxY(view.confirmButton.frame) - CGRectGetMaxY(view.content.frame)) + bottomMargin;
    view.bounds = CGRectMake(0, 0, width, height);
    view.center = [UIApplication sharedApplication].keyWindow.center;
    return view;
}

+ (FDAlertNoteView *)alertBottomViewWithTitle:(NSString *)title content:(NSString *)content {
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    FDAlertNoteView *view = [nibContents lastObject];
    view.title.text = title;
    view.content.text = content;
    // frame
    CGRect labelConvertFrame = [view.content convertRect:view.content.frame toView:view];
    
    CGFloat besideMargin = CGRectGetMinX(labelConvertFrame);
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.8;
    CGFloat contentH = [content fd_textHeightWithContentWidth:width - besideMargin * 2 font:[UIFont systemFontOfSize:18]];
    CGFloat maxContentH = 200;
    if (contentH > maxContentH) {
        contentH = maxContentH ;
    }
    CGFloat bottomMargin = 15;
    CGFloat height = contentH + CGRectGetMinY(labelConvertFrame) + bottomMargin;
    view.scrollViewH.constant = contentH;

    CGFloat x = [UIScreen mainScreen].bounds.size.width * 0.1;
    CGFloat y = [UIScreen mainScreen].bounds.size.height - height - bottomMargin;
    view.frame = CGRectMake(x, y, width, height);
    return view;
}

- (IBAction)confirmBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(alertNoteViewConfirmButtonClick:)]) {
        [self.delegate alertNoteViewConfirmButtonClick:self];
    }
}






@end
