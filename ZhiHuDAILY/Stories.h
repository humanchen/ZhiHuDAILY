//
//  Stories.h
//  zhihuDaily
//
//  Created by human on 17/01/26
//  Copyright (c) yang. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Stories : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray<NSString *> *images;

@property (nonatomic, copy) NSString *ga_prefix;

@property (nonatomic, assign) BOOL multipic;

@end
