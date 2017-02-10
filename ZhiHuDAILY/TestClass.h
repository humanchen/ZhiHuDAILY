//
//  TestClass.h
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/10.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stories.h"
@interface TestClass : NSObject
@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSArray<Stories *> *stories;
@end
