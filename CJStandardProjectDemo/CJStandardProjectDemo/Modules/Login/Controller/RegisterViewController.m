//
//  RegisterViewController.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "RegisterViewController.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import <CJDemoCommon/DemoToast.h>
#import <CJDemoCommon/DemoProgressHUD.h>
#import <CJBaseUIKit/UITextField+CJTextChangeBlock.h>
#import <CJBaseUIKit/UIButton+CJMoreProperty.h>
#import "RegisterViewModel.h"
#import "LoginRouter.h"

@interface RegisterViewController () <UITextFieldDelegate> {
    
}
@property (nonatomic, strong) RegisterViewModel *viewModel;

@end



@implementation RegisterViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSBundle *interfaceBundle = [CJDemoModuleLoginResourceUtil interfaceBundle];
    self = [super initWithNibName:nibNameOrNil bundle:interfaceBundle];
    if (self) {
        
    }
    return self;
}

/*
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.tfEmail becomeFirstResponder];
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"注册", nil);
    
    self.emailTextField.delegate = self;
    self.emailTextField.returnKeyType = UIReturnKeyNext;
    
    self.userNameTextField.delegate = self;
    self.userNameTextField.returnKeyType = UIReturnKeyNext;
    
    self.passwordTextField.delegate = self;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    //self.passwordTextField.placeholder = [NSString stringWithFormat:@"密码统一为%@", DemoGeneralPassword];
    
    self.registerButton.enabled = NO;
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    /*
    UIImage *emailTextFieldLeftImage = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"ico_mail_white" ofType:@"png"];
    self.tfEmail.leftView = [[UIImageView alloc]initWithImage:emailTextFieldLeftImage];
    self.tfEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIImage *nameTextFieldLeftImage = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"ico_user_white" ofType:@"png"];
    self.tfName.leftView = [[UIImageView alloc]initWithImage:nameTextFieldLeftImage];
    self.tfName.leftViewMode = UITextFieldViewModeAlways;
    
    UIImage *pasdTextFieldLeftImage = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"co_lock_white" ofType:@"png"];
    self.tfPasd.leftView = [[UIImageView alloc]initWithImage:pasdTextFieldLeftImage];
    self.tfPasd.leftViewMode = UITextFieldViewModeAlways;
    */
    
    [self bindViewModel];
}


///关联ViewModel
- (void)bindViewModel {
    self.viewModel = [[RegisterViewModel alloc] init];
    
    __weak typeof(self)weakSelf = self;
    [self.emailTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        [weakSelf.viewModel updateEmail:textField.text];
    }];
    
    [self.userNameTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        [weakSelf.viewModel updateUserName:textField.text];
    }];
    
    [self.passwordTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        [weakSelf.viewModel updateEmail:textField.text];
    }];
    
    [self.viewModel setRegisterButtonEnableChangeBlock:^(BOOL loginButtonEnable) {
        weakSelf.registerButton.enabled = loginButtonEnable;
    }];
    
    
    [self.registerButton setCjTouchUpInsideBlock:^(UIButton *button) {
        [self.viewModel didRegister];
    }];
    
    //登录成功要处理的方法
    [self.viewModel setSuccessBlock:^(BOOL registerSuccess, NSString *successMessage) {
        //NSString *registerSuccessMessage = NSLocalizedString(@"注册成功", nil);
        [DemoProgressHUD dismiss];
        [DemoToast showMessage:successMessage];
        
        [LoginRouter goMainViewController];
    }];
    
    //fail
    [self.viewModel setFailureBlock:^(NSString *errorMessage) {
        [DemoProgressHUD dismiss];
        [DemoToast showErrorMessage:errorMessage];
    }];
    
    //error
    [self.viewModel setErrorBlock:^(NSError *error) {
        
    }];
}

#pragma mark - ButtonEvent
- (void)registerButtonAction {
    [self.view endEditing:YES];
    
    NSString *tryFailureMessage = [self.viewModel checkRegisterCondition];
    if (tryFailureMessage) {
        [DemoToast showMessage:tryFailureMessage];
        return;
    }
    
    [DemoProgressHUD show];
    [self.viewModel didRegister];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //按Return进行换行功能
    if (textField == self.emailTextField) {
        [self.userNameTextField becomeFirstResponder];
        return NO;
        
    } else if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
        return NO;
        
    } else if (textField == self.passwordTextField) {
        //[self.passwordTextField resignFirstResponder];
        [self registerButtonAction];
        return YES;
        
    } else {
        [textField resignFirstResponder];
        return YES;
    }
}

#pragma mark -
/////////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
