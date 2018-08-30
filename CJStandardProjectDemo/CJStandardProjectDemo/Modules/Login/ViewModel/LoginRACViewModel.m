//
//  LoginRACViewModel.m
//  RACDemo
//
//  Created by ciyouzen on 2017/3/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LoginRACViewModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <CJDemoModel/DemoNetworkClient+Login.h>

@interface LoginRACViewModel ()

@property (nonatomic, strong) RACSignal *userNameSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) NSArray *requestData;

@end



@implementation LoginRACViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _userNameSignal = RACObserve(self, userName);
    _passwordSignal = RACObserve(self, password);
    _successObject = [RACSubject subject];
    _failureObject = [RACSubject subject];
    _errorObject = [RACSubject subject];
}

//合并两个输入框信号，并返回按钮bool类型的值
- (id)loginButtonIsValid {
    RACSignal *isValid = [RACSignal combineLatest:@[_userNameSignal, _passwordSignal] reduce:^id(NSString *userName, NSString *password){
        return @(userName.length >= 4 && password.length >= 4);
    }];
    
    return isValid;
}

- (void)loginFromViewController:(UIViewController *)viewController {
    [viewController.view endEditing:YES];
    /*
    [SVProgressHUD showWithStatus:NSLocalizedString(@"正在登录", nil) maskType:SVProgressHUDMaskTypeBlack];
    
    NSString *name = self.nameTextField.text;
    NSString *pasd = self.pasdTextField.text;
    [[HealthyNetworkClient sharedInstance] requestLogin_name:name pasd:pasd success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"登录成功", nil)];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"登录失败", nil)];
    }];
    */
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"正在登录", nil)];
    
    NSString *name = self.userName;
    NSString *pasd = self.password;
    [[DemoNetworkClient sharedInstance] requestLoginWithAccount:name password:pasd success:^(id responseObject) {
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"登录成功", nil)];
        
        //成功发送成功的信号
        [_successObject sendNext:responseObject];
        //[self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"登录失败", nil)];
        
        //业务逻辑失败和网络请求失败发送fail或者error信号并传参
        [self.failureObject sendNext:error];
    }];
}


@end
