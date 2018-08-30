//
//  LoginViewModel.m
//  RACDemo
//
//  Created by ciyouzen on 2017/3/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LoginViewModel.h"
#import <CJBaseUIKit/CJToast.h>
#import <CJDemoModel/DemoNetworkClient+Login.h>

@interface LoginViewModel ()

@end



@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
}

- (void)userNameChangeEvent:(NSString *)userName {
    self.userName = userName;
    
    [self updateLoginButtonEnable];
}

- (void)passwordChangeEvent:(NSString *)password {
    self.password = password;
    
    [self updateLoginButtonEnable];
}

- (void)updateLoginButtonEnable {
    BOOL loginUserNameEnable = self.userName.length >= 4;
    BOOL loginPasswordEnable = self.password.length >= 4;
    
    BOOL loginButtonEnable = loginUserNameEnable && loginPasswordEnable;
    //NSLog(@"loginButtonEnable = %@, %@, %@", loginButtonEnable ? @"YES" : @"NO", self.userName, self.password);
    
    _loginButtonEnable = loginButtonEnable;
    if (self.loginButtonEnableChangeBlock) {
        self.loginButtonEnableChangeBlock(loginButtonEnable);
    }
}


- (BOOL)checkLoginCondition {
    if (!self.loginButtonEnable) {
        [CJToast shortShowMessage:NSLocalizedString(@"请完善登录信息", nil)];
        return NO;
    }
    
    return YES;
}

- (void)loginFromViewController:(UIViewController *)viewController {
    if (![self checkLoginCondition]) {
        return;
    }
    
    [viewController.view endEditing:YES];

    
    NSString *loginingText = NSLocalizedString(@"正在登录", nil);
    MBProgressHUD *loginStateHUD = [CJToast createChrysanthemumHUDWithMessage:loginingText toView:nil];
    
    NSString *name = self.userName;
    NSString *pasd = self.password;
    [[DemoNetworkClient sharedInstance] requestLoginWithAccount:name password:pasd success:^(id responseObject) {
        [loginStateHUD hideAnimated:YES afterDelay:0];
        
        //成功发送成功的信号
        if (self.successBlock) {
            self.successBlock(responseObject);
        }
        
    } failure:^(NSError * _Nonnull error) {
        //NSString *loginFailureMessage = NSLocalizedString(@"登录失败", nil);
        NSString *loginFailureMessage = [NSString stringWithFormat:@"密码错误:试下通用密码%@", DemoGeneralPassword];
        loginStateHUD.label.text = loginFailureMessage;
        loginStateHUD.mode = MBProgressHUDModeText;
        [loginStateHUD hideAnimated:YES afterDelay:1];
        
        //业务逻辑失败和网络请求失败发送fail或者error信号并传参
        if (self.failureBlock) {
            self.failureBlock(error);
        }
    }];
}

@end
