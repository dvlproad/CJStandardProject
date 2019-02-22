//
//  STDemoNormalOrderListViewController.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "STDemoNormalOrderListViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "OrderCell.h"
#import "OrderListLogicControl.h"

@interface STDemoNormalOrderListViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderListLogicControl *orderListlogicControl;



@end

@implementation STDemoNormalOrderListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"订单列表(正常)", nil);
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.orderListlogicControl = [[OrderListLogicControl alloc] init];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orderListlogicControl getNumberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    STDemoOrderModel *orderModel = [self.orderListlogicControl getOrderModelForRowAtIndexPath:indexPath];
    cell.titleLabel.text = orderModel.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    STDemoOrderModel *orderModel = [self.orderListlogicControl getOrderModelForRowAtIndexPath:indexPath];
    [DemoToast showMessage:orderModel.title];
}


#pragma mark - Lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        __weak typeof(self) weakSelf = self;
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf.orderListlogicControl headerRefreshRequestWithCompleteBlock:^{
                [weakSelf.tableView.mj_header endRefreshing];
                [weakSelf.tableView reloadData];
            }];
        }];
        
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf.orderListlogicControl footerRefreshRequestWithCompleteBlock:^{
                [weakSelf.tableView.mj_footer endRefreshing];
                [weakSelf.tableView reloadData];
            }];
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
