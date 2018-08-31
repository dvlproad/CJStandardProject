//
//  TableViewController.m
//  CJStandardProjectDemo
//
//  Created by 李超前 on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "TableViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "TableViewModel.h"
#import "TableViewDataSource.h"
#import "TableViewDelegate.h"

@interface TableViewController () {
    NSMutableArray *totalSource;
    TableViewModel *tableViewModel;
    UITableView *tableView;
    TableViewDataSource *tableViewDataSource;
    TableViewDelegate *tableViewDelegate;
}

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MVVMDemo With TableView";
    self.view.backgroundColor=[UIColor whiteColor];
    
    
    tableView=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    tableViewDataSource=[[TableViewDataSource alloc] init];
    tableViewDelegate=[[TableViewDelegate alloc] init];
    tableView.dataSource=tableViewDataSource;
    tableView.delegate=tableViewDelegate;
    tableViewModel=[[TableViewModel alloc] init];
    totalSource=0;
    
    __weak typeof(self) weakSelf = self;
    tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf headerRefreshAction];
    }];
    [tableView.mj_header beginRefreshing]; //是否在进入该界面的时候就开始进入刷新状态
    
    tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf footerRefreshAction];
    }];
    
}

- (void)headerRefreshAction
{
   
    [tableViewModel headerRefreshRequestWithCallback:^(NSArray *array){
        totalSource=(NSMutableArray *)array;
        tableViewDataSource.array=totalSource;
        tableViewDelegate.array=totalSource;
        [tableView.mj_header endRefreshing];
        [tableView reloadData];
    }];

}

- (void)footerRefreshAction
{
    [tableViewModel footerRefreshRequestWithCallback:^(NSArray *array){
        [totalSource addObjectsFromArray:array] ;
        tableViewDataSource.array=totalSource;
        tableViewDelegate.array=totalSource;
        [tableView.mj_footer endRefreshing];
        [tableView reloadData];
    
    }];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
