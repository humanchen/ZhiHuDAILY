//
//  LCFCollectionViewCell.m
//  LCFInfiniteScrollView
//
//  Created by leichunfeng on 16/4/16.
//  Copyright © 2016年 leichunfeng. All rights reserved.
//

#import "LCFCollectionViewCell.h"

@interface LCFCollectionViewCell ()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation LCFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}



- (void)initialize {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame=self.contentView.bounds;
    [self.contentView addSubview:self.imageView];
    
//    self.maskView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
//    [self.contentView addSubview:self.maskView];
//    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 1.0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.frame = CGRectMake(0, self.bounds.size.height-150, kScreenWidth, 150);
    _gradientLayer=gradientLayer;
    [self.imageView.layer addSublayer:gradientLayer];
    
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
//    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:@{ @"imageView": self.imageView }]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:@{ @"imageView": self.imageView }]];
    
    self.label = [[UILabel alloc] init];
    [self.contentView addSubview:self.label];
    
    self.label.font = [UIFont boldSystemFontOfSize:20];
    self.label.textColor = [UIColor whiteColor];
//    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    
    self.label.frame=CGRectMake(20, 150, kScreenWidth-20*2, 30);
    self.label.shadowColor=[UIColor blackColor];
    self.label.shadowOffset=CGSizeMake(1, 1);
//    self.label.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
//                                                                             options:0
//                                                                             metrics:nil
//                                                                               views:@{ @"label": self.label }]];
//    
//    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.label
//                                                                 attribute:NSLayoutAttributeCenterY
//                                                                 relatedBy:NSLayoutRelationEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeCenterY
//                                                                multiplier:1
//                                                                  constant:0]];
}

@end
