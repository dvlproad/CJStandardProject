//
//  TestCodeObfuscationViewController.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/30.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "TestCodeObfuscationModel.h"

@interface TestCodeObfuscationViewController : UIViewController


@property (nonatomic, copy) void (^ _Nullable cjcof_testSetterBlock)(NSInteger payResultType);
@property (nonatomic, copy) void (^ _Nullable cjcof_payResultBlock)(NSInteger payResultType);

//微信授权，是否接口授权标识
- (void)weChatOauthType:(BOOL)isAuthorization resultBlock:(void(^)(TestCodeObfuscationModel *model))block;

@end
