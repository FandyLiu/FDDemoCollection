//
//  FDUserModelTool.m
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/14.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDUserModelTool.h"

#define kUserModelPath [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userModel.data"]

@implementation FDUserModelTool

+ (void)saveUserModel:(FDUserModel *)userModel {
    
    
    BOOL result = [NSKeyedArchiver archiveRootObject:userModel toFile:kUserModelPath];
    
    if (result) {
        NSLog(@"归档成功:%@",kUserModelPath);
    }else
    {
        NSLog(@"归档失败");
    }
    
}

+ (FDUserModel *)userModel {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kUserModelPath];
    
}

@end
