//
//  ESRootClass.h
//  zhihuDaily
//
//  Created by human on 17/01/26
//  Copyright (c) yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Stories,Top_Stories;

@interface HomeRootClass : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, strong) NSArray<Stories *> *stories;

@property (nonatomic, strong) NSArray<Top_Stories *> *top_stories;

@end
