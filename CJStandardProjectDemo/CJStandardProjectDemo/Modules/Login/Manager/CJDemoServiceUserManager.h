//
//  CJDemoServiceUserManager.h
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  UserService最公共的部分(UserService会有Login、Detail、Edit等操作)

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DemoUser.h"

@interface CJDemoServiceUserManager : NSObject {
    
}
+ (CJDemoServiceUserManager *)sharedInstance;

#pragma mark - Session
//@property (nonatomic, assign) BOOL autoLogin;           /**< 本次登录成功，设置下次允许自动登录(属用户还是网络?) */
//@property (nonatomic, assign) BOOL loginSuccess;        /**< 用户是否登录成功 */
@property (nonatomic, strong) DemoUser *serviceUser;    /**< 服务的用户(有set方法，处理通知) */


@end
