//
//  GWCollecionView.m
//  GWImagesPlayer
//
//  Created by GW on 16/3/1.
//  Copyright © 2016年 wgworkspace. All rights reserved.
//

#define GWIMAGESPLAYER_CELL @"GWImagesPalyerCell"

#import "GWImagesPlayer.h"
#import "GWCollectionViewCell.h"

@interface GWImagesPlayer () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray<UIImage *> * imageArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation GWImagesPlayer

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:[self getFlowLayout]]) {
        [self updateParameters];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:[self getFlowLayout]]) {
        // 配置参数
        [self updateParameters];
    }
    return self;
}

///   配置参数
- (void) updateParameters {
    // 设置代理
    self.delegate = self;
    self.dataSource = self;
    // 分页
    self.pagingEnabled = YES;
    // 关闭弹簧效果
    self.bounces = NO;
    // 注册重用ID
    [self registerClass:[GWCollectionViewCell class] forCellWithReuseIdentifier:GWIMAGESPLAYER_CELL];
    // 创建定时器
    self.displayLink =  [CADisplayLink displayLinkWithTarget:self selector:@selector(nextImage)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    self.index = 0;
}

///  跳转到下一张图片
- (void)nextImage {
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.index++  inSection:0];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.index == self.imageArray.count) {
        self.index = 0;
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:NO];
        
        [self nextImage];
        [self nextImage];
    }
}

///  设置帧间隔
- (void)setFramInterval:(NSInteger)framInterval {
    _framInterval = framInterval;
    self.displayLink.frameInterval = framInterval;
}

///  获取flowLayout
- (UICollectionViewFlowLayout *)getFlowLayout {
    UICollectionViewFlowLayout * flowLayout =  [[UICollectionViewFlowLayout  alloc]init];
    // 设置最小间距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    //  设置滚动方向
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    // 预设itemSize
    flowLayout.itemSize = CGSizeMake(1, 1);
    return flowLayout;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    ((UICollectionViewFlowLayout *)self.collectionViewLayout).itemSize = self.bounds.size;
}

#pragma mark - 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSAssert(self.imageArray != nil, @"图片数组不能为空");
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // 获取 cell
    GWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GWIMAGESPLAYER_CELL forIndexPath:indexPath];
    cell.image = self.imageArray[indexPath.item];
    return  cell;
}

#pragma mark - 懒加载
- (NSArray<UIImage *> *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSArray array];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.images.count + 2];
        [tempArr addObject:self.images.lastObject];
        [tempArr addObjectsFromArray:self.images];
        [tempArr addObject:self.images.firstObject];
        _imageArray = tempArr.copy;
    }
    return _imageArray;
}


@end
