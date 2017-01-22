//
//  MenuViewController.m
//  ZhiHuDAILY
//
//  Created by human on 2017/1/17.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "MenuViewController.h"
#import "LoginViewController.h"
#import "Theme.h"
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
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 1.0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.frame = CGRectMake(0, 0, 200, 30);
    [self.maskView.layer addSublayer:gradientLayer];

    [self setupRAC];
    [self setupTable];
}

- (void)setupTable{
    _table.dataSource=self;
    _table.delegate=self;
    _table.backgroundColor=[UIColor clearColor];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.rowHeight=60;
}

- (void) setupRAC{
    if(!_menuViewModel){
        _menuViewModel=[[MenuViewModel alloc]init];
    }
    [[[_menuViewModel.requestCommand executionSignals]switchToLatest] subscribeNext:^(id  _Nullable x) {
        Theme *firsttheme=[Theme new];
        firsttheme.name=@"首页";
        [_menuViewModel.menuList insertObject:firsttheme atIndex:0];
        
        [_table reloadData];
    }];
    [_menuViewModel.requestCommand execute:nil];
}


#pragma mark tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuViewModel.menuList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tableID = @"menuTable";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableID];
    }
    cell.backgroundColor=[UIColor clearColor];
    Theme *theme=_menuViewModel.menuList[indexPath.row];
    cell.textLabel.text=theme.name;
    cell.textLabel.textColor=[UIColor lightGrayColor];
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    if(indexPath.row==0)
    cell.imageView.image=[UIImage imageNamed:@"Dark_Menu_Icon_Home"];
    else
        cell.imageView.image=nil;
    return cell;
}

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}

//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    
//    SYTheme *theme = self.dataSource[sourceIndexPath.row];
//    [self.dataSource removeObjectAtIndex:sourceIndexPath.row];
//    if (destinationIndexPath.row == 1) {
//        [self.dataSource insertObject:theme atIndex:1];
//    } else {
//        [self.dataSource addObject:theme];
//    }
//    
//}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        [self.mainController setCenterViewController:self.naviHome withCloseAnimation:YES completion:nil];
//    } else {
//        self.themeController.theme = self.dataSource[indexPath.row];
//        [self.mainController setCenterViewController:self.naviTheme withCloseAnimation:YES completion:nil];
//    }
//}


//- (void)test{
//    NSString *themeUrl = @"http://news-at.zhihu.com/api/4/themes";
//    [PPNetworkHelper GET:themeUrl parameters:nil responseCache:^(id responseCache) {
//        //加载缓存数据
//    } success:^(id responseObject) {
//        //请求成功
//    } failure:^(NSError *error) {
//        //请求失败
//    }];
//}

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
