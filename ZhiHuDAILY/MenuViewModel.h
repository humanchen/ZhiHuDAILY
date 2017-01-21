//
//  MenuViewModel.h
//  ZhiHuDAILY
//
//  Created by human on 2017/1/21.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "BaseViewModel.h"

@interface MenuViewModel : BaseViewModel
@property(nonatomic,strong)RACCommand *requestCommand;//请求命令
@property(nonatomic,strong)NSMutableArray *menuList;


@end
