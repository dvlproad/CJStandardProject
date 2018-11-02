//
//  Target_STDemoLoginVCFactory.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明

#import "Target_STDemoLoginVCFactory.h"
#import "LMLoginViewController.h"
#import "FindPasswordViewController.h"
#import "ChangePasswordViewController.h"

@implementation Target_STDemoLoginVCFactory

///登录页
- (UIViewController *)Action_STDemo_loginViewController {
    LMLoginViewController *viewController = [[LMLoginViewController alloc] init];
    STDemoNavigationController *navigationController = [[STDemoNavigationController alloc] initWithRootViewController:viewController];
    return navigationController;
}

///忘记密码页
- (UIViewController *)Action_STDemo_forgetPasswordViewController {
    FindPasswordViewController *viewController = [[FindPasswordViewController alloc] init];
    return viewController;
}

///修改密码页(初始密码时候需要)
- (UIViewController *)Action_STDemo_changePasswordViewController {
    ChangePasswordViewController *viewController = [[ChangePasswordViewController alloc] init];
    return viewController;
}

///注册页
- (UIViewController *)Action_STDemo_registerViewController {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedString(@"注册", nil);
    viewController.view.backgroundColor = [UIColor whiteColor];
    
    return viewController;
}

@end
