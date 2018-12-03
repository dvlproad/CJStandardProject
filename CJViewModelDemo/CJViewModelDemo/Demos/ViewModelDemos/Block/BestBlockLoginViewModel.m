//
//  BestBlockLoginViewModel.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "BestBlockLoginViewModel.h"
#import "NSString+STDemoValidate.h"
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"

@interface BestBlockLoginViewModel () {
    
}
@property (nonatomic, assign, readonly) BOOL userNameValid;
@property (nonatomic, assign, readonly) BOOL passwordValid;
@property (nonatomic, assign, readonly) BOOL loginValid;

@property (nonatomic, copy) void (^updateUserNameCompleteBlock)(BOOL userNameValid, BOOL loginValid);
@property (nonatomic, copy) void (^updatePasswordCompleteBlock)(BOOL passwordValid, BOOL loginValid);
@property (nonatomic, copy) void (^tryFailureBlock)(NSString *tryFailureMessage);
@property (nonatomic, copy) void (^loginStartBlock)(NSString *startMessage);
@property (nonatomic, copy) void (^loginSuccess)(NSString *successMessage);
@property (nonatomic, copy) void (^loginFailure)(NSString *errorMessage);

@end


@implementation BestBlockLoginViewModel

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password {
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
    }
    return self;
}


#pragma mark - Update
- (void)setupUpdateUserNameCompleteBlock:(void (^)(BOOL userNameValid, BOOL loginValid))updateUserNameCompleteBlock
             updatePasswordCompleteBlock:(void (^)(BOOL passwordValid, BOOL loginValid))updatePasswordCompleteBlock
{
    self.updateUserNameCompleteBlock = updateUserNameCompleteBlock;
    self.updatePasswordCompleteBlock = updatePasswordCompleteBlock;
}

- (void)updateUserName:(NSString *)userName
{
    _userName = userName;
    _userNameValid = [self.userName stdemo_checkUserName];
    _loginValid = self.userNameValid && self.passwordValid;
    
    if (self.updateUserNameCompleteBlock) {
        self.updateUserNameCompleteBlock(self.userNameValid, self.loginValid);
    }
}

- (void)updatePassword:(NSString *)password
{
    _password = password;
    _passwordValid = [self.password stdemo_checkPassword];
    _loginValid = self.userNameValid && self.passwordValid;
    
    if (self.updatePasswordCompleteBlock) {
        self.updatePasswordCompleteBlock(self.passwordValid, self.loginValid);
    }
}

#pragma mark - Do
/// 执行登录
- (void)setupTryFailure:(void (^)(NSString *tryFailureMessage))tryFailureBlock
             loginStart:(void (^)(NSString *startMessage))loginStartBlock
           loginSuccess:(void (^)(NSString *successMessage))loginSuccess
           loginFailure:(void (^)(NSString *errorMessage))loginFailure
{
    self.tryFailureBlock = tryFailureBlock;
    self.loginStartBlock = loginStartBlock;
    self.loginSuccess = loginSuccess;
    self.loginFailure = loginFailure;
}

- (void)login
{
    if (!self.loginValid) {
        NSString *tryFailureMessage = NSLocalizedString(@"请完善登录信息", nil);
        if (self.tryFailureBlock) {
            self.tryFailureBlock(tryFailureMessage);
        }
        return;
    }
    
    NSString *startMessage = NSLocalizedString(@"正在登录", nil);
    if (self.loginStartBlock) {
        self.loginStartBlock(startMessage);
    }
    
    NSString *account = self.userName;
    NSString *password = self.password;
    [[STDemoServiceUserManager sharedInstance] requestLoginWithAccount:account password:password success:^(STDemoUser *user) {
        NSString *successMessage = NSLocalizedString(@"登录成功", nil);
        if (self.loginSuccess) {
            self.loginSuccess(successMessage);
        }
    } failure:^(NSString *errorMessage) {
        if (self.loginFailure) {
            self.loginFailure(errorMessage);
        }
    }];
}



@end
