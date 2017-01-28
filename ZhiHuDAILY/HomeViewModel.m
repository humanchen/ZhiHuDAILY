//
//  HomeViewModel.m
//  ZhiHuDAILY
//
//  Created by human on 2017/1/26.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeRootClass.h"
@implementation HomeViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupRAC];
    }
    return self;
}

- (void)setupRAC{
    
    _requestLatesdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
           NSString *themeUrl = @"http://news-at.zhihu.com/api/4/news/latest";
           [NetworkTools GET:themeUrl parameters:nil success:^(id responseObject) {
               HomeRootClass *rootClass=[HomeRootClass yy_modelWithDictionary:responseObject];
               _topStorys = [rootClass.top_stories mutableCopy];
//               _firstStorys = [rootClass.stories mutableCopy];
               _storyGroups = [NSMutableArray new];
               [_storyGroups addObject:rootClass];
                [subscriber sendNext:nil];
               
            } failure:^(NSError *error) {
                
           }];
            
            return nil;
        }];
    }];
    
    
    
}

@end
