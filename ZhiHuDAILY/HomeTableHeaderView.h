//
//  HomeTableHeaderView.h
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/2/10.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *date;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
