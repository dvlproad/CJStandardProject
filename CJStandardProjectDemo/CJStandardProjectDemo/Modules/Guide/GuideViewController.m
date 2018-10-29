//
//  GuideViewController.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"引导页", nil);
    
    UIButton *blueButton = [CJDemoButtonFactory blueButton];
    [blueButton setTitle:NSLocalizedString(@"进入首页", nil) forState:UIControlStateNormal];
    [blueButton addTarget:self action:@selector(readOverGuide:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blueButton];
    [blueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view).mas_offset(-40);
    }];
}

- (void)readOverGuide:(UIButton *)button {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(guideViewControllerReadOver:)]) {
        [self.delegate guideViewControllerReadOver:self];
    }
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
