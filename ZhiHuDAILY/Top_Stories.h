//
//  Top_Stories.h
//  zhihuDaily
//
//  Created by human on 17/01/26
//  Copyright (c) yang. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Top_Stories : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *ga_prefix;

@end