//
//  DemoUser.h
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "DemoUsePermissionManager.h"

#import <CJFile/CJPathFileModel.h>

extern NSString *const DemoGeneralPassword;


typedef NS_ENUM(NSUInteger, SexType) {
    SexTypeMan,
    SexTypeWoman,
};



@interface DemoUser : NSObject {
    
}
@property (nonatomic, assign, readonly) BOOL isDefaultPwd;    /**< 是否为初始密码 */
@property (nonatomic, copy) NSString *userToken;

@property (nonatomic, copy) NSString *imName;
@property (nonatomic, copy) NSString *imPassword;

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *pasd;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) CJPathFileModel *imagePathFileModel;
@property (nonatomic, copy) NSString *localRelativePath;/**< 本地相对路径(因为沙盒路径会变) */
@property (nonatomic, copy) NSString *networkAbsoluteUrl;/**< 网络绝对路径(有时服务器给的会是省略前缀后的) */

@property (nonatomic, assign) SexType sexType;
@property (nonatomic, assign) NSDate *birthday;

@property (nonatomic, copy) NSString *modified;
@property (nonatomic, copy) NSString *execTypeL;
@property (nonatomic, copy) NSString *execTypeN;

@property (nonatomic, copy) NSArray<NSString *> *auths;

@property (nonatomic, strong) DemoUsePermissionManager *permissionManager;

#pragma mark - Other
+ (NSDateFormatter *)birthdayDateFormatter;


- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary;

@end
