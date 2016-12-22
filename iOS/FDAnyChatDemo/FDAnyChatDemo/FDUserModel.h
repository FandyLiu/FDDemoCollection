//
//  FDUserModel.h
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/14.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDUserModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *roomId;

@property (nonatomic, assign) int localUserId;

@property (nonatomic, assign) int remoteUserId;

@property (nonatomic, strong) NSString *chatIp;

@property (nonatomic, strong) NSString *chatPort;

@property (nonatomic, strong) NSString *userName;

@end
