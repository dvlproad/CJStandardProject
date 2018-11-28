//
//  RACLoginViewModel.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/9/4.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  RACLoginViewModel处理逻辑

#import <Foundation/Foundation.h>
#import "STDemoServiceUserManager.h"

@interface RACLoginViewModel : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *password;

- (instancetype)initWithUserName:(NSString *)userName password:(NSString *)password NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Update
- (void)updateUserName:(NSString *)userName;
- (void)updatePassword:(NSString *)password;

#pragma mark - Do
- (void)login;

@end
