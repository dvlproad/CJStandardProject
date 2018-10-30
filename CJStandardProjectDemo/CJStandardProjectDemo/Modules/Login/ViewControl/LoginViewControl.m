//
//  LoginViewControl.m
//  RACDemo
//
//  Created by ciyouzen on 2017/3/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "LoginViewControl.h"
#import <CJBaseUIKit/CJToast.h>

#import <CJDemoModuleMain/CTMediator+CJDemoModuleMain.h> //需要依赖Main
#ifdef CJTestJustLogin
#import "RegisterViewController.h"
#import "FindPasdViewController.h"
#endif

#import "CJDemoModuleLoginResourceUtil.h"



@interface LoginViewControl () {
    
}


@end



@implementation LoginViewControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Setter
- (void)setUserNameTextField:(CJTextField *)userNameTextField {
    _userNameTextField = userNameTextField;
    
    _userNameTextField.delegate = self;
}

- (void)setPasswordTextField:(CJTextField *)passwordTextField {
    _passwordTextField = passwordTextField;
    
    _passwordTextField.delegate = self;
}

- (void)setLoginButton:(UIButton *)loginButton {
    _loginButton = loginButton;
    
    _loginButton.enabled = NO;
    [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFindPasswordButton:(UIButton *)findPasswordButton {
    _findPasswordButton = findPasswordButton;
    
    [_findPasswordButton addTarget:self action:@selector(findPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setRegisterButton:(UIButton *)registerButton {
    _registerButton = registerButton;
    
    [_registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - ButtonEvent
- (void)loginButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(vm_loginButtonAction)]) {
        [self.delegate vm_loginButtonAction];
    }
}

- (void)findPasswordButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(vm_findPasswordButtonAction)]) {
        [self.delegate vm_findPasswordButtonAction];
    }
}

- (void)registerButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(vm_registerButtonAction)]) {
        [self.delegate vm_registerButtonAction];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //按Return进行换行功能
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
        return NO;
        
    } else if (textField == self.passwordTextField) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(vm_loginButtonAction)]) {
            [self.delegate vm_loginButtonAction];
        }
        return YES;
        
    } else {
        [textField resignFirstResponder];
        return YES;
    }
}

//根据用户名查找用户头像
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == self.userNameTextField) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(vm_userNameTextFieldChange:)]) {
            [self.delegate vm_userNameTextFieldChange:newText];
        }
    } else if (textField == self.passwordTextField) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(vm_passwordTextFieldChange:)]) {
            [self.delegate vm_passwordTextFieldChange:newText];
        }
    }
    
    return YES;
}

#pragma mark - UpdateView
///更新文本框的值
- (void)updateUserNameTextField:(NSString *)userName {
    self.userNameTextField.text = userName;
}

///更新文本框的值
- (void)updatePasswordTextField:(NSString *)password {
    self.passwordTextField.text = password;
}

///更新登录按钮的点击状态
- (void)updateLoginButtonEnable:(BOOL)enable {
    self.loginButton.enabled = enable;
}

///开始视图的editing
- (void)startEndEditing {
    [self.userNameTextField becomeFirstResponder];//弹出键盘应该选择在viewDidAppear的时候
}
///结束视图的editing
- (void)stopEndEditing {
    //[self.view endEditing:YES];
}




///"尝试登录失败(未满足条件)时候"，更新视图
- (void)tryLoginFailureWithMessage:(NSString *)message {
    [CJToast shortShowMessage:message];
}

///"开始登录时候"更新视图(如显示提示信息)
- (void)startLoginWithMessage:(NSString *)message {
    if (_loginStateHUD == nil) {
        _loginStateHUD = [CJToast createChrysanthemumHUDWithMessage:message toView:nil];
    } else {
        _loginStateHUD.label.text = message;
    }
}

///“登录成功进入/回到主页时候"更新视图
- (void)loginSuccessWithMessage:(NSString *)message isBack:(BOOL)isBack {
    [self.loginStateHUD hideAnimated:YES afterDelay:0];
    [CJToast shortShowMessage:message];
    
    if (isBack) {
        [self goMainViewController];    //“登录成功进入主页时候"更新视图
    } else {
        [self backMainViewController];  //"登录成功回到主页时候"更新视图
    }
}

///"登录失败时候"更新视图
- (void)loginFailureWithMessage:(NSString *)message {
    self.loginStateHUD.label.text = message;
    self.loginStateHUD.mode = MBProgressHUDModeText;
    [self.loginStateHUD hideAnimated:YES afterDelay:1];
}


#pragma mark - 界面跳转
///进入主页(非游客模式，或游客模式下用户未使用游客分身进入主页)
- (void)goMainViewController {
    NSDictionary *params = nil;
    UIViewController *mainViewControllerWithParams = [[CTMediator sharedInstance] cjDemo_mainViewControllerWithParams:params];
    [UIApplication sharedApplication].delegate.window.rootViewController = mainViewControllerWithParams;
}

///回到主页(游客模式下，用户已使用游客分身进入主页，则当其在点击需要登录的功能后，会进入登录，并在登录成功后回到首页)
- (void)backMainViewController {
    //[self.belongViewController.navigationController popViewControllerAnimated:YES];
}

///进入"忘记密码"界面
- (void)goFindPasswordViewController {
#ifdef CJTestJustLogin
    FindPasdViewController *viewController = [[FindPasdViewController alloc] initWithNibName:@"FindPasdViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
#else
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedString(@"忘记密码", nil);
    viewController.view.backgroundColor = [UIColor whiteColor];
    //[self.belongViewController.navigationController pushViewController:viewController animated:YES];
#endif
}

///进入"注册"界面
- (void)goRegisterViewController {
#ifdef CJTestJustLogin
    RegisterViewController *viewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
#else
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedString(@"注册", nil);
    viewController.view.backgroundColor = [UIColor whiteColor];
    //[self.belongViewController.navigationController pushViewController:viewController animated:YES];
#endif
}


@end
