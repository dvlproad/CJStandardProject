//
//  NSString+CJValidate.h
//  CJFoundationDemo
//
//  Created by lichq on 6/25/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CJValidate)

//源自：iOS - 正则表达式判断邮箱、身份证..是否正确：http://www.2cto.com/kf/201311/256494.html

//邮箱
- (BOOL)cj_validateEmail;

//手机号码验证
- (BOOL)cj_validateMobile;

//车牌号验证
- (BOOL)cj_validateCarNo;

//车型
- (BOOL)cj_validateCarType;

//用户名
- (BOOL)cj_validateUserName;

//密码
- (BOOL)cj_validatePassword;

//昵称
- (BOOL)cj_validateNickname;

//身份证号
- (BOOL)cj_validateIdentityCard;

@end
