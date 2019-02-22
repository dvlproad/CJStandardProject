//
//  RegisterViewController.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJDemoModuleLoginResourceUtil.h"

@interface RegisterViewController : UIViewController{
    
}
@property(nonatomic, strong) IBOutlet UITextField *emailTextField;
@property(nonatomic, strong) IBOutlet UITextField *userNameTextField;
@property(nonatomic, strong) IBOutlet UITextField *passwordTextField;

@property (nonatomic, weak) IBOutlet UIButton *registerButton;          /**< 注册按钮 */

@end
