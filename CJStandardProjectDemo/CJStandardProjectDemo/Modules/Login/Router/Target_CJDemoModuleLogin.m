//
//  Target_CJDemoModuleLogin.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/3/23.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "Target_CJDemoModuleLogin.h"

#import "GuideViewController.h"
#import "GuideMainViewController.h"
#import "LoginViewController.h"

@implementation Target_CJDemoModuleLogin

///引导视图
- (UIViewController *)Action_guideViewController:(NSDictionary *)params {
    GuideViewController *viewController = [[GuideViewController alloc] init];
    
    return viewController;
}

///引导注册或登录视图
- (UIViewController *)Action_guideMainViewController:(NSDictionary *)params {
//    UIViewController *viewController = [[UIViewController alloc] init];
//    viewController.title = NSLocalizedStringFromTable(@"引导登录", @"CJDemoModuleLogin", nil);
//    viewController.view.backgroundColor = [UIColor redColor];
    GuideMainViewController *viewController = [[GuideMainViewController alloc] initWithNibName:@"GuideMainViewController" bundle:nil];
    
    return viewController;
}

///登录视图
- (UIViewController *)Action_loginViewController:(NSDictionary *)params {
//    UIViewController *viewController = [[UIViewController alloc] init];
//    viewController.title = NSLocalizedStringFromTable(@"登录", @"CJDemoModuleLogin", nil);
//    viewController.view.backgroundColor = [UIColor greenColor];
    
    LoginViewController *viewController = [[LoginViewController alloc] init];
    
    return viewController;
}

///修改密码页(初始密码时候需要)
- (UIViewController *)Action_changePasswordViewController:(NSDictionary *)params {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedStringFromTable(@"更改密码", @"CJDemoModuleLogin", nil);
    viewController.view.backgroundColor = [UIColor greenColor];
    
    return viewController;
}

///注册页
- (UIViewController *)Action_registerViewController:(NSDictionary *)params {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedStringFromTable(@"注册", @"CJDemoModuleLogin", nil);
    viewController.view.backgroundColor = [UIColor greenColor];
    
    return viewController;
}

///忘记密码页
- (UIViewController *)Action_forgetPasswordViewController:(NSDictionary *)params {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedStringFromTable(@"更改密码", @"CJDemoModuleLogin", nil);
    viewController.view.backgroundColor = [UIColor greenColor];
    
    return viewController;
}

@end
