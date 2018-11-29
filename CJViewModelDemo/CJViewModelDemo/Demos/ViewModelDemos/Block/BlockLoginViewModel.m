//
//  BlockLoginViewModel.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "BlockLoginViewModel.h"
#import "NSString+STDemoValidate.h"
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"

@interface BlockLoginViewModel () {
    
}
@property (nonatomic, assign, readonly) BOOL userNameValid;
@property (nonatomic, assign, readonly) BOOL passwordValid;
@property (nonatomic, assign, readonly) BOOL loginValid;

@end


@implementation BlockLoginViewModel

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password {
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
    }
    return self;
}


#pragma mark - Update
- (void)updateUserName:(NSString *)userName withCompleteBlock:(void (^)(BOOL userNameValid, BOOL loginValid))completeBlock
{
    _userName = userName;
    _userNameValid = [self.userName stdemo_checkUserName];
    _loginValid = self.userNameValid && self.passwordValid;
    
    if (completeBlock) {
        completeBlock(self.userNameValid, self.loginValid);
    }
}

- (void)updatePassword:(NSString *)password withCompleteBlock:(void (^)(BOOL passwordValid, BOOL loginValid))completeBlock
{
    _password = password;
    _passwordValid = [self.password stdemo_checkPassword];
    _loginValid = self.userNameValid && self.passwordValid;
    
    if (completeBlock) {
        completeBlock(self.passwordValid, self.loginValid);
    }
}


/// 执行登录
- (void)loginWithTryFailure:(void (^)(NSString *tryFailureMessage))tryFailureBlock
                 loginStart:(void (^)(NSString *startMessage))loginStartBlock
               loginSuccess:(void (^)(NSString *successMessage))loginSuccess
               loginFailure:(void (^)(NSString *errorMessage))loginFailure
{
    if (!self.loginValid) {
        NSString *tryFailureMessage = NSLocalizedString(@"请完善登录信息", nil);
        if (tryFailureBlock) {
            tryFailureBlock(tryFailureMessage);
        }
        return;
    }
    
    NSString *startMessage = NSLocalizedString(@"正在登录", nil);
    if (loginStartBlock) {
        loginStartBlock(startMessage);
    }
    
    NSString *account = self.userName;
    NSString *password = self.password;
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



@end
