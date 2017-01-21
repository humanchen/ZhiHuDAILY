//
//  MenuViewModel.m
//  ZhiHuDAILY
//
//  Created by human on 2017/1/21.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "MenuViewModel.h"
#import "Theme.h"
@implementation MenuViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupRAC];
    }
    return self;
}

- (void)setupRAC{

    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSString *themeUrl = @"http://news-at.zhihu.com/api/4/themes";
            [NetworkTools GET:themeUrl parameters:nil success:^(id responseObject) {
                
                NSArray *dataArr  =[responseObject objectForKey:@"others"] ;
               _menuList =  [[NSArray yy_modelArrayWithClass:[Theme class] json:dataArr] mutableCopy];
            
                [subscriber sendNext:_menuList];
             
            } failure:^(NSError *error) {
                
            }];
            
            return nil;
        }];
    }];
    
    
    
}
@end
