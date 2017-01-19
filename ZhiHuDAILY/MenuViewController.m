//
//  MenuViewController.m
//  ZhiHuDAILY
//
//  Created by human on 2017/1/17.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headView.clipsToBounds=YES;
    self.headView.layer.cornerRadius=20;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
