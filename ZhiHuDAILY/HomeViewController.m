//
//  HomeViewController.m
//  ZhiHuDAILY
//
//  Created by human on 2017/1/24.
//  Copyright © 2017年 陈思宇. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HomeRootClass.h"
#import "LCFInfiniteScrollView.h"
#import "HomeViewModel.h"
#import "Top_Stories.h"
#import "Stories.h"
#import "DetailController.h"
#import "NavDelegate.h"
#import "RefreshView.h"
#import "HomeTableHeaderView.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LCFInfiniteScrollView *infiniteScrollView;
@property (nonatomic, strong) HomeViewModel *homeViewModel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NavDelegate *de;
@property (nonatomic, strong) RefreshView *refreshView;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation HomeViewController

- (UIView *)headerView {
    if (!_headerView) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(0, 0, kScreenWidth, 56);
        headerView.backgroundColor = Color(23, 144, 211, 0.);
        _headerView = headerView;
    }
    return _headerView;
}


- (UIButton *)leftButton {
    if (!_leftButton) {
        UIButton *leftButton = [[UIButton alloc] init];
        leftButton.frame = CGRectMake(10, 20, 30, 30);
        [leftButton addTarget:self action:@selector(didClickedMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setImage:[UIImage imageNamed:@"Home_Icon"] forState:UIControlStateNormal];
        
        _leftButton = leftButton;
    }
    return _leftButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop=YES;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _tableView.tableHeaderView = view;
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
//        _tableView.backgroundColor=[UIColor redColor];
        
    }
    return _tableView;
}

- (LCFInfiniteScrollView *)infiniteScrollView{
    if(!_infiniteScrollView){
        
        _infiniteScrollView = [[LCFInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 220)];
        _infiniteScrollView.itemSize = CGSizeMake(kScreenWidth, 220);
        _infiniteScrollView.itemSpacing = 0;
        _infiniteScrollView.autoscroll = YES;
        _infiniteScrollView.timeInterval = 5;
        
        
    }
    return _infiniteScrollView;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        
        NSDictionary *attr = @{
                               NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
        
        titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"今日要闻" attributes:attr];
        [titleLabel sizeToFit];
        titleLabel.center = CGPointMake(kScreenWidth*0.5, 35);
        _titleLabel = titleLabel;

        
    }
    return _titleLabel;
}


- (RefreshView *)refreshView{
    if(!_refreshView){
        _refreshView  = [RefreshView refreshViewWithScrollView:self.tableView];
        _refreshView.center = CGPointMake(kScreenWidth*0.5 - 60, 35);


    }
    return _refreshView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.mainVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    self.navigationController.navigationBar.hidden=YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.infiniteScrollView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.refreshView];
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    [self setupRAC];
    
    __weak HomeViewController *ws=self;
    self.infiniteScrollView.didSelectItemAtIndex=^(NSUInteger index){
        NSMutableArray *topStorys=ws.homeViewModel.topStorys;
        ws.mainVC.openDrawerGestureModeMask=0;
        DetailController *test=[DetailController new];
//        HomeBaseClass *rootClass = _homeViewModel.storyGroups[indexPath.section];
        Stories *story = topStorys[index];
        test.story=story;
        ws.de=[NavDelegate new];
        ws.navigationController.delegate=ws.de;
        [ws.navigationController pushViewController:test animated:YES];

    };
    // Do any additional setup after loading the view.
}



- (void) setupRAC{
    if(!_homeViewModel){
        _homeViewModel=[[HomeViewModel alloc]init];
    }
    [[[_homeViewModel.requestLatesdCommand executionSignals]switchToLatest] subscribeNext:^(id  _Nullable x) {
        


        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (Top_Stories *topStory in _homeViewModel.topStorys) {
            LCFInfiniteScrollViewItem *item = [LCFInfiniteScrollViewItem itemWithImageURL:topStory.image text:topStory.title];
            [items addObject:item];
        }
        
        _infiniteScrollView.items = items;

        
        [_tableView reloadData];
        [_refreshView endRefresh];

 
    }];
    [_homeViewModel.requestLatesdCommand execute:nil];
    
    
    [[[_homeViewModel.requestBeforeCommand executionSignals]switchToLatest] subscribeNext:^(id  _Nullable x) {
        [_tableView reloadData];
    }];
}


- (void)loadMore{
    

    [_homeViewModel.requestBeforeCommand execute:nil];
    
}

#pragma mark - Table view  delegate & data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _homeViewModel.storyGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   HomeRootClass *rootClass = _homeViewModel.storyGroups[section];
    return rootClass.stories.count;

    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeTableHeaderView *headerView = [HomeTableHeaderView headerViewWithTableView:tableView];
    HomeBaseClass *result = self.homeViewModel.storyGroups[section];
    headerView.date = result.date;
    return section ? headerView : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return section ? 36 : CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        CGRect frame = self.headerView.frame;
        frame.size.height = 55;
        self.headerView.frame=frame;
        self.titleLabel.alpha = 1;
    }
    // 当显示最后一组时，加载更早之前的数据
    if (section == self.homeViewModel.storyGroups.count-1) {
        [self loadMore];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (section == 0) {
        CGRect frame = self.headerView.frame;
        frame.size.height = 20;
        self.headerView.frame=frame;
        self.titleLabel.alpha = 0;
    }
}

- (HomeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    HomeBaseClass *rootClass = _homeViewModel.storyGroups[indexPath.section];
    NSArray *arr=rootClass.stories;
    Stories *story = arr[indexPath.row];
    cell.story=story;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _mainVC.openDrawerGestureModeMask=0;
    DetailController *test=[DetailController new];
    HomeBaseClass *rootClass = _homeViewModel.storyGroups[indexPath.section];
    NSArray *arr=rootClass.stories;
    Stories *story = arr[indexPath.row];
    test.story=story;
    _de=[NavDelegate new];
    self.navigationController.delegate=_de;
    [self.navigationController pushViewController:test animated:YES];
}

- (void)didClickedMenuButton:(UIButton *)sender {
    [self.mainVC toggleDrawer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    CGFloat yoffset = scrollView.contentOffset.y;
    if(yoffset<=0){
        //下推
//        NSLog(@"t");
        self.infiniteScrollView.frame=CGRectMake(0, 0, kScreenWidth, 220-yoffset);
        [self.infiniteScrollView resetData];
        
    }else{
        //上拉
        self.infiniteScrollView.frame=CGRectMake(0, -yoffset, kScreenWidth, 220);
        [self.infiniteScrollView resetData];
    }
    
    
    CGFloat alpha = 0;
    if (yoffset <= 75.) {
        alpha = 0;
    } else if (yoffset < 165.) {
        alpha = (yoffset-75.) / (165.-75);
    } else {
        alpha = 1.;
    }
    self.headerView.backgroundColor = Color(23, 144, 211, alpha);
}

#pragma mark scrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y <= -80) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           [_homeViewModel.requestLatesdCommand execute:nil];
       });

    }
}


//- (void)infiniteScrollView:(LCFInfiniteScrollView *)infiniteScrollView didDisplayItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
