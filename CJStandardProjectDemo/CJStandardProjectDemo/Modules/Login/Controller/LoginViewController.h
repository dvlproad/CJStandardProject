//
//  LoginViewController.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

//#import "CJDemoModuleLoginResourceUtil.h"

@interface LoginViewController : UIViewController {
    MBProgressHUD *HUD;
}
@property (nonatomic, weak) IBOutlet UIImageView *portraitImageView;    /**< 头像 */
@property (nonatomic, weak) IBOutlet UITextField *accountTextField;     /**< 账号(记得关掉自动纠错) */
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;    /**< 密码 */
@property (nonatomic, weak) IBOutlet UIButton *loginButton;             /**< 登录按钮 */

@property(nonatomic, weak) IBOutlet UIActivityIndicatorView *indicatorView;

@end
