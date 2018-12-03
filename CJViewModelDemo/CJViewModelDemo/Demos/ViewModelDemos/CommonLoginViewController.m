//
//  CommonLoginViewController.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CommonLoginViewController.h"
#import <CJBaseUIKit/UINavigationBar+CJChangeBG.h>
#import "STDemoButtonFactory.h"
#import "STDemoTextFieldFactory.h"

@interface CommonLoginViewController () <UITextFieldDelegate> {
    
}

@end

@implementation CommonLoginViewController

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
    [self showDefaultData];
}

- (void)showDefaultData {
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"登录", nil);
    
    [self setupViews];
    
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.loginButton.enabled = NO;
    [self.loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.findPasswordButton addTarget:self action:@selector(findPasswordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //bindViewModel
    [self bindViewModel];
}

- (void)bindViewModel {
    
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
    
}

- (void)findPasswordButtonAction {

}

- (void)registerButtonAction {
    
}

#pragma mark - Update
- (void)userNameTextFieldUpdateToText:(NSString *)userName {
    
}

- (void)passwordTextFieldUpdateToText:(NSString *)password {
    
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
        [self userNameTextFieldUpdateToText:newText];

    } else if (textField == self.passwordTextField) {
        [self passwordTextFieldUpdateToText:newText];
    }
    
    return YES;
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
        UIImage *normalImage = [UIImage imageNamed:@"login_username_gray"];
        UIImage *selectedImage = [UIImage imageNamed:@"login_username_blue"];
        _userNameTextField = [STDemoTextFieldFactory textFieldWithNormalImage:normalImage selectedImage:selectedImage];
        _userNameTextField.placeholder = NSLocalizedString(@"用户名", nil);
        _userNameTextField.returnKeyType = UIReturnKeyNext;
        _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameTextField.delegate = self;
    }
    return _userNameTextField;
}

- (CJTextField *)passwordTextField {
    if (_passwordTextField == nil) {
        UIImage *normalImage = [UIImage imageNamed:@"login_password_gray"];
        UIImage *selectedImage = [UIImage imageNamed:@"login_password_blue"];
        _passwordTextField = [STDemoTextFieldFactory textFieldWithNormalImage:normalImage selectedImage:selectedImage];
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
