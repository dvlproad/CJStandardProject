//
//  DemoSession.m
//  CJDemoModelDemo
//
//  Created by ciyouzen on 2017/4/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoSession.h"

@implementation DemoSession

+ (instancetype)sharedInstance {
    static DemoSession *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (DemoUser *)currentUser {
    return [DemoSession sharedInstance].user;
}

+ (BOOL)isLogin {
    DemoUser *user = [DemoSession currentUser];
    
    NSString *loginName = user.name;
    BOOL isLogin = loginName.length > 0;
    
    return isLogin;
}

- (BOOL)establish
{
    return self.user.token.length > 0;
}

- (void)invalidate
{
    self.nid = nil;
    self.uuid = nil;
    self.user = nil;
}


@end
