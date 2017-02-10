//
//  HomeBaseClass.m
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/10.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "HomeBaseClass.h"

@implementation HomeBaseClass

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"stories" : [Stories class]};
}

@end
