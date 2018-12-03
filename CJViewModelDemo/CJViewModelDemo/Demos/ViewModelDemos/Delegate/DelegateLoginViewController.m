//
//  DelegateLoginViewController.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "DelegateLoginViewController.h"
#import "DelegateLoginViewModel.h"
//#import "CTMediator+STDemoLogin.h"

@interface DelegateLoginViewController () <DelegateLoginViewModelDelegate> {
    
}
@property (nonatomic, strong) DelegateLoginViewModel *viewModel;

@end

@implementation DelegateLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Delegate ViewModel", nil);
}

- (void)bindViewModel {
    NSString *userName = [CJAppLastUtil getLastLoginUser].lastLoginUserName;
    NSString *password = @"";
    DelegateLoginViewModel *viewModel = [[DelegateLoginViewModel alloc] initWithUserName:userName password:password];
    viewModel.delegate = self;
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
}

#pragma mark - DelegateLoginViewModelDelegate
/// userName 的有效性发生变化
- (void)vm_checkUserNameWithValid:(BOOL)valid {
    self.userNameTextField.leftButtonSelected = valid;
}

/// password 的有效性发生变化
- (void)vm_checkPasswordWithValid:(BOOL)valid {
    self.passwordTextField.leftButtonSelected = valid;
}

/// 登录按钮 的有效性发生变化
- (void)vm_checkLoginWithValid:(BOOL)valid {
    self.loginButton.enabled = valid;
}

/// "尝试登录失败(未满足条件)时候"，更新视图
- (void)vm_tryLoginFailureWithMessage:(NSString *)message {
    [CJToast shortShowMessage:message];
}

/// 开始登录时候更新视图显示提示信息
- (void)vm_startLoginWithMessage:(NSString *)message {
    if (self.loginStateHUD == nil) {
        self.loginStateHUD = [CJToast createChrysanthemumHUDWithMessage:message toView:nil];
    } else {
        self.loginStateHUD.label.text = message;
    }
}

/// 登录失败更新视图显示提示信息
- (void)vm_loginFailureWithMessage:(NSString *)message {
    self.loginStateHUD.label.text = message;
    self.loginStateHUD.mode = MBProgressHUDModeText;
    [self.loginStateHUD hideAnimated:YES afterDelay:1];
}


/// 登录成功需要进入/回到主页
- (void)vm_loginSuccessWithMessage:(NSString *)message {
    [self.loginStateHUD hideAnimated:YES afterDelay:0];
    [CJToast shortShowMessage:message];
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
