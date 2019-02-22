//
//  RegisterViewModel.m
//  CJTotalDemo
//
//  Created by ciyouzen on 2017/11/8.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "RegisterViewModel.h"
#import "CJDemoServiceUserManager+Login.h"


@interface RegisterViewModel () {
    
}
@property (nonatomic, assign, readonly) BOOL userNameValid;
@property (nonatomic, assign, readonly) BOOL passwordValid;
@property (nonatomic, assign, readonly) BOOL emailValid;

@end


@implementation RegisterViewModel

#pragma mark - Get Default



#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    [self checkUserNameValid];
}

- (void)updatePassword:(NSString *)password {
    _password = password;
    [self checkPasswordValid];
}

- (void)updateEmail:(NSString *)email {
    _email = email;
    [self checkEmailValid];
}

///检查 userName 有效性
- (void)checkUserNameValid {
    BOOL userNameValid = self.userName.length >= 4;
    _userNameValid = userNameValid;
    
    [self checkRegisterValid];
}

///检查 password 有效性
- (void)checkPasswordValid {
    BOOL passwordValid = self.password.length >= 4;
    _passwordValid = passwordValid;
    
    [self checkRegisterValid];
}

///检查 email 有效性
- (void)checkEmailValid {
    BOOL emailValid = self.email.length >= 4;
    _emailValid = emailValid;
    
    [self checkRegisterValid];
}

///检查 registerButton 有效性
- (void)checkRegisterValid {
    BOOL registerValid = self.userNameValid && self.passwordValid && self.emailValid;
    if (self.registerButtonEnableChangeBlock) {
        self.registerButtonEnableChangeBlock(registerValid);
    }
}


#pragma mark - Do
/// 检查是否可注册
- (NSString *)checkRegisterCondition {
    BOOL registerUserNameEnable = self.userName.length >= 4;
    BOOL registerPasswordEnable = self.password.length >= 4;
    BOOL registerEmailEnable = self.email.length >= 4;
    
    BOOL registerButtonEnable = registerUserNameEnable && registerPasswordEnable && registerEmailEnable;
    if (registerButtonEnable) {
        return NSLocalizedString(@"请完善注册信息", nil);
    }
    return nil;
}

/// 执行注册
//- (void)registerWitSuccess:(void (^)(NSString *successMessage))success failure:(void (^)(NSString *errorMessage))failure
- (void)didRegister
{
    NSString *userName = self.userName;
    NSString *password = self.password;
    NSString *email = self.email;
    [[CJDemoServiceUserManager sharedInstance] registerWithAccount:userName password:password email:email success:^(BOOL registerSuccess, NSString *successMessage) {
        //成功发送成功的信号
        if (self.successBlock) {
            self.successBlock(registerSuccess, successMessage);
        }
        
    } failure:^(BOOL isRequestFailure, NSString *errorMessage) {
        //业务逻辑失败和网络请求失败发送fail或者error信号并传参
        if (self.failureBlock) {
            self.failureBlock(errorMessage);
        }
    }];
}


@end
