//
//  DemoUser.m
//  CJDemoServiceDemo
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


- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    self.uid = userDictionary[@"uid"];
    self.name = userDictionary[@"name"];
    self.pasd = userDictionary[@"pasd"];
    self.email = userDictionary[@"email"];
    self.imageName = userDictionary[@"imageName"];
    self.networkAbsoluteUrl = userDictionary[@"networkAbsoluteUrl"];
    self.localRelativePath = userDictionary[@"localRelativePath"];
    self.auths = userDictionary[@"auths"];
    self.sexType = [userDictionary[@"sexType"] integerValue];
    
    NSString *birthday = userDictionary[@"birthday"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.birthday = [dateFormatter dateFromString:birthday];
    
    self.imName = userDictionary[@"imName"];
    self.imPassword = userDictionary[@"imPassword"];
    
    self.modified = userDictionary[@"modified"];
    self.execTypeL = userDictionary[@"execTypeL"];
    self.execTypeN = userDictionary[@"execTypeN"];
    
    return self;
}


@end
