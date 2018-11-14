//
//  GSPageViewController3.m
//  GSUITestDemo
//
//  Created by gersces on 2018/8/30.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import "GSPageViewController3.h"
#import "GSSubViewController.h"

@interface GSPageViewController3 ()

@end

@implementation GSPageViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 100, 345, 30);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"点击跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)btnAction:(UIButton *)sender{
    GSSubViewController *vc = [[GSSubViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"subPage";
    [self.navigationController pushViewController:vc animated:YES];
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
