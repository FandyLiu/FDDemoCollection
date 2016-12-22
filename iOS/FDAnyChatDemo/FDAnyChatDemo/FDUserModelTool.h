//
//  FDUserModelTool.h
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/14.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDUserModel.h"

@interface FDUserModelTool : NSObject

+ (void)saveUserModel:(FDUserModel *)userModel;
+ (FDUserModel *)userModel;


@end
