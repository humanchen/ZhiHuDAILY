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
#import "ViewController.h"
#import "NavDelegate.h"
#import "RefreshView.h"
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
        headerView.backgroundColor = Color(53, 192, 253, 0.);
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        _tableView.showsVerticalScrollIndicator = NO;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
        _tableView.tableHeaderView = view;
        
        
        [_tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
        _tableView.backgroundColor=[UIColor redColor];
        
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
        
//       NSArray * imageURLs = @[
//                      @"http://a1.mzstatic.com/us/r30/Features49/v4/77/73/3b/77733b19-2fb6-be1a-6a5e-8e01c30d2c94/flowcase_796_390_2x.jpeg",
//                      @"http://a2.mzstatic.com/us/r30/Features49/v4/93/31/d4/9331d426-4596-51f4-8acd-5b0aba8c1692/flowcase_796_390_2x.jpeg",
//                      @"http://a5.mzstatic.com/us/r30/Features49/v4/2f/7e/1c/2f7e1c3a-0431-bfc6-13fc-fe77f3a2fcef/flowcase_796_390_2x.jpeg",
//                      @"http://a1.mzstatic.com/us/r30/Features69/v4/09/83/bf/0983bfcf-52e2-8e16-5541-7cd7e3a10c9e/flowcase_796_390_2x.jpeg",
//                      @"http://a1.mzstatic.com/us/r30/Features49/v4/33/b8/0c/33b80c3e-3f8f-5c31-50a6-b5964a6324f7/flowcase_796_390_2x.jpeg",
//                      @"http://a3.mzstatic.com/us/r30/Features49/v4/db/53/76/db5376f7-ff1b-0c07-501b-8e3e78f3efaf/flowcase_796_390_2x.jpeg",
//                      ];
//
//        NSMutableArray *items = [[NSMutableArray alloc] init];
//                      
//                      for (NSString *imageURL in imageURLs) {
//                          LCFInfiniteScrollViewItem *item = [LCFInfiniteScrollViewItem itemWithImageURL:imageURL text:nil];
//                          [items addObject:item];
//                      }
//
//        _infiniteScrollView.items = items;
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
        
//        [self.view addSubview:titleLabel];
        
//        SYRefreshView *refresh = [SYRefreshView refreshViewWithScrollView:self.tableView];
//        refresh.center = CGPointMake(kScreenWidth*0.5 - 60, 35);
//        [self.view addSubview:refresh];
//        _refreshView = refresh;
        
    }
    return _titleLabel;
}


- (RefreshView *)refreshView{
    if(!_refreshView){
        _refreshView  = [RefreshView refreshViewWithScrollView:self.tableView];
        _refreshView.center = CGPointMake(kScreenWidth*0.5 - 60, 35);
//        _refreshView.backgroundColor=[UIColor redColor];
//        _refreshView = refresh;

    }
    return _refreshView;
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
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    [self setupRAC];
    // Do any additional setup after loading the view.
}



- (void) setupRAC{
    if(!_homeViewModel){
        _homeViewModel=[[HomeViewModel alloc]init];
    }
    [[[_homeViewModel.requestLatesdCommand executionSignals]switchToLatest] subscribeNext:^(id  _Nullable x) {
        
//        NSMutableArray *imageURLs = [NSMutableArray new];
//        for (Top_Stories *topStory in _homeViewModel.topStorys) {
//            [imageURLs addObject:topStory.image];
//        }

        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (Top_Stories *topStory in _homeViewModel.topStorys) {
            LCFInfiniteScrollViewItem *item = [LCFInfiniteScrollViewItem itemWithImageURL:topStory.image text:topStory.title];
            [items addObject:item];
        }
        
        _infiniteScrollView.items = items;

        
        [_tableView reloadData];
        [_refreshView endRefresh];
        
        [self test];
    }];
    [_homeViewModel.requestLatesdCommand execute:nil];
}


- (void)test{
//    NSString *url = @"http://news-at.zhihu.com/api/4/news/latest";
//
//    [PPNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
//        //加载缓存数据
//    } success:^(id responseObject) {
//        //请求成功
//        HomeRootClass *rootClass=[HomeRootClass yy_modelWithDictionary:responseObject];
//        NSLog(@"123");
//    } failure:^(NSError *error) {
//        //请求失败
//    }];
    
    [[[_homeViewModel.requestBeforeCommand executionSignals]switchToLatest] subscribeNext:^(id  _Nullable x) {
        
        //        NSMutableArray *imageURLs = [NSMutableArray new];
        //        for (Top_Stories *topStory in _homeViewModel.topStorys) {
        //            [imageURLs addObject:topStory.image];
        //        }
        
        
//        NSMutableArray *items = [[NSMutableArray alloc] init];
//        
//        for (Top_Stories *topStory in _homeViewModel.topStorys) {
//            LCFInfiniteScrollViewItem *item = [LCFInfiniteScrollViewItem itemWithImageURL:topStory.image text:topStory.title];
//            [items addObject:item];
//        }
//        
//        _infiniteScrollView.items = items;
//        
//        
//        [_tableView reloadData];
//        [_refreshView endRefresh];
    }];
    [_homeViewModel.requestBeforeCommand execute:nil];
    
}

#pragma mark - Table view  delegate & data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   HomeRootClass *rootClass = _homeViewModel.storyGroups.firstObject;
    return rootClass.stories.count;
//    SYBeforeStoryResult *result = self.storyGroup[section];
//    return 10;
    
}

- (HomeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    HomeRootClass *rootClass = _homeViewModel.storyGroups.firstObject;
    NSArray *arr=rootClass.stories;
    Stories *story = arr[indexPath.row];
    cell.story=story;
//    SYBeforeStoryResult *result = self.storyGroup[indexPath.section];
//    cell.story = result.stories[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _mainVC.openDrawerGestureModeMask=0;
    ViewController *test=[ViewController new];
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
        NSLog(@"t");
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
    self.headerView.backgroundColor = Color(53, 192, 253, alpha);
}

#pragma mark scrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y <= -80) {
        [_homeViewModel.requestLatesdCommand execute:@"1"];
    }
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
