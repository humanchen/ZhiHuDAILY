//
//  DetailViewModel.h
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/14.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "BaseViewModel.h"
#import "DetailStory.h"
@interface DetailViewModel : BaseViewModel
@property(nonatomic,strong)RACCommand *requestDetailCommand;//请求命令
@property(nonatomic,assign)NSInteger storyid;
@property(nonatomic,strong)DetailStory *detailStory;
@end
