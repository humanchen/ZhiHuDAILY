//
//  NetworkTools.h
//  ZhiHuDAILY
//
//  Created by human on 2017/1/21.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 请求成功的Block */
typedef void(^HttpRequestSuccess)(id responseObject,bool New);

/** 请求失败的Block */
typedef void(^HttpRequestFailed)(NSError *error);

@interface NetworkTools : NSObject

//GET请求
+ (void )GET:(NSString *)URL
  parameters:(NSDictionary *)parameters
     success:(HttpRequestSuccess)success
     failure:(HttpRequestFailed)failure;


@end
