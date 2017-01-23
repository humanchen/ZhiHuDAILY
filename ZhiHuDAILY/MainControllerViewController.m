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
#import "MMExampleDrawerVisualStateManager.h"
@interface MainControllerViewController ()

@end

@implementation MainControllerViewController

-(void)awakeFromNib{
    [super awakeFromNib];
 
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[DEMOFirstViewController alloc] init]];
    MenuViewController *leftMenuViewController = [[MenuViewController alloc] init];
//    DEMORightMenuViewController *rightMenuViewController = [[DEMORightMenuViewController alloc] init];

    self.centerViewController=navigationController;
    self.leftDrawerViewController=leftMenuViewController;
//    self.rightDrawerViewController=rightMenuViewController;
    
    self.shouldStretchDrawer = NO;
    
    [self setMaximumLeftDrawerWidth:230.0];
    [self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
     [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeSlide];
    
    [self
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
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
