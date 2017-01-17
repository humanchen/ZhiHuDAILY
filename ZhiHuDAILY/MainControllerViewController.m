//
//  MainControllerViewController.m
//  ZhiHuDAILY
//
//  Created by 陈思宇 on 17/1/17.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "MainControllerViewController.h"
#import "DEMOLeftMenuViewController.h"
#import "DEMORightMenuViewController.h"
#import "DEMOFirstViewController.h"
#import "MenuViewController.h"

@interface MainControllerViewController ()

@end

@implementation MainControllerViewController

-(void)awakeFromNib{
    [super awakeFromNib];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[DEMOFirstViewController alloc] init]];
    MenuViewController *leftMenuViewController = [[MenuViewController alloc] init];
    DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];

    self.contentViewController = navigationController;
    self.leftMenuViewController = leftMenuViewController;
    self.rightMenuViewController = rightMenuViewController;
    
    self.panFromEdge=NO;
    self.scaleMenuView=NO;
    self.scaleContentView=NO;
    self.contentViewInLandscapeOffsetCenterX=0;
    self.contentViewInPortraitOffsetCenterX=200-self.view.frame.size.width/2;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
