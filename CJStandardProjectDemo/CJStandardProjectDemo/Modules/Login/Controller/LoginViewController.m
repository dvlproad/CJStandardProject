//
//  LoginViewController.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewControl.h"
#import "LoginLogicControl.h"


@interface LoginViewController () <UITextFieldDelegate, LoginViewModelDelegate, LoginLogicControlDelegate> {
    
}
@property (nonatomic, strong) LoginViewControl *viewModel;
@property (nonatomic, strong) LoginLogicControl *logicControl;

@end

@implementation LoginViewController

#pragma mark - LifeCycle
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //显示上次登录的账号
    NSString *userName = [self.logicControl getDefaultLoginAccount];
    NSString *password = [self.logicControl getDefaultPasswordForUserName:userName];
    [self.viewModel updateUserNameTextField:userName];
    [self.viewModel updatePasswordTextField:password];
    [self.logicControl updateUserName:userName];
    [self.logicControl updatePassword:password];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.viewModel startEndEditing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"登录", nil);
    
    [self setupViews];
    
    //viewModel
    LoginViewControl *viewModel = [[LoginViewControl alloc] init];
    viewModel.userNameTextField = self.userNameTextField;
    viewModel.passwordTextField = self.passwordTextField;
    viewModel.loginButton = self.loginButton;
    viewModel.findPasswordButton = self.findPasswordButton;
    viewModel.registerButton = self.registerButton;
    viewModel.delegate = self;
    self.viewModel = viewModel;
    
    //logicControl
    LoginLogicControl *logicControl = [[LoginLogicControl alloc] init];
    logicControl.delegate = self;
    self.logicControl = logicControl;
}

#pragma mark - LoginViewModelDelegate
- (void)vm_userNameTextFieldChange:(NSString *)userName {
    [self.logicControl updateUserName:userName];
}

- (void)vm_passwordTextFieldChange:(NSString *)password {
    [self.logicControl updatePassword:password];
}

- (void)vm_loginButtonAction {
    [self.viewModel stopEndEditing];
    [self.logicControl login];
}

- (void)vm_findPasswordButtonAction {
    [self.viewModel goFindPasswordViewController];
}

- (void)vm_registerButtonAction {
    [self.viewModel goRegisterViewController];
}


#pragma mark - LoginLogicControlDelegate
///登录按钮的enable发生变化需要更新按钮显示
- (void)logic_LoginButtonEnableChange:(BOOL)enable {
    [self.viewModel updateLoginButtonEnable:enable];
}

///尝试登录时候，未满足条件时候
- (void)logic_tryLoginFailureWithMessage:(NSString *)message {
    [self.viewModel tryLoginFailureWithMessage:message];
}

///开始登录时候更新视图显示提示信息
- (void)logic_startLoginWithMessage:(NSString *)message {
    [self.viewModel startLoginWithMessage:message];
}

///登录成功需要进入主页
- (void)logic_loginSuccessAndGoMainViewControllerWithMessage:(NSString *)message {
    [self.viewModel loginSuccessAndGoMainViewControllerWithMessage:message];
}

///登录成功需要回到主页
- (void)logic_loginSuccessAndBackMainViewControllerWithMessage:(NSString *)message {
    [self.viewModel loginSuccessAndBackMainViewControllerWithMessage:message];
}

///登录失败更新视图显示提示信息
- (void)logic_loginFailureWithMessage:(NSString *)message {
    
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.viewModel stopEndEditing];
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
        _userNameTextField = [[CJTextField alloc] initWithFrame:CGRectZero];
        _userNameTextField.backgroundColor = CJColorFromHexString(@"#cccccc");
        _userNameTextField.placeholder = NSLocalizedString(@"用户名", nil);
        _userNameTextField.layer.cornerRadius = 20;
        _userNameTextField.returnKeyType = UIReturnKeyNext;
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        leftView.image = [UIImage imageNamed:@"ico_user_white.png"];
        _userNameTextField.leftView = leftView;
        _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
        _userNameTextField.leftViewLeftOffset = 8;
        _userNameTextField.leftViewRightOffset = 8;
    }
    return _userNameTextField;
}

- (CJTextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[CJTextField alloc] initWithFrame:CGRectZero];
        _passwordTextField.backgroundColor = CJColorFromHexString(@"#cccccc");
        _passwordTextField.placeholder = NSLocalizedString(@"用户名", nil);
        _passwordTextField.layer.cornerRadius = 20;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        
        //UIImage *nameTextFieldLeftImage = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"ico_user_white" ofType:@"png"];
        //UIImageView *leftView = = [[UIImageView alloc]initWithImage:nameTextFieldLeftImage];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        leftView.image = [UIImage imageNamed:@"ico_lock_white.png"];
        _passwordTextField.leftView = leftView;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.leftViewLeftOffset = 8;
        _passwordTextField.leftViewRightOffset = 8;
    }
    return _passwordTextField;
}


- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:CJColorFromHexString(@"#66cc00")];
        [_loginButton setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 20;
        _loginButton.enabled = NO;
    }
    return _loginButton;
}

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
