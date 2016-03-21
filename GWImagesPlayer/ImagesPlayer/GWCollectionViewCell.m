//
//  GWCollectionViewCell.m
//  GWImagesPlayer
//
//  Created by GW on 16/3/1.
//  Copyright © 2016年 wgworkspace. All rights reserved.
//

#import "GWCollectionViewCell.h"

@interface GWCollectionViewCell ()
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation GWCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        

        [self updateUI];
    }
    return self;
}

#pragma mark - 更新UI
- (void)updateUI {
    UIImageView *imageView = [[UIImageView alloc]init];
    self.imageView = imageView;
    imageView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:imageView];
    
}

#pragma mark-  加载图片
- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end
