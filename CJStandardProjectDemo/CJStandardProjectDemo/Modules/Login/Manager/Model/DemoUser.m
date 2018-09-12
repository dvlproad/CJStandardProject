//
//  DemoUser.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "DemoUser.h"

#import <CJFile/CJFileManager+GetCreatePath.h>
#import <CJFile/CJFileManager+SaveFileData.h>

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

- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    if (self) {
        self.uid = userDictionary[@"uid"];
        self.name = userDictionary[@"name"];
        self.userToken = userDictionary[@"userToken"];
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
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    DemoUser *user = [[[self class] allocWithZone:zone] init];
    user.uid = self.uid;
    user.name = self.name;
    user.userToken = self.userToken;
    user.email = self.email;
    user.imageName = self.imageName;
    user.networkAbsoluteUrl = self.networkAbsoluteUrl;
    user.localRelativePath = self.localRelativePath;
    user.auths = self.auths;
    user.sexType = self.sexType;
    user.birthday = self.birthday;
    
    user.imName = self.imName;
    user.imPassword = self.imPassword;
    
    user.modified = self.modified;
    user.execTypeL = self.execTypeL;
    user.execTypeN = self.execTypeN;
    
    return user;
}

#pragma mark - Other
+ (NSDateFormatter *)birthdayDateFormatter {
    NSDateFormatter *birthdayDateFormatter = [[NSDateFormatter alloc] init];
    //NSDateFormatter *birthdayDateFormatter = [CJDateFormatterUtil sharedInstance].dateFormatter;
    birthdayDateFormatter.dateFormat = @"yyyy-MM-dd";
    
    return birthdayDateFormatter;
}


#pragma mark - 头像
/* 完整的描述请参见文件头部 */
- (void)getPortraitImageWithCompleteBlock:(void(^)(UIImage *portraitImage))completeBlock {
    [self.imagePathFileModel getFileDataWithCompleteBlock:^(NSData *fileData) {
        UIImage *image = [UIImage imageWithData:fileData];
        if (image == nil) {
            image = [UIImage imageNamed:@"cjAvatar.png"];
        }
        if (completeBlock) {
            completeBlock(image);
        }
    }];
}


/* 完整的描述请参见文件头部 */
- (void)updatePortraitImageLocalRelativePathByChooseImage:(UIImage *)choosePortraitImage {
    NSString *relativeDirectory = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative bySubDirectoryPath:@"DemoUserImage" inSearchPathDirectory:NSDocumentDirectory createIfNoExist:YES];
    
    //保存选择的头像到本地
    NSString *imageName = [NSString stringWithFormat:@"avantar_%@.jpg", self.uid];
    NSData *imageData = UIImageJPEGRepresentation(choosePortraitImage, 1.0f);
    [CJFileManager saveFileData:imageData withFileName:imageName toRelativeDirectoryPath:relativeDirectory];
    
    //更新头像的本地相对路径
    NSString *localRelativePath = [relativeDirectory stringByAppendingPathComponent:imageName];
    //self.localRelativePath = localRelativePath;
    [self.imagePathFileModel updateLocalRelativePath:localRelativePath localSourceType:CJFileSourceTypeLocalSandbox];
}

#pragma mark - 权限
- (BOOL)hasPermissionWithPermissionID:(DemoHPPermissionType)permissionID {
    for (DemoUsePermissionModel *e in self.auths) {
        if (e.permission == permissionID) {
            return YES;
        }
    }
    return NO;
}

@end
