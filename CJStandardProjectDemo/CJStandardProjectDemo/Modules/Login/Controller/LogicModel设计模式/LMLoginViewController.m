//
//  LMLoginViewController.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "LMLoginViewController.h"
#import <CJBaseUIKit/UINavigationBar+CJChangeBG.h>
#import "LoginLogicControl.h"
#import "CTMediator+STDemoLogin.h"

@interface LMLoginViewController () <UITextFieldDelegate, LoginLogicControlDelegate> {
    
}
@property (nonatomic, strong) LoginLogicControl *logicControl;

@end

@implementation LMLoginViewController

#pragma mark - LifeCycle
- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar cj_resetBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar cj_hideUnderline:YES];
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.title = @"";
    
    //显示上次登录的账号
    NSString *userName = [self.logicControl getDefaultLoginAccount];
    NSString *password = [self.logicControl getDefaultPasswordForUserName:userName];
    self.userNameTextField.text = userName;
    self.passwordTextField.text = password;

    [self.logicControl updateUserName:userName];
    [self.logicControl updatePassword:password];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self.viewModel startEndEditing];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"登录", nil);
    
    [self setupViews];
    
//    //viewModel
//    LoginViewControl *viewModel = [[LoginViewControl alloc] init];
//    viewModel.view = self.view;
//    viewModel.userNameTextField = self.userNameTextField;
//    viewModel.passwordTextField = self.passwordTextField;
//    viewModel.loginButton = self.loginButton;
//    viewModel.findPasswordButton = self.findPasswordButton;
//    viewModel.registerButton = self.registerButton;
//    viewModel.delegate = self;
//    self.viewModel = viewModel;
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.loginButton.enabled = NO;
    [self.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.findPasswordButton addTarget:self action:@selector(findPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //logicControl
    LoginLogicControl *logicControl = [[LoginLogicControl alloc] init];
    logicControl.delegate = self;
    self.logicControl = logicControl;
}

#pragma mark - SetupViews
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

#pragma mark - ButtonEvent
- (void)loginButtonAction {
    [self loginAction];
}

- (void)findPasswordButtonAction {
//    [self.viewModel goFindPasswordViewController];
    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_STDemo_forgetPasswordViewController];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)registerButtonAction {
//    [self.viewModel goRegisterViewController];
    UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_STDemo_registerViewController];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //按Return进行换行功能
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
        return NO;
        
    } else if (textField == self.passwordTextField) {
        [self loginAction];
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
        [self.logicControl updateUserName:newText];

    } else if (textField == self.passwordTextField) {
        [self.logicControl updatePassword:newText];
    }
    
    return YES;
}

- (void)loginAction {
    //结束视图的editing
    [self.view endEditing:YES];
    
    [self.logicControl loginWithTryFailure:^(NSString *tryFailureMessage) {
        //"尝试登录失败(未满足条件)时候"，更新视图
        [CJToast shortShowMessage:tryFailureMessage];
        
    } loginStart:^(NSString *startMessage) {
        //开始登录时候更新视图显示提示信息
        if (self.loginStateHUD == nil) {
            self.loginStateHUD = [CJToast createChrysanthemumHUDWithMessage:startMessage toView:nil];
        } else {
            self.loginStateHUD.label.text = startMessage;
        }
        
    } loginSuccess:^(NSString *successMessage) {
        //登录成功需要进入/回到主页
        [self.loginStateHUD hideAnimated:YES afterDelay:0];
        [CJToast shortShowMessage:successMessage];
        
    } loginFailure:^(NSString *errorMessage) {
        //登录失败更新视图显示提示信息
        self.loginStateHUD.label.text = errorMessage;
        self.loginStateHUD.mode = MBProgressHUDModeText;
        [self.loginStateHUD hideAnimated:YES afterDelay:1];
    }];
}




#pragma mark - LoginLogicControlDelegate
///登录按钮的enable发生变化需要更新按钮显示
- (void)logic_loginButtonEnableChange:(BOOL)enable {
    self.loginButton.enabled = enable;
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark - SetupViews & Lazy
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
        
        //UIImage *nameTextFieldLeftImage = [STDemoModuleLoginResourceUtil bundleImageNamed:@"ico_user_white" ofType:@"png"];
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
        _loginButton = [STDemoButtonFactory blueButton];
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
