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
}

- (void)setupViews {
    RACTextFieldBindTableViewCell *staticFlawCell = [[RACTextFieldBindTableViewCell alloc] initWithFrame:CGRectZero];
    [self.view addSubview:staticFlawCell];
    [staticFlawCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(320);
    }];
    [self implementFlawExampleInCell:staticFlawCell];
    
    RACTextFieldBindTableViewCell *staticOKCell = [[RACTextFieldBindTableViewCell alloc] initWithFrame:CGRectZero];
    [self.view addSubview:staticOKCell];
    [staticOKCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(staticFlawCell.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(320);
    }];
    [self implementOKExampleInCell:staticOKCell];
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
