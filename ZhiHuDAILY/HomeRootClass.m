//
//  ESRootClass.m
//  zhihuDaily
//
//  Created by human on 17/01/26
//  Copyright (c) yang. All rights reserved.
//

#import "HomeRootClass.h"
#import "Stories.h"
#import "Top_Stories.h"

@implementation HomeRootClass

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"stories" : [Stories class], @"top_stories" : [Top_Stories class]};
}

@end
