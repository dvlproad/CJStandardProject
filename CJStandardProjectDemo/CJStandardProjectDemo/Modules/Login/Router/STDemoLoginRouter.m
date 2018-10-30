//
//  STDemoLoginRouter.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "STDemoLoginRouter.h"
#import "STDemoLoginVCFactory.h"
#import "STDemoMainVCFactory.h"


@implementation STDemoLoginRouter

#pragma mark - 界面跳转
///进入主页
+ (void)goMainViewController {
    UIViewController *mainViewController = [STDemoMainVCFactory mainRootViewController];
    [UIApplication sharedApplication].delegate.window.rootViewController = mainViewController;
}

///进入"忘记密码"界面
+ (void)goFindPasswordViewControllerFrom:(UIViewController *)fromViewController {
    UIViewController *viewController = [STDemoLoginVCFactory forgetPasswordViewController];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}

///进入"修改密码"界面(初始密码时候需要)
+ (void)goChangePasswordViewControllerFrom:(UIViewController *)fromViewController {
    UIViewController *viewController = [STDemoLoginVCFactory changePasswordViewController];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}

///进入"注册"界面
+ (void)goRegisterViewControllerFrom:(UIViewController *)fromViewController {
    UIViewController *viewController = [STDemoLoginVCFactory registerViewController];
    [fromViewController.navigationController pushViewController:viewController animated:YES];
}


@end
