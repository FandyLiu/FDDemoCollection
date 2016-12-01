//
//  FDPhotoCollectionViewCell.m
//  FDPhotosSheet
//
//  Created by QianTuFD on 2016/11/30.
//  Copyright © 2016年 fandy. All rights reserved.
//

#import "FDPhotoCollectionViewCell.h"

@interface FDPhotoCollectionViewCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation FDPhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.bounds = self.bounds;
        _imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}

@end
