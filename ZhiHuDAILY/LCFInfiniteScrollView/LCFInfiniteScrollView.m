//
//  LCFInfiniteScrollView.m
//  LCFInfiniteScrollView
//
//  Created by leichunfeng on 16/4/16.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "LCFInfiniteScrollView.h"
#import "LCFCollectionViewFlowLayout.h"
#import "LCFCollectionViewCell.h"
#import "UIColor+LCFImageAdditions.h"
//#import <SDWebImage/UIImageView+WebCache.h>
#import "YYWebImage.h"
@interface LCFInfiniteScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LCFCollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LCFInfiniteScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (UIPageControl *)pageControl{
    if(!_pageControl){
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth-100)/2, self.frame.size.height-20, 100, 20)];
        _pageControl.pageIndicatorTintColor=[UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
        
    }
    return  _pageControl;
}


- (void)initialize {
    self.collectionViewLayout = [[LCFCollectionViewFlowLayout alloc] init];
    
    self.collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.collectionViewLayout];
    [self addSubview:self.collectionView];
    
    [self addSubview:self.pageControl];
    
    self.collectionView.backgroundColor  = [UIColor whiteColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    [self.collectionView registerClass:[LCFCollectionViewCell class] forCellWithReuseIdentifier:@"LCFCollectionViewCell"];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator   = NO;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.itemSize = self.frame.size;
    self.itemSpacing = 0;
    
    _autoscroll = YES;
    _timeInterval = 10;
    
    [self setUpTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidChangeStatusBarOrientationNotification:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)reportStatus {
    CGPoint point = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMidY(self.collectionView.bounds));
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    indexPath = [NSIndexPath indexPathForItem:indexPath.row % (self.items.count / 3) inSection:indexPath.section];
    
    if ([self.delegate respondsToSelector:@selector(infiniteScrollView:didDisplayItemAtIndexPath:)]) {
        [self.delegate infiniteScrollView:self didDisplayItemAtIndexPath:indexPath];
    }
}

- (void)applicationDidChangeStatusBarOrientationNotification:(NSNotification *)notification {
    self.collectionView.contentOffset = [self.collectionViewLayout targetContentOffsetForProposedContentOffset:self.collectionView.contentOffset withScrollingVelocity:CGPointZero];
}

- (void)didMoveToWindow {
    if (self.window == nil) return;
    
    self.collectionView.contentOffset = [self.collectionViewLayout targetContentOffsetForProposedContentOffset:self.collectionView.contentOffset withScrollingVelocity:CGPointZero];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Getters and Setters

- (UIImage *)placeholderImage {
    if (!_placeholderImage) {
        UIColor *color = [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1];
        _placeholderImage = [color lcf_imageSized:self.itemSize];
    }
    return _placeholderImage;
}

- (void)setItems:(NSArray *)items {
    if (items.count == 0) return;
    
    NSMutableArray *mutableItems = [[NSMutableArray alloc] init];
    
//    for (NSUInteger i = 0; i < 3; i++) {
//        [mutableItems addObjectsFromArray:items];
//    }
    
    [mutableItems addObject:items.lastObject];
    [mutableItems addObjectsFromArray:items];
    [mutableItems addObject:items.firstObject];
    
    _items = mutableItems.copy;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
       
        dispatch_async(dispatch_get_main_queue(), ^{
            if (CGPointEqualToPoint(self.collectionView.contentOffset, CGPointZero)) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]
                                            atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                                    animated:NO];
                
                [self reportStatus];
            }
        });
    });
    
    self.pageControl.numberOfPages=items.count;
    self.pageControl.currentPage=0;
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    self.collectionViewLayout.itemSize = itemSize;
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    _itemSpacing = itemSpacing;
    self.collectionViewLayout.minimumLineSpacing = itemSpacing;
}

- (void)setAutoscroll:(BOOL)autoscroll {
    _autoscroll = autoscroll;
    [self setUpTimer];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    _timeInterval = timeInterval;
    [self setUpTimer];
}

#pragma mark - Timer

- (void)setUpTimer {
    [self tearDownTimer];
    
    if (!self.autoscroll) return;
    
    self.timer = [NSTimer timerWithTimeInterval:self.timeInterval
                                         target:self
                                       selector:@selector(timerFire:)
                                       userInfo:nil
                                        repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)tearDownTimer {
    [self.timer invalidate];
}

- (void)timerFire:(NSTimer *)timer {
    CGFloat currentOffset = self.collectionView.contentOffset.x;
    CGFloat targetOffset  = currentOffset + self.itemSize.width + self.itemSpacing;
    
    [self.collectionView setContentOffset:CGPointMake(targetOffset, self.collectionView.contentOffset.y) animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LCFCollectionViewCell" forIndexPath:indexPath];
    
    LCFInfiniteScrollViewItem *item = self.items[indexPath.row];
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageURL] placeholderImage:self.placeholderImage];
    [cell.imageView yy_setImageWithURL:[NSURL URLWithString:item.imageURL] options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation];
    cell.label.text = item.text;
    
    
    
    cell.label.font = [UIFont boldSystemFontOfSize:21];
  
    
//    cell.label.backgroundColor=[UIColor redColor];
    cell.label.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreenWidth-20-15, 9999);//labelsize的最大值
    
    CGSize expectSize = [cell.label sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    cell.label.frame = CGRectMake(20, 200-20-expectSize.height, expectSize.width, expectSize.height);
    

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectItemAtIndex) {
        self.didSelectItemAtIndex(indexPath.row % (self.items.count / 3));
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.itemSize.width + self.itemSpacing;
    CGFloat periodOffset = pageWidth * (self.items.count -2);
//    CGFloat offsetActivatingMoveToBeginning = pageWidth * ((self.items.count / 3) * 2);
//    CGFloat offsetActivatingMoveToEnd = pageWidth * ((self.items.count / 3) * 1);
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if(offsetX<0){
        scrollView.contentOffset=CGPointMake(periodOffset+offsetX, 0);
    }else if(offsetX > pageWidth * (self.items.count-1) - self.frame.size.width){
        scrollView.contentOffset= CGPointMake(offsetX - periodOffset, 0 );
    }
    
    if(self.itemSize.width <= self.frame.size.width){
        
        
        
        CGFloat startOff = pageWidth - (self.frame.size.width - (self.itemSize.width))/2;
        self.pageControl.currentPage=(scrollView.contentOffset.x-startOff)/pageWidth;
        if(offsetX < pageWidth)
            self.pageControl.currentPage = self.items.count - 3;
    }else{
        CGFloat startOff = pageWidth;
        int page = (scrollView.contentOffset.x -startOff)/pageWidth;
        if(page > (self.items.count - 3)){
            page=0;
        }
        
        self.pageControl.currentPage=page;
        
        
    }
    
    
//    int x;
//    if (offsetX > offsetActivatingMoveToBeginning) {
//        scrollView.contentOffset = CGPointMake((offsetX - periodOffset), 0);
//        x=(scrollView.contentOffset.x-offsetActivatingMoveToEnd)/pageWidth;
//    } else if (offsetX < offsetActivatingMoveToEnd) {
//        scrollView.contentOffset = CGPointMake((offsetX + periodOffset), 0);
//        x=(scrollView.contentOffset.x-offsetActivatingMoveToEnd)/pageWidth;
//    }
//    x=(scrollView.contentOffset.x-offsetActivatingMoveToEnd)/pageWidth;
//    self.pageControl.currentPage=(scrollView.contentOffset.x-offsetActivatingMoveToEnd)/pageWidth;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self tearDownTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reportStatus];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self reportStatus];
    
    self.collectionView.contentOffset = [self.collectionViewLayout targetContentOffsetForProposedContentOffset:self.collectionView.contentOffset withScrollingVelocity:CGPointZero];
}

@end
