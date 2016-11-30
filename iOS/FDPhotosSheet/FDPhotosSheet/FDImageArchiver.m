//
//  FDImageArchiver.m
//  FDPhotosSheet
//
//  Created by QianTuFD on 2016/11/30.
//  Copyright © 2016年 fandy. All rights reserved.
//

#define FilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ImageFile"]
#define CodingKey @"ImageArchiver"


#import "FDImageArchiver.h"

@implementation FDImageArchiver

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.image1 forKey:@"image1"];
    [aCoder encodeObject:self.image2 forKey:@"image2"];
    [aCoder encodeObject:self.image3 forKey:@"image3"];
    [aCoder encodeObject:self.image4 forKey:@"image4"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.image1 = [aDecoder decodeObjectForKey:@"image1"];
        self.image2 = [aDecoder decodeObjectForKey:@"image2"];
        self.image3 = [aDecoder decodeObjectForKey:@"image3"];
        self.image4 = [aDecoder decodeObjectForKey:@"image4"];
    }
    return self;
}

- (void)archiver {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self forKey:CodingKey];
    [archiver finishEncoding];
    
    BOOL result = [data writeToFile:FilePath atomically:YES];
    if (result) {
        NSLog(@"归档成功:%@",FilePath);
    }else
    {
        NSLog(@"归档失败");
    }
}

+ (FDImageArchiver *)unarchiver {
    NSData *myData = [NSData dataWithContentsOfFile:FilePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:myData];
    FDImageArchiver *imageCoding = [unarchiver decodeObjectForKey:CodingKey];
    [unarchiver finishDecoding];
    return imageCoding;
}

@end
