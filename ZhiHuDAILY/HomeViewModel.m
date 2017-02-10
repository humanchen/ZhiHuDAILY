//
//  HomeViewModel.m
//  ZhiHuDAILY
//
//  Created by human on 2017/1/26.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "HomeViewModel.h"
#import "HomeRootClass.h"
#import "HomeBaseClass.h"
#import "TestClass.h"
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
           [NetworkTools GET:themeUrl parameters:nil success:^(id responseObject,bool New) {
               HomeRootClass *rootClass=[HomeRootClass yy_modelWithDictionary:responseObject];
               _topStorys = [rootClass.top_stories mutableCopy];

               _storyGroups = [NSMutableArray new];
               [_storyGroups addObject:rootClass];
                [subscriber sendNext:nil];
               if(New==true)
               [subscriber sendCompleted];
            } failure:^(NSError *error) {
                
           }];
            
            return nil;
        }];
    }];
//    _requestLatesdCommand.allowsConcurrentExecution=YES;
    
    _requestBeforeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            HomeRootClass *root=_storyGroups.lastObject;
            NSString *dateTime=root.date;
            NSString *beforeUrl = [NSString stringWithFormat:@"http://news.at.zhihu.com/api/4/news/before/%@", dateTime];
           __block int add=0;
            [NetworkTools GET:beforeUrl parameters:nil success:^(id responseObject,bool New) {
                if(add==1)
                    return ;
                HomeBaseClass *baseClass=[HomeBaseClass yy_modelWithDictionary:responseObject];
                
                [_storyGroups addObject:baseClass];
                add=1;
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
             
            } failure:^(NSError *error) {
                
            }];
            
            return nil;
        }];
    }];
    
//    _requestBeforeCommand.allowsConcurrentExecution=YES;
}

@end
