//
//  GWCollecionView.h
//  GWImagesPlayer
//
//  Created by GW on 16/3/1.
//  Copyright © 2016年 wgworkspace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWImagesPlayer : UICollectionView
///  图片数据
@property (nonatomic, strong) NSArray<UIImage *> *images;
///  帧间隔
@property (nonatomic, assign) NSInteger   framInterval;

@end
