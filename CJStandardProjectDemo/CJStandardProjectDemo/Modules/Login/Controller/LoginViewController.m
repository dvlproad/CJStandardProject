//
//  LoginViewController.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "LoginViewController.h"
#import <CJDemoCommon/DemoToast.h>
#import <CJDemoCommon/DemoProgressHUD.h>
#import <CJDemoCommon/DemoTextFieldFactory.h>
#import <CJDemoCommon/DemoButtonFactory.h>
#import <CJBaseUIKit/UINavigationBar+CJChangeBG.h>
#import "LoginViewModel.h"
#import "LoginRouter.h"

@interface LoginViewController () <UITextFieldDelegate, LoginViewModelDelegate> {
    
}
@property (nonatomic, strong) LoginViewModel *loginViewModel;

@end

@implementation LoginViewController

#pragma mark - LifeCycle
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar cj_resetBackgroundColor];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    //显示上次登录的账号
//    NSString *userName = [self.logicControl getDefaultLoginAccount];
//    NSString *password = [self.logicControl getDefaultPasswordForUserName:userName];
//    [self.viewModel updateUserNameTextField:userName];
//    [self.viewModel updatePasswordTextField:password];
//    [self.logicControl updateUserName:userName];
//    [self.logicControl updatePassword:password];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar cj_hideUnderline:YES];
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.title = @"";
    
    //显示上次登录的账号
    self.userNameTextField.text = self.loginViewModel.userName;
    self.passwordTextField.text = self.loginViewModel.password;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.userNameTextField becomeFirstResponder];//弹出键盘应该选择在viewDidAppear的时候
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"登录", nil);
    
    [self setupViews];
    
    LoginViewModel *loginViewModel = [[LoginViewModel alloc] init];
    loginViewModel.delegate = self;
    self.loginViewModel = loginViewModel;
}

#pragma mark - ButtonEvent
- (void)loginButtonAction {
    [self.view endEditing:YES];
    
    NSString *tryFailureMessage = [self.loginViewModel checkLoginCondition];
    if (tryFailureMessage) {
        [DemoToast showMessage:tryFailureMessage];
        return;
    }
    
    [DemoProgressHUD show];
    [self.loginViewModel loginWitLoginSuccess:^(NSString *successMessage, DemoUser *user) {
        [DemoProgressHUD dismiss];
        [DemoToast showMessage:successMessage];
        
        if (user.isDefaultPwd) {
            [LoginRouter goChangePasswordViewControllerFrom:self];
        } else {
//            [LoginRouter goMainViewController];
        }
        
    } loginFailure:^(NSString *errorMessage) {
        [DemoProgressHUD dismiss];
        [DemoToast showErrorMessage:errorMessage];
    }];
}

- (void)findPasswordButtonAction {
    [LoginRouter goFindPasswordViewControllerFrom:self];
}

- (void)registerButtonAction {
    [LoginRouter goRegisterViewControllerFrom:self];
}


#pragma mark - LoginViewModelDelegate
///userName的有效性发生变化
- (void)logic_checkUserNameWithValid:(BOOL)valid {
    self.userNameTextField.leftButtonSelected = valid;
}

///password的有效性发生变化
- (void)logic_checkPasswordWithValid:(BOOL)valid {
    self.passwordTextField.leftButtonSelected = valid;
}

///登录按钮的有效性发生变化
- (void)logic_checkLoginWithValid:(BOOL)valid {
    self.loginButton.enabled = valid;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //按Return进行换行功能
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
        return NO;
        
    } else if (textField == self.passwordTextField) {
        [self loginButtonAction];
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
        [self.loginViewModel updateUserName:newText];
        
    } else if (textField == self.passwordTextField) {
        [self.loginViewModel updatePassword:newText];
    }
    
    return YES;
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.portraitBackgroundImageView];
    [self.portraitBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(124);
        make.height.mas_equalTo(80);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.portraitImageView];
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(124);
        make.height.mas_equalTo(80);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.portraitImageView.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(270);
    }];
    
    [self.view addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTextField.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(270);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).mas_offset(6);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(270);
    }];
    
    [self.view addSubview:self.findPasswordButton];
    [self.findPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.view).mas_offset(-25);
        make.width.mas_equalTo(105);
    }];
    
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.findPasswordButton.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.view).mas_offset(-25);
        make.width.mas_equalTo(105);
    }];
}

- (UIImageView *)portraitBackgroundImageView {
    if (_portraitBackgroundImageView == nil) {
        _portraitBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _portraitBackgroundImageView.image = [UIImage imageNamed:@"people_Mask.png"];
    }
    return _portraitImageView;
}

- (UIImageView *)portraitImageView {
    if (_portraitImageView == nil) {
        UIImageView *portraitImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        portraitImageView.image = [UIImage imageNamed:@"people_logout.png"];
        
        _portraitImageView = portraitImageView;
    }
    return _portraitImageView;
}

- (CJTextField *)userNameTextField {
    if (_userNameTextField == nil) {
        UIImage *normalImage = [UIImage imageNamed:@"ico_lock_white.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"ico_lock_white.png"];
        _userNameTextField = [DemoTextFieldFactory textFieldWithNormalImage:normalImage selectedImage:selectedImage];
        _userNameTextField.placeholder = NSLocalizedString(@"用户名", nil);
        _userNameTextField.returnKeyType = UIReturnKeyNext;
        _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameTextField.delegate = self;
    }
    return _userNameTextField;
}
//- (CJTextField *)userNameTextField {
//    if (_userNameTextField == nil) {
//        _userNameTextField = [[CJTextField alloc] initWithFrame:CGRectZero];
//        _userNameTextField.backgroundColor = CJColorFromHexString(@"#cccccc");
//        _userNameTextField.placeholder = NSLocalizedString(@"用户名", nil);
//        _userNameTextField.layer.cornerRadius = 20;
//        _userNameTextField.returnKeyType = UIReturnKeyNext;
//
//        //UIImage *nameTextFieldLeftImage = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"ico_user_white" ofType:@"png"];
//        //UIImageView *leftView = = [[UIImageView alloc]initWithImage:nameTextFieldLeftImage];
//        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
//        leftView.image = [UIImage imageNamed:@"ico_user_white.png"];
//        _userNameTextField.leftView = leftView;
//        _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
//        _userNameTextField.leftViewLeftOffset = 8;
//        _userNameTextField.leftViewRightOffset = 8;
//    }
//    return _userNameTextField;
//}

- (CJTextField *)passwordTextField {
    if (_passwordTextField == nil) {
        UIImage *normalImage = [UIImage imageNamed:@"ico_lock_white.png"];
        UIImage *selectedImage = [UIImage imageNamed:@"ico_lock_white.png"];
        _passwordTextField = [DemoTextFieldFactory textFieldWithNormalImage:normalImage selectedImage:selectedImage];
        _passwordTextField.placeholder = NSLocalizedString(@"密码", nil);
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //_passwordTextField.clearsOnBeginEditing = NO; //告诉你这方法是无效的
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}


- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [DemoButtonFactory blueButton];
        [_loginButton setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
        _loginButton.enabled = NO;
        [_loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}
//- (UIButton *)loginButton {
//    if (_loginButton == nil) {
//        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_loginButton setBackgroundColor:CJColorFromHexString(@"#66cc00")];
//        [_loginButton setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
//        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _loginButton.layer.cornerRadius = 20;
//        _loginButton.enabled = NO;
//    }
//    return _loginButton;
//}

- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"arrow_back_red.png"] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *)findPasswordButton {
    if (_findPasswordButton == nil) {
        _findPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_findPasswordButton setTitle:NSLocalizedString(@"忘记密码？", nil) forState:UIControlStateNormal];
        [_findPasswordButton setTitleColor:CJColorFromHexString(@"#66cc00") forState:UIControlStateNormal];
    }
    return _findPasswordButton;
}

- (UIButton *)registerButton {
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:NSLocalizedString(@"新用户 >>", nil) forState:UIControlStateNormal];
        [_registerButton setTitleColor:CJColorFromHexString(@"#66cc00") forState:UIControlStateNormal];
    }
    return _registerButton;
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
