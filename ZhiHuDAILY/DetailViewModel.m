//
//  DetailViewModel.m
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/14.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "DetailViewModel.h"

@implementation DetailViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupRAC];
    }
    return self;
}

- (void)setupRAC{
    
    _requestDetailCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            NSString *url = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%ld",(long)self.storyid];
//            NSString *themeUrl = @"http://news-at.zhihu.com/api/4/news/latest";
            [NetworkTools GET:url parameters:nil success:^(id responseObject,bool New) {
                _detailStory=[DetailStory yy_modelWithDictionary:responseObject];
                _detailStory.htmlStr = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>", _detailStory.css[0], _detailStory.body];
//                NSString *test=_detailStory.share_url;
//                HomeRootClass *rootClass=[HomeRootClass yy_modelWithDictionary:responseObject];
//                _topStorys = [rootClass.top_stories mutableCopy];
//                
//                _storyGroups = [NSMutableArray new];
//                [_storyGroups addObject:rootClass];
                [subscriber sendNext:nil];
//                if(New==true)
                    [subscriber sendCompleted];
            } failure:^(NSError *error) {
                
            }];
        
            return nil;
        }];
    }];
}
@end
