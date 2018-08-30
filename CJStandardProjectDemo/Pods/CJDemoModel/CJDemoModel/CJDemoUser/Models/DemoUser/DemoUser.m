//
//  DemoUser.m
//  CJDemoModelDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "DemoUser.h"

NSString *const DemoGeneralPassword = @"123456";    //为测试而增加的通用密码

@interface DemoUser() {
    
}

@end


@implementation DemoUser

- (instancetype)init {
    self = [super init];
    if (self) {
        CJPathFileModel *imagePathFileModel = [[CJPathFileModel alloc] init];
        self.imagePathFileModel = imagePathFileModel;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
//             @"imName":     @"hxAccount",
//             @"imPassword": @"hxPassWord",
//             @"token":      @"token",
//             };
    return @{
             @"uid"    : @"uid",
             @"name"   : @"name",
             @"email"  : @"email",
             @"pasd"   : @"pasd",
             @"imageName": @"imageName",
             @"networkAbsoluteUrl": @"networkAbsoluteUrl",
             @"localRelativePath":  @"localRelativePath",
             
             @"sexType":    @"sexType",
             @"birthday":   @"birthday",
             
             @"modified" : @"modified",
             @"execTypeL": @"execTypeL",
             @"execTypeN": @"execTypeN"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"birthday"])
    {
        //对于日期，服务器可能返回两种情况，分别为情况①：返回时间戳，情况②：返回时间字符串
        /*
        //情况①：返回时间戳
        //number 与date
        return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
            NSTimeInterval secs = [number doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
            return date;
        } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
            NSTimeInterval secs = [date timeIntervalSince1970];
            return @(secs);
        }];
        
        //string 与 date
        return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string, BOOL *success, NSError *__autoreleasing *error) {
            NSTimeInterval secs = [string doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
            return date;
        } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
            NSTimeInterval secs = [date timeIntervalSince1970];
            NSString *dateString = [NSString stringWithFormat:@"%f", secs];
            return dateString;
        }];
        
        //*/
        //情况②：返回时间字符串
        NSDateFormatter *birthdayDateFormatter = [DemoUser birthdayDateFormatter];
        return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
            NSDate *date = [birthdayDateFormatter dateFromString:dateString];
            return date;
        } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
            NSString *dateString =  [birthdayDateFormatter stringFromDate:date];
            return dateString;
        }];
    }
//    else if ([key isEqualToString:@"list"])
//    {
//        return [MTLJSONAdapter arrayTransformerWithModelClass:[TempObj1 class]];
//    }
    /*
     跟方法二一样（不重复所以注释掉）
     else if ([key isEqualToString:@"model"])
     {
     return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TempObj1 class]];
     }
     */
    return nil;
    
}

//+ (NSValueTransformer *)sexTypeJSONTransformer {
//    NSDictionary *dictionary = @{
//                                 @"SexTypeMan":     @(SexTypeMan),
//                                 @"SexTypeWoman":   @(SexTypeWoman)
//                                 };
//    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
//}

- (DemoUsePermissionManager *)permissionManager {
    if (_permissionManager == nil) {
        _permissionManager = [[DemoUsePermissionManager alloc] initWithPermissionList:self.auths];
    }
    return _permissionManager;
}





#pragma mark - Other
+ (NSDateFormatter *)birthdayDateFormatter {
    NSDateFormatter *birthdayDateFormatter = [[NSDateFormatter alloc] init];
    //NSDateFormatter *birthdayDateFormatter = [CJDateFormatterUtil sharedInstance].dateFormatter;
    birthdayDateFormatter.dateFormat = @"yyyy-MM-dd";
    
    return birthdayDateFormatter;
}



@end
