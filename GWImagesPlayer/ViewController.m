//
//  ViewController.m
//  GWImagesPlayer
//
//  Created by GW on 16/3/1.
//  Copyright © 2016年 wgworkspace. All rights reserved.
//

#import "ViewController.h"
#import "GWImagesPlayer.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray * images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GWImagesPlayer *collectionView = [[GWImagesPlayer alloc]init];
    collectionView.frame = CGRectMake(100, 100, 200 , 200);
    collectionView.images = self.images;
    
    collectionView.framInterval = 60;

    [self.view addSubview:collectionView];
    
}


#pragma mark - 懒加载
- (NSArray *)images {
    if (_images == nil) {
        _images = [NSArray array];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i< 7; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%d",i];
            UIImage *image = [UIImage imageNamed:[imageName stringByAppendingString:@".jpg"]];
            [tempArray addObject:image];
        }
        _images = tempArray.copy;
    }
    return _images;
}

@end
