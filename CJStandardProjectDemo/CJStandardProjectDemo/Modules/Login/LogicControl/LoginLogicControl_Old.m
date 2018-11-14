//
//  LoginLogicControl_Old.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LoginLogicControl_Old.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"

@interface LoginLogicControl_Old () {
    
}
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *password;

@end


@implementation LoginLogicControl_Old

#pragma mark - Get Default
- (NSString *)getDefaultLoginAccount {
    CJAppLastUser *lastUser = [CJAppLastUtil getLastLoginUser];
    return lastUser.lastLoginUserName;
}

- (NSString *)getDefaultPasswordForUserName:(NSString *)userName {
    return @"";
}




#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    [self checkAllowClickLoginButton];
}

- (void)updatePassword:(NSString *)password {
    _password = password;
    [self checkAllowClickLoginButton];
}

///检查是否允许点击登录按钮
- (void)checkAllowClickLoginButton {
    BOOL loginUserNameEnable = self.userName.length >= 4;
    BOOL loginPasswordEnable = self.password.length >= 4;

    BOOL allowClickLoginButton = loginUserNameEnable && loginPasswordEnable;
    //NSLog(@"allowClickLoginButton = %@, %@, %@", allowClickLoginButton ? @"YES" : @"NO", self.userName, self.password);
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_loginButtonEnableChange:)]) {
        [self.delegate logic_loginButtonEnableChange:allowClickLoginButton];
    }
}

#pragma mark - Do
///**
// *  登录并进入首页(有主页登录、个人中心登录等,包含是否允许进行登录，登陆成功后进入什么页面等逻辑处理)
// *
// *  @param account                          用户信息--用户名
// *  @param password                         用户信息--用户密码
// *  @param goMainViewController             进入主页
// *  @param backMainViewController           回到主页(游客模式下会有该功能)
// */
//- (void)loginWithAccount:(NSString *)account
//                password:(NSString *)password
//    goMainViewController:(void (^)(void))goMainViewController
//  backMainViewController:(void (^)(void))backMainViewController
///执行登录
- (void)login
{
    NSString *account = self.userName;
    NSString *password = self.password;
    
    NSString *failureMessage = [self checkLoginConditionByAccount:account password:password];
    if (failureMessage) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_tryLoginFailureWithMessage:)]) {
            [self.delegate logic_tryLoginFailureWithMessage:failureMessage];
        }
        
        return;
    }
    
    NSString *loginingText = NSLocalizedString(@"正在登录", nil);
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_startLoginWithMessage:)]) {
        [self.delegate logic_startLoginWithMessage:loginingText];
    }
    
    [[STDemoServiceUserManager sharedInstance] requestLoginWithAccount:account password:password success:^(STDemoUser *user) {
        NSString *loginSuccessMessage = NSLocalizedString(@"登录成功", nil);
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_loginSuccessWithMessage:)]) {
            [self.delegate logic_loginSuccessWithMessage:loginSuccessMessage];
        }
        
    } failure:^(NSString *errorMessage) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(logic_loginFailureWithMessage:)]) {
            [self.delegate logic_loginFailureWithMessage:errorMessage];
        }
    }];
}

- (NSString *)checkLoginConditionByAccount:(NSString *)account
                                  password:(NSString *)password {
    BOOL loginUserNameEnable = account.length >= 4;
    BOOL loginPasswordEnable = password.length >= 4;
    
    BOOL loginButtonEnable = loginUserNameEnable && loginPasswordEnable;
    if (!loginButtonEnable) {
        return NSLocalizedString(@"请完善登录信息", nil);
    }
    
    return nil;
}



@end
