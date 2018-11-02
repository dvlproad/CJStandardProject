//
//  CTMediator+STDemoLogin.m
//  CJStandardProjectDemo
//
//  Created by 李超前 on 10/30/18.
//  Copyright © 2018 devlproad. All rights reserved.
//

#import "CTMediator+STDemoLogin.h"

NSString * const kCTMediatorTargetSTDemoLoginVCFactory = @"STDemoLoginVCFactory";

@implementation CTMediator (STDemoLogin)

///获取登录页
- (UIViewController *)CTMediator_STDemo_loginViewController {
    UIViewController *loginViewController =
    [self performTarget:kCTMediatorTargetSTDemoLoginVCFactory
                 action:@"STDemo_loginViewController"
                 params:nil
      shouldCacheTarget:NO];
    
    if ([loginViewController isKindOfClass:[UIViewController class]]) {
        return loginViewController; // vc交付出去之后，可以由外界选择是push还是present
    } else {
        return [[UIViewController alloc] init]; // 这里处理异常场景，具体如何处理取决于产品
    }
}

///进入"忘记密码"界面
- (UIViewController *)CTMediator_STDemo_forgetPasswordViewController {
    return [self performTarget:kCTMediatorTargetSTDemoLoginVCFactory
                        action:@"STDemo_forgetPasswordViewController"
                        params:nil
             shouldCacheTarget:NO];
}

///进入"修改密码"界面(初始密码时候需要)
- (UIViewController *)CTMediator_STDemo_changePasswordViewController {
    return [self performTarget:kCTMediatorTargetSTDemoLoginVCFactory
                        action:@"STDemo_changePasswordViewController"
                        params:nil
             shouldCacheTarget:NO];
}

///进入"注册"界面
- (UIViewController *)CTMediator_STDemo_registerViewController {
    return [self performTarget:kCTMediatorTargetSTDemoLoginVCFactory
                        action:@"STDemo_registerViewController"
                        params:nil
             shouldCacheTarget:NO];
}


@end
