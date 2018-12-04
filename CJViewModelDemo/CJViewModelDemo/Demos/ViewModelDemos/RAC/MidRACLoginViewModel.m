//
//  MidRACLoginViewModel.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2017/3/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "MidRACLoginViewModel.h"
#import "NSString+STDemoValidate.h"
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"

@interface MidRACLoginViewModel () {
    
}

@end


@implementation MidRACLoginViewModel

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password {
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
        
//        _userNameValidObject = [RACSubject subject];
//        _passwordValidObject = [RACSubject subject];
//        _loginValidObject = [RACSubject subject];
        
        _tryFailureObject = [RACSubject subject];
        _startObject = [RACSubject subject];
        _successObject = [RACSubject subject];
        _failureObject = [RACSubject subject];
        //_errorObject = [RACSubject subject];
    }
    return self;
}

#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    
    //必须用self.xxx = value; 否则因为无法执行setter，而无法成功监听属性；
    self.userNameValid = [self.userName stdemo_checkUserName];
    self.loginValid = self.userNameValid && self.passwordValid;
    
//    [self.userNameValidObject sendNext:@(self.userNameValid)];
//    [self.loginValidObject sendNext:@(self.loginValid)];
}

- (void)updatePassword:(NSString *)password {
    _password = password;
    
    //必须用self.xxx = value; 否则因为无法执行setter，而无法成功监听属性；
    self.passwordValid = [self.password stdemo_checkPassword];
    self.loginValid = self.userNameValid && self.passwordValid;
    
//    [self.passwordValidObject sendNext:@(self.passwordValid)];
//    [self.loginValidObject sendNext:@(self.loginValid)];
}

#pragma mark - Do
- (void)login
{
    if (!self.loginValid) {
        NSString *tryFailureMessage = NSLocalizedString(@"请完善登录信息", nil);
        [self.tryFailureObject sendNext:tryFailureMessage];
        
        return;
    }
    
    NSString *startMessage = NSLocalizedString(@"正在登录", nil);
    [self.startObject sendNext:startMessage];
    
    NSString *account = self.userName;
    NSString *password = self.password;
    [[STDemoServiceUserManager sharedInstance] requestLoginWithAccount:account password:password success:^(STDemoUser *user) {
        NSString *loginSuccessMessage = NSLocalizedString(@"登录成功", nil);
        //成功发送成功的信号
        [self.successObject sendNext:loginSuccessMessage];
        
    } failure:^(NSString *errorMessage) {
        [self.failureObject sendNext:errorMessage];
    }];
}


@end
