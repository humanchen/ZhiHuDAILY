//
//  MenuViewController.h
//  ZhiHuDAILY
//
//  Created by human on 2017/1/17.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewModel.h"
@interface MenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (nonatomic,strong)MenuViewModel *menuViewModel;
@end
