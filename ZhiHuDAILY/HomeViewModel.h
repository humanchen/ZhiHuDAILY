//
//  HomeViewModel.h
//  ZhiHuDAILY
//
//  Created by human on 2017/1/26.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel
@property(nonatomic,strong)RACCommand *requestLatesdCommand;//请求命令
@end
