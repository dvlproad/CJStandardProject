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
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

@end


@implementation LoginViewModel

//- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password {
//    self = [super init];
//    if (self) {
//        CJAppLastUser *lastUser = [CJAppLastUtil getLastLoginUser];
//        self.userName = lastUser.lastLoginUserName;
//        self.password = @"";
//    }
//    return self;
//}

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
///执行登录
- (void)loginWithTryFailure:(void (^)(NSString *tryFailureMessage))tryFailureBlock
                 loginStart:(void (^)(NSString *startMessage))loginStartBlock
               loginSuccess:(void (^)(NSString *successMessage))loginSuccess
               loginFailure:(void (^)(NSString *errorMessage))loginFailure
{
    NSString *account = self.userName;
    NSString *password = self.password;
    
    NSString *tryFailureMessage = [self checkLoginConditionByAccount:account password:password];
    if (tryFailureMessage && tryFailureBlock) {
        tryFailureBlock(tryFailureMessage);
        return;
    }
    
    NSString *startMessage = NSLocalizedString(@"正在登录", nil);
    if (loginStartBlock) {
        loginStartBlock(startMessage);
    }
    
    [[STDemoServiceUserManager sharedInstance] requestLoginWithAccount:account password:password success:^(STDemoUser *user) {
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
