//
//  STDemoDDOrderListViewController.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoDDOrderListViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "OrderListViewModel.h"
#import "OrderListTableViewDataSource.h"
#import "OrderListTableViewDelegate.h"

@interface STDemoDDOrderListViewController () {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderListViewModel *orderListViewModel;
@property (nonatomic, strong) OrderListTableViewDataSource *tableViewDataSource;
@property (nonatomic, strong) OrderListTableViewDelegate *tableViewDelegate;



@end

@implementation STDemoDDOrderListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"订单列表(独立协议)", nil);
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.orderListViewModel = [[OrderListViewModel alloc] init];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupViews {
    
}

#pragma mark - Event
- (void)headerRefreshAction {
    __weak typeof(self)weakSelf = self;
    [self.orderListViewModel headerRefreshRequestWithCompleteBlock:^(NSMutableArray<STDemoOrderModel *> *orders) {
        
        weakSelf.tableViewDataSource.orders = orders;
        weakSelf.tableViewDelegate.orders = orders;
        
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    }];

}

- (void)footerRefreshAction {
    __weak typeof(self)weakSelf = self;
    [self.orderListViewModel footerRefreshRequestWithCompleteBlock:^(NSMutableArray<STDemoOrderModel *> *orders) {
        
        weakSelf.tableViewDataSource.orders = orders;
        weakSelf.tableViewDelegate.orders = orders;
        
        [weakSelf.tableView.mj_footer endRefreshing];
        [weakSelf.tableView reloadData];
    }];
  
}


#pragma mark - Lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableViewDataSource = [[OrderListTableViewDataSource alloc] init];
        self.tableViewDelegate = [[OrderListTableViewDelegate alloc] init];
        _tableView.dataSource = self.tableViewDataSource;
        _tableView.delegate = self.tableViewDelegate;
        
        __weak typeof(self) weakSelf = self;
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf headerRefreshAction];
        }];
        
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf footerRefreshAction];
        }];
    }
    
    return _tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
