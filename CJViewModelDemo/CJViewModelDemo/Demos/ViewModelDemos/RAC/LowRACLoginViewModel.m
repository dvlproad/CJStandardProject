//
//  LowRACLoginViewModel.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2017/3/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LowRACLoginViewModel.h"
#import "NSString+STDemoValidate.h"
#import "STDemoServiceUserManager+Network.h"
#import "STDemoServiceUserManager+UserTable.h"

@interface LowRACLoginViewModel () {
    
}
@property (nonatomic, assign, readonly) BOOL userNameValid;
@property (nonatomic, assign, readonly) BOOL passwordValid;
@property (nonatomic, assign, readonly) BOOL loginValid;

//@property (nonatomic, strong) RACSignal *userNameSignal;
//@property (nonatomic, strong) RACSignal *passwordSignal;
//@property (nonatomic, strong) NSArray *requestData;

@end


@implementation LowRACLoginViewModel

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password {
    self = [super init];
    if (self) {
        _userName = userName;
        _password = password;
        
        _userNameValidObject = [RACSubject subject];
        _passwordValidObject = [RACSubject subject];
        _loginValidObject = [RACSubject subject];
        
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
    _userNameValid = [self.userName stdemo_checkUserName];
    _loginValid = self.userNameValid && self.passwordValid;
    
    [self.userNameValidObject sendNext:@(self.userNameValid)];
    [self.loginValidObject sendNext:@(self.loginValid)];
}

- (void)updatePassword:(NSString *)password {
    _password = password;
    _passwordValid = [self.password stdemo_checkPassword];
    _loginValid = self.userNameValid && self.passwordValid;
    
    [self.passwordValidObject sendNext:@(self.passwordValid)];
    [self.loginValidObject sendNext:@(self.loginValid)];
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
