//
//  FDAlertViewTool.h
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/20.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDAlertNoteView.h"

@interface FDAlertViewTool : NSObject

+ (FDAlertNoteView *)showAlertCenterViewWithTitle:(NSString *)title content:(NSString *)content;

+ (FDAlertNoteView *)showAlertBottomViewWithTitle:(NSString *)title content:(NSString *)content;

+ (void)dismiss;

@end
