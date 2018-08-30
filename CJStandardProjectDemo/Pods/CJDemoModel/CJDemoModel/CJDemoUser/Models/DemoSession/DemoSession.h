//
//  DemoSession.h
//  CJDemoModelDemo
//
//  Created by ciyouzen on 2017/4/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoUser.h"

@interface DemoSession : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSString *nid;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, strong) DemoUser *user;
@property (nonatomic, readonly) BOOL establish;

- (void)invalidate;

+ (DemoUser *)currentUser;


+ (BOOL)isLogin;

@end
