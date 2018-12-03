//
//  RACBindNorTextFieldViewController.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACBindNorTextFieldViewController.h"

@interface RACBindNorTextFieldViewController () {
    
}

@end



@implementation RACBindNorTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"RAC Bind Normal TextField", nil);
    [self setupViews];
    
    [self bindViewModel];
}

- (BOOL)automaticallyAdjustsScrollViewInsets {
    return NO;
}

- (void)setupViews {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:containerView];
    
    
    
    UIView *parentView = containerView;
    
    RACTextFieldBindTableViewCell *staticFlawKeyCell = [[RACTextFieldBindTableViewCell alloc] initWithFrame:CGRectZero];
    [parentView addSubview:staticFlawKeyCell];
    [staticFlawKeyCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(parentView).mas_offset(100);
        make.centerX.mas_equalTo(parentView);
        make.left.mas_equalTo(parentView).mas_offset(10);
        //make.height.mas_equalTo(320);
    }];
    [self implementFlawKeyExampleInCell:staticFlawKeyCell];
    
    RACTextFieldBindTableViewCell *staticFlawCodeCell = [[RACTextFieldBindTableViewCell alloc] initWithFrame:CGRectZero];
    [parentView addSubview:staticFlawCodeCell];
    [staticFlawCodeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(staticFlawKeyCell.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(parentView);
        make.left.mas_equalTo(parentView).mas_offset(10);
        //make.height.mas_equalTo(320);
    }];
    [self implementFlawCodeExampleInCell:staticFlawCodeCell];
    
    
    RACTextFieldBindTableViewCell *staticOKCell = [[RACTextFieldBindTableViewCell alloc] initWithFrame:CGRectZero];
    [parentView addSubview:staticOKCell];
    [staticOKCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(staticFlawCodeCell.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(parentView);
        make.left.mas_equalTo(parentView).mas_offset(10);
        //make.height.mas_equalTo(320);
    }];
    [self implementOKExampleInCell:staticOKCell];
    
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.bottom.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView.mas_width);
        make.bottom.mas_equalTo(staticOKCell).mas_offset(1);
    }];
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
