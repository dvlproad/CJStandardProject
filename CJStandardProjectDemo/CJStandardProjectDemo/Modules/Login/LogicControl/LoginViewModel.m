//
//  LoginViewModel.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LoginViewModel.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"

@interface LoginViewModel () {
    
}

@end


@implementation LoginViewModel

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password {
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _userName = [self getDefaultLoginAccount];
        _password = [self getDefaultPasswordForUserName:_userName];
    }
    return self;
}

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
    if (self.delegate && [self.delegate respondsToSelector:@selector(view_loginButtonEnableChange:)]) {
        [self.delegate view_loginButtonEnableChange:allowClickLoginButton];
    }
}

#pragma mark - Do
/// 检查是否可登录
- (NSString *)checkLoginCondition {
    NSString *account = self.userName;
    NSString *password = self.password;
    
    BOOL loginUserNameEnable = account.length >= 4;
    BOOL loginPasswordEnable = password.length >= 4;
    
    BOOL loginButtonEnable = loginUserNameEnable && loginPasswordEnable;
    if (!loginButtonEnable) {
        return NSLocalizedString(@"请完善登录信息", nil);
    }
    
    return nil;
}
/// 执行登录
- (void)loginWitLoginSuccess:(void (^)(NSString *successMessage))loginSuccess
                loginFailure:(void (^)(NSString *errorMessage))loginFailure
{
    NSString *userName = self.userName;
    NSString *password = self.password;
    
    [[STDemoServiceUserManager sharedInstance] requestLoginWithAccount:userName password:password success:^(STDemoUser *user) {
        NSString *successMessage = NSLocalizedString(@"登录成功", nil);
        if (loginSuccess) {
            loginSuccess(successMessage);
        }
    } failure:^(NSString *errorMessage) {
        if (loginFailure) {
            loginFailure(errorMessage);
        }
    }];
}



@end
