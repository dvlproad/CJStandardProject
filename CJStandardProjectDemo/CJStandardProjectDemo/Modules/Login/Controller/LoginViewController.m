//
//  LoginViewController.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "LoginViewController.h"
#import <CJBaseUtil/CJAppLastUtil.h>
#import <CJBaseUIKit/CJToast.h>

#import "LoginViewModel.h"

@interface LoginViewController () <UITextFieldDelegate> {
    
}
@property (nonatomic, strong) LoginViewModel *viewModel;

@end

@implementation LoginViewController

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    NSBundle *interfaceBundle = [CJDemoModuleLoginResourceUtil interfaceBundle];
//    self = [super initWithNibName:nibNameOrNil bundle:interfaceBundle];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.accountTextField becomeFirstResponder];//弹出键盘应该选择在viewDidAppear的时候
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //显示上次登录的账号
    NSString *account = [CJAppLastUtil getLastLoginAccount];
    NSString *password = [CJAppLastUtil getKeychainPasswordForAccount:account];
    self.accountTextField.text = account;
    self.passwordTextField.text = password;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"登录", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.accountTextField.delegate = self;
    self.accountTextField.returnKeyType = UIReturnKeyNext;
    
    self.passwordTextField.delegate = self;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    
    self.loginButton.enabled = NO;
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    /*
    //UITextField的背景色为CCCCCC
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
    self.viewModel = [[LoginViewModel alloc] init];
    
    [self.accountTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        [self.viewModel userNameChangeEvent:textField.text];
    }];
    
    [self.passwordTextField setCjTextDidChangeBlock:^(UITextField *textField) {
        [self.viewModel passwordChangeEvent:textField.text];
    }];
    
    __weak typeof(self)weakSelf = self;
    [self.viewModel setLoginButtonEnableChangeBlock:^(BOOL loginButtonEnable) {
        weakSelf.loginButton.enabled = loginButtonEnable;
    }];
    
    
    [self.loginButton setCjTouchEventBlock:^(UIButton *button) {
        [self.viewModel loginFromViewController:self];
    }];
    
    //登录成功要处理的方法
    [self.viewModel setSuccessBlock:^(id responseObject) {
        //在允许游客的情况下，登录方式有两种，①是从导航页进来登录的，②是从个人中心页进来登录的
        CJRootViewControllerType rootViewControllerType = [CJAppLastUtil getLastRootViewControllerTypeWithDistinctAppVersion:YES];
        if (rootViewControllerType == CJRootViewControllerTypeMain) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [CJAppLastUtil saveLastAppInfoWithRootViewControllerType:CJRootViewControllerTypeMain otherParams:nil]; //此时进入了Main
            
//            NSDictionary *params = nil;
//            UIViewController *mainViewControllerWithParams = [[CTMediator sharedInstance] cjDemo_mainViewControllerWithParams:params];
//            [UIApplication sharedApplication].delegate.window.rootViewController = mainViewControllerWithParams;
        }
        
        NSString *loginSuccessMessage = NSLocalizedString(@"登录成功", nil);
        [CJToast shortShowWhiteMessage:loginSuccessMessage];
    }];
    
    //fail
    [self.viewModel setFailureBlock:^(NSError *error) {
        
    }];
    
    //error
    [self.viewModel setErrorBlock:^(NSError *error) {
        
    }];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //按Return进行换行功能
    if (textField == self.accountTextField) {
        [self.passwordTextField becomeFirstResponder];
        return NO;
        
    } else if (textField == self.passwordTextField) {
        //[self.passwordTextField resignFirstResponder];
        [self.viewModel performSelector:@selector(loginFromViewController:) withObject:self];
        return YES;
        
    } else {
        [textField resignFirstResponder];
        return YES;
    }
}

//根据用户名查找用户头像
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.tfName) {
        NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        UIImage *image = [DemoFMDBFileManager selectImageWhereName:newText];
        self.imageV.image = image; //[image makeCircleWithParam:0];
    }
    
    return YES;
}
*/


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
