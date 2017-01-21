//
//  NetworkTools.m
//  ZhiHuDAILY
//
//  Created by human on 2017/1/21.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "NetworkTools.h"

@implementation NetworkTools

+ (void )GET:(NSString *)URL
  parameters:(NSDictionary *)parameters
     success:(HttpRequestSuccess)success
     failure:(HttpRequestFailed)failure{
    
    [PPNetworkHelper GET:URL parameters:parameters responseCache:^(id responseCache) {
        //加载缓存数据
        if(success)
            success(responseCache);
    } success:^(id responseObject) {
        //请求成功
        if(success)
            success(responseObject);
    } failure:^(NSError *error) {
        //请求失败
        if(failure)
            failure(error);
    }];
    
}

@end
