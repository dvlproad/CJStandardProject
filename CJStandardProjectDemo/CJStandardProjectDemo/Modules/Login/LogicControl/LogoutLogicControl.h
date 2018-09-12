//
//  LogoutLogicControl.h
//  CJDemoModuleLoginDemo
//
//  Created by 李超前 on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  LogoutLogicControl处理逻辑

#import <Foundation/Foundation.h>
#import "CJDemoServiceUserManager.h"

@protocol LogoutLogicControlDelegate <NSObject>

///退出按钮的enable发生变化需要更新按钮显示
- (void)logic_LogoutButtonEnableChange:(BOOL)enable;

///尝试退出时候，未满足条件时候
- (void)logic_tryLogoutFailureWithMessage:(NSString *)message;

///开始退出时候更新视图显示提示信息
- (void)logic_startLogoutWithMessage:(NSString *)message;

///退出成功
- (void)logic_logoutSuccessWithMessage:(NSString *)message;

///退出失败更新视图显示提示信息
- (void)logic_logoutFailureWithMessage:(NSString *)message;

@end



@interface LogoutLogicControl : NSObject {
    
}
@property (nonatomic, weak) id<LogoutLogicControlDelegate> delegate;

#pragma mark - Get Default

#pragma mark - Update

#pragma mark - Do
///执行退出
- (void)logout;

@end
