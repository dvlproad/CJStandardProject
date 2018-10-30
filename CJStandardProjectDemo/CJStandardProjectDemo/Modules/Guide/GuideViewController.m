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
    
    UIButton *testBuglyButton = [STDemoButtonFactory blueButton];
    [testBuglyButton setTitle:NSLocalizedString(@"测试Bugly符号表上传的脚本", nil) forState:UIControlStateNormal];
    [testBuglyButton addTarget:self action:@selector(testBuglyDSYMUpload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBuglyButton];
    [testBuglyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.view).mas_offset(140);
    }];
    
    UIButton *readOverButton = [STDemoButtonFactory blueButton];
    [readOverButton setTitle:NSLocalizedString(@"进入首页", nil) forState:UIControlStateNormal];
    [readOverButton addTarget:self action:@selector(readOverGuide:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readOverButton];
    [readOverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(self.view).mas_offset(-40);
    }];
}

/// 测试Bugly符号表上传的脚本
- (void)testBuglyDSYMUpload {
    NSArray *testBuglyArray = @[@"1"];
    NSLog(@"%@", testBuglyArray[1]);
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
