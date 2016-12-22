//
//  FDUserModel.m
//  FDAnyChatDemo
//
//  Created by QianTuFD on 2016/12/14.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDUserModel.h"

@implementation FDUserModel


NSString *const ChatIp = @"chatIp";
NSString *const ChatPort = @"chatPort";
NSString *const UserName = @"userName";


- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.chatIp = [decoder decodeObjectForKey:ChatIp];
        self.chatPort = [decoder decodeObjectForKey:ChatPort];
        self.userName = [decoder decodeObjectForKey:UserName];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.chatIp forKey:ChatIp];
    [encoder encodeObject:self.chatPort forKey:ChatPort];
    [encoder encodeObject:self.userName forKey:UserName];
}


@end
