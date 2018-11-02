//
//  CTMediator+STDemoLogin.h
//  CJStandardProjectDemo
//
//  Created by 李超前 on 10/30/18.
//  Copyright © 2018 devlproad. All rights reserved.
//

#import "CTMediator.h"

@interface CTMediator (STDemoLogin)

///获取登录页
- (UIViewController *)CTMediator_STDemo_loginViewController;

///进入"忘记密码"界面
- (UIViewController *)CTMediator_STDemo_forgetPasswordViewController;

///进入"修改密码"界面(初始密码时候需要)
- (UIViewController *)CTMediator_STDemo_changePasswordViewController;

///进入"注册"界面
- (UIViewController *)CTMediator_STDemo_registerViewController;

@end
