//
//  LoginViewController+Event.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "LoginViewController+Event.h"
#import <AFNetworking/UIActivityIndicatorView+AFNetworking.h>
//#import <CJDemoModel/DemoUserTableUtil.h>
//
//#import "RegisterViewController.h"
//#import "FindPasdViewController.h"

@implementation LoginViewController (Event)

#pragma mark - Event
///返回
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

///进入"注册"界面
- (IBAction)goRegisterViewController:(id)sender {
//    RegisterViewController *viewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
}

///进入"忘记密码"界面
- (IBAction)goFindPasswordViewController:(id)sender {
//    FindPasdViewController *viewController = [[FindPasdViewController alloc] initWithNibName:@"FindPasdViewController" bundle:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
}



@end
