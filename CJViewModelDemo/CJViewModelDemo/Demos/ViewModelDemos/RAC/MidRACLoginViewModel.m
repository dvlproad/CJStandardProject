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
        
//        _userNameValidSignal = RACObserve(self, userNameValid);
//        _passwordValidSignal = RACObserve(self, passwordValid);
//        _loginValidSignal = [RACSignal combineLatest:@[self.userNameValidSignal, self.passwordValidSignal] reduce:^id(id nUserNameValid, id nPasswordValid){
//            return @([nUserNameValid boolValue] && [nPasswordValid boolValue]);
//        }];//合并两个输入框信号，并返回按钮bool类型的值
        
//        _userNameValidSignal = RACObserve(self, userName);
//        _passwordValidSignal = RACObserve(self, password);
//        _loginValidSignal = [RACSignal combineLatest:@[_userNameValidSignal, _passwordValidSignal] reduce:^id(NSString *userName, NSString *password){
//            return @([userName stdemo_checkUserName] && [password stdemo_checkPassword]);
//        }];//合并两个输入框信号，并返回按钮bool类型的值
        
        _tryFailureObject = [RACSubject subject];
        _startObject = [RACSubject subject];
        _successObject = [RACSubject subject];
        _failureObject = [RACSubject subject];
        //_errorObject = [RACSubject subject];
    }
    return self;
}

//- (RACSignal *)loginValidSignal {
//    return [RACObserve(self, userName) map:^id _Nullable(NSString  * _Nullable value) {
//        return @(value.length > 2);
//    }];
//
//    return RACObserve(self, userNameValid);
//    return [RACSignal
//            combineLatest:@[RACObserve(self, userNameValid), RACObserve(self, passwordValidSignal)]
//            reduce:^id(id nUserNameValid, id nPasswordValid){
//                return @([nUserNameValid boolValue] && [nPasswordValid boolValue]);
//            }];
//    return [RACSignal
//            combineLatest:@[RACObserve(self, userName), RACObserve(self, password)]
//            reduce:^id(NSString *userName, NSString *password){
//                return @([userName stdemo_checkUserName] && [password stdemo_checkPassword]);
//            }];
//}

#pragma mark - Update
- (void)updateUserName:(NSString *)userName {
    _userName = userName;
    self.userNameValid = [self.userName stdemo_checkUserName];
    self.loginValid = self.userNameValid && self.passwordValid;
    
//    [self.userNameValidObject sendNext:@(self.userNameValid)];
//    [self.loginValidObject sendNext:@(self.loginValid)];
}

- (void)updatePassword:(NSString *)password {
    _password = password;
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
