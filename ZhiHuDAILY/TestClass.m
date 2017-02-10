//
//  TestClass.m
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/10.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"stories" : [Stories class]};
}
@end
