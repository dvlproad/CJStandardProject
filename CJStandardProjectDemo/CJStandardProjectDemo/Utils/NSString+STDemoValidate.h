//
//  NSString+STDemoValidate.h
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (STDemoValidate)

- (BOOL)stdemo_checkUserName;

/**验证密码：密码至少6位，需包含大、小写字母、数字、特殊字符，且至少包含其中三种*/
- (BOOL)stdemo_checkPassword;

- (BOOL)stdemo_checkMobile;

@end
