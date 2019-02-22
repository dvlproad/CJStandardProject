//
//  LoginViewModel.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LoginViewModel.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import "CJDemoServiceUserManager+Login.h"

@interface LoginViewModel () {
    
}
@property (nonatomic, assign, readonly) BOOL userNameValid;
@property (nonatomic, assign, readonly) BOOL passwordValid;

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

- (void)setDelegate:(id<LoginViewModelDelegate>)delegate {
    _delegate = delegate;
    
    [self checkUserNameValid];
    [self checkPasswordValid];
}

#pragma mark - Get Default
- (NSString *)getDefaultLoginAccount {
    CJAppLastUser *lastUser = [CJAppLastUtil getLastLoginUser];
    NSString *account = lastUser.lastLoginUserName;
    return account;
}

- (NSString *)getDefaultPasswordForUserName:(NSString *)userName {
    return @"";
}




#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    [self checkUserNameValid];
}

- (void)updatePassword:(NSString *)password {
    _password = password;
    [self checkPasswordValid];
}

///检查 userName 有效性
- (void)checkUserNameValid {
    BOOL userNameValid = self.userName.length >= 4;
    _userNameValid = userNameValid;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_checkUserNameWithValid:)]) {
        [self.delegate logic_checkUserNameWithValid:userNameValid];
    }
    
    [self checkLoginValid];
}

///检查 password 有效性
- (void)checkPasswordValid {
    BOOL passwordValid = self.password.length >= 4;
    _passwordValid = passwordValid;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_checkPasswordWithValid:)]) {
        [self.delegate logic_checkPasswordWithValid:passwordValid];
    }
    
    [self checkLoginValid];
}

///检查 loginButton 有效性
- (void)checkLoginValid {
    BOOL loginValid = self.userNameValid && self.passwordValid;
    if (self.delegate && [self.delegate respondsToSelector:@selector(logic_checkLoginWithValid:)]) {
        [self.delegate logic_checkLoginWithValid:loginValid];
    }
}

#pragma mark - Do
/// 检查是否可登录
- (NSString *)checkLoginCondition {
    BOOL loginUserNameEnable = self.userName.length >= 4;
    BOOL loginPasswordEnable = self.password.length >= 4;
    
    BOOL loginButtonEnable = loginUserNameEnable && loginPasswordEnable;
    if (!loginButtonEnable) {
        return NSLocalizedString(@"请完善登录信息", nil);
    }
    
    return nil;
}

/// 执行登录
- (void)loginWitLoginSuccess:(void (^)(NSString *successMessage, DemoUser *user))loginSuccess
                loginFailure:(void (^)(NSString *errorMessage))loginFailure
{
    NSString *userName = self.userName;
    NSString *password = self.password;
    
    [[CJDemoServiceUserManager sharedInstance] loginWithUserName:userName password:password success:^(DemoUser *user) {
        NSString *successMessage = NSLocalizedString(@"登录成功", nil);
        if (loginSuccess) {
            loginSuccess(successMessage, user);
        }
        
    } failure:^(BOOL isRequestFailure, NSString *errorMessage) {
        errorMessage = [NSString stringWithFormat:@"密码错误:试下通用密码%@", DemoGeneralPassword];
        if (loginFailure) {
            loginFailure(errorMessage);
        }
    }];
}

@end
