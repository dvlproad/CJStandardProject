//
//  KVOLoginViewController.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "KVOLoginViewController.h"
#import "KVOLoginViewModel.h"
//#import "CTMediator+STDemoLogin.h"
#import <KVOController/KVOController.h>

@interface KVOLoginViewController () {
    
}
@property (nonatomic, strong) KVOLoginViewModel *viewModel;
@property (nonatomic, strong) FBKVOController *kvoController;

@end

@implementation KVOLoginViewController

- (FBKVOController *)kvoController {
    if (_kvoController == nil) {
        _kvoController = [FBKVOController controllerWithObserver:self];
    }
    return _kvoController;
}

- (void)bindViewModel {
    NSString *userName = [CJAppLastUtil getLastLoginUser].lastLoginUserName;
    NSString *password = @"";
    KVOLoginViewModel *viewModel = [[KVOLoginViewModel alloc] initWithUserName:userName password:password];
    
    [self.kvoController observe:viewModel keyPath:@"userNameValid" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSString *oldValue = change[NSKeyValueChangeOldKey];
        NSString *newValue = change[NSKeyValueChangeNewKey];
        NSLog(@"userNameValid旧值是:%@", oldValue);
        NSLog(@"userNameValid新值是:%@", newValue);
        
        BOOL userNameValid = [change[NSKeyValueChangeNewKey] boolValue];
        self.userNameTextField.leftButtonSelected = userNameValid;
    }];
    
    [self.kvoController observe:viewModel keyPath:@"passwordValid" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSString *oldValue = change[NSKeyValueChangeOldKey];
        NSString *newValue = change[NSKeyValueChangeNewKey];
        NSLog(@"passwordValid旧值是:%@", oldValue);
        NSLog(@"passwordValid新值是:%@", newValue);
        
        BOOL passwordValid = [change[NSKeyValueChangeNewKey] boolValue];
        self.passwordTextField.leftButtonSelected = passwordValid;
    }];
    
    [self.kvoController observe:viewModel keyPath:@"loginValid" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSString *oldValue = change[NSKeyValueChangeOldKey];
        NSString *newValue = change[NSKeyValueChangeNewKey];
        NSLog(@"loginValid旧值是:%@", oldValue);
        NSLog(@"loginValid新值是:%@", newValue);
        
        
        BOOL loginVaild = [change[NSKeyValueChangeNewKey] boolValue];
        self.loginButton.enabled = loginVaild;
    }];
    
    /*
    [self.kvoController observe:self.viewModel keyPaths:@[@"userName", @"password"] options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSString *changedKeyPath = change[FBKVONotificationKeyPathKey];
        
        if ([changedKeyPath isEqualToString:@"userName"]) {
            NSLog(@"修改了名字");
            NSString *oldValue = change[NSKeyValueChangeOldKey];
            NSString *newValue = change[NSKeyValueChangeNewKey];
            NSLog(@"旧值是:%@", oldValue);
            NSLog(@"新值是:%@", newValue);
            
        } else if ([changedKeyPath isEqualToString:@"password"]) {
            NSLog(@"修改了密码");
            NSString *oldValue = change[NSKeyValueChangeOldKey];
            NSString *newValue = change[NSKeyValueChangeNewKey];
            NSLog(@"旧值是:%@", oldValue);
            NSLog(@"新值是:%@", newValue);
        }
    }];
    */
    
    self.viewModel = viewModel;
}

- (void)showDefaultData {
    //显示上次登录的账号
    self.userNameTextField.text = self.viewModel.userName;
    self.passwordTextField.text = self.viewModel.password;
}

- (void)userNameTextFieldUpdateToText:(NSString *)userName {
    [self.viewModel updateUserName:userName];
}

- (void)passwordTextFieldUpdateToText:(NSString *)password {
    [self.viewModel updatePassword:password];
}

#pragma mark - ButtonEvent
- (void)findPasswordButtonAction {
//    [self.viewControl goFindPasswordViewController];
//    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_STDemo_forgetPasswordViewController];
//    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)registerButtonAction {
//    [self.viewControl goRegisterViewController];
//    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_STDemo_registerViewController];
//    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)loginButtonAction {
    //结束视图的editing
    [self.view endEditing:YES];
    
//    [self.viewModel loginWithTryFailure:^(NSString *tryFailureMessage) {
//        //"尝试登录失败(未满足条件)时候"，更新视图
//        [CJToast shortShowMessage:tryFailureMessage];
//        
//    } loginStart:^(NSString *startMessage) {
//        //开始登录时候更新视图显示提示信息
//        if (self.loginStateHUD == nil) {
//            self.loginStateHUD = [CJToast createChrysanthemumHUDWithMessage:startMessage toView:nil];
//        } else {
//            self.loginStateHUD.label.text = startMessage;
//        }
//        
//    } loginSuccess:^(NSString *successMessage) {
//        //登录成功需要进入/回到主页
//        [self.loginStateHUD hideAnimated:YES afterDelay:0];
//        [CJToast shortShowMessage:successMessage];
//        
//    } loginFailure:^(NSString *errorMessage) {
//        //登录失败更新视图显示提示信息
//        self.loginStateHUD.label.text = errorMessage;
//        self.loginStateHUD.mode = MBProgressHUDModeText;
//        [self.loginStateHUD hideAnimated:YES afterDelay:1];
//    }];
}




#pragma mark - RACLoginViewModelDelegate
///登录按钮的enable发生变化需要更新按钮显示
- (void)vm_checkLoginWithValid:(BOOL)enable {
    self.loginButton.enabled = enable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
