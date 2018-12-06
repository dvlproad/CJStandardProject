//
//  TestCodeObfuscationViewController.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/30.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TestCodeObfuscationViewController.h"

@interface TestCodeObfuscationViewController ()

@end

@implementation TestCodeObfuscationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"代码混淆测试", nil);
    
    UIButton *cjTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cjTestButton setFrame:CGRectMake(50, 100, 200, 40)];
    [cjTestButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [cjTestButton setTitle:@"测试代码生成的按钮事件" forState:UIControlStateNormal];
    [cjTestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cjTestButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cjTestButton addTarget:self action:@selector(cjcof_codeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton];
    [cjTestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
    
    
    [self setCjcof_testSetterBlock:^(NSInteger payResultType) {
        NSLog(@"测试混淆Block是通过set方法使用的事件");
    }];
    self.cjcof_payResultBlock = ^(NSInteger payResultType) {
        NSLog(@"测试混淆Block事件");
    };
//    self.cjcof_weChatOauthResultBlock = ^(TestCodeObfuscationModel *loginModel) {
//        NSLog(@"测试混淆的类被Block作为参数使用的事件");
//    };
}

#pragma mark - 测试混淆Block
- (IBAction)testBlockAction:(id)sender {
    if (self.cjcof_payResultBlock) {
        self.cjcof_payResultBlock(1);
    }
}

- (IBAction)testClassInBlockAction:(id)sender {
    [self weChatOauthType:NO resultBlock:^(TestCodeObfuscationModel *model) {
        
    }];
}

#pragma mark - 测试代码生成的事件与ib生成的事件
- (void)cjcof_codeButtonAction:(UIButton *)button {
    NSLog(@"测试代码生成的按钮事件--混淆不会崩溃");
}

- (IBAction)cjcof_ibButtonAction:(id)sender {
    NSLog(@"测试IB生成的按钮事件--混淆会崩溃");
}

#pragma mark - 测试参数个数
- (IBAction)test0argAction:(id)sender {
    [self cjcof_method0];
}

- (IBAction)test1argAction:(id)sender {
    [self cjcof_method1:@"1"];
}

- (IBAction)test2argAction:(id)sender {
    [self cjcof_method2:@"1" s2:@"2"];
}

- (void)cjcof_method0 {
    NSLog(@"测试混淆方法(0个参数)");
}

- (void)cjcof_method1:(NSString *)s1 {
    NSLog(@"测试混淆方法(1个参数)");
}

- (void)cjcof_method2:(NSString *)s1 s2:(NSString *)s2 {
    NSLog(@"测试混淆方法(2个参数)");
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
