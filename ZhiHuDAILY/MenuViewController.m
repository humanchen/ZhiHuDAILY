//
//  MenuViewController.m
//  ZhiHuDAILY
//
//  Created by human on 2017/1/17.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "MenuViewController.h"
#import "LoginViewController.h"
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
    
    
    //  添加渐变层
    CAGradientLayer * shadow = [CAGradientLayer layer];
    shadow.frame = self.maskView.bounds;
    [self.maskView.layer addSublayer:shadow];
    
    //  设置渐变的方向
    shadow.startPoint = CGPointMake(0, 10);
    shadow.endPoint = CGPointMake(0, 0);
    
    //  设置渐变的颜色
    shadow.colors = @[(__bridge id)[UIColor colorWithRed:51 green:51 blue:51 alpha:1.0].CGColor,
                      (__bridge id)[UIColor clearColor].CGColor];
    
    //  设置渐变分割点
    shadow.locations = @[@(0.5f),@(1.0f)];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)login:(id)sender {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *lvc= [story instantiateViewControllerWithIdentifier:@"LoginView"];
    [self presentViewController:lvc animated:YES completion:nil];
    
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
