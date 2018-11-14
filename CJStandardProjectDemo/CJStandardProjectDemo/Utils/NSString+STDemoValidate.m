//
//  NSString+STDemoValidate.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "NSString+STDemoValidate.h"

@implementation NSString (STDemoValidate)

- (BOOL)stdemo_checkUserName {
    return self.length > 0;
}

- (BOOL)stdemo_checkPassword {
    NSString *phoneRegex = @"^([a-zA-Z0-9]|[a-z0-9.*[~!@#$%^&*()_+|<>,.?\\[\\]{}\"]+.*]|[A-Z0-9.*[~!@#$%^&*()_+|<>,.?\\[\\]{}\"]+.*]|[a-zA-z.*[~!@#$%^&*()_+|<>,.?\\[\\]{}\"]+.*]){6,50}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL rst = [phoneTest evaluateWithObject:self];
    return rst;
}

- (BOOL)stdemo_checkMobile {
    NSString *phoneRegex = @"^1[0-9]{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL rst = [phoneTest evaluateWithObject:self];
    return rst;
}

@end
