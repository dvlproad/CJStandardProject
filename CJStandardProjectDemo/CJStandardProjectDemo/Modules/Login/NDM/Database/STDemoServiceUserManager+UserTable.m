//
//  STDemoServiceUserManager+UserTable.m
//  STDemoServiceDemo
//
//  Created by ciyouzen on 2017/10/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "STDemoServiceUserManager+UserTable.h"

static NSString *kCurrentTableName = @"STDemoUser";

@implementation STDemoServiceUserManager (UserTable)

/*
- (BOOL)createTable
{
    NSString *sql = @"create table if not exists ACCOUNT (uid Text PRIMARY KEY, name TEXT, email TEXT, pasd TEXT, imageName Text, imageUrl Text, imagePath Text, modified TEXT, execTypeL Text);";
    
    return [CommonFMDBUtil create:sql];
}
*/

- (NSString *)sqlForCreateTable {
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (uid Text PRIMARY KEY, name TEXT, email TEXT, userToken TEXT, imageName Text, networkAbsoluteUrl Text, localRelativePath Text, sexType Interget, birthday Text, modified TEXT, execTypeL Text);", kCurrentTableName];
    
    return sql;
}


#pragma mark - insert
- (BOOL)insertAccountInfo:(STDemoUser *)info {
    NSString *sql = [self sqlForInsertInfo:info];
    return [[DemoFMDBFileManager sharedInstance] cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForInsertInfo:(STDemoUser *)info
{
    NSAssert(info, @"info cannot be nil!");
    
    NSString *portraitImageLocalRelativePath = info.imagePathFileModel.localRelativePath;
    NSString *portraitImageNetworkAbsoluteUrl = info.imagePathFileModel.networkAbsoluteUrl;
    NSDateFormatter *birthdayDateFormatter = [STDemoUser birthdayDateFormatter];
    NSString *birthdayString = [birthdayDateFormatter stringFromDate:info.birthday];
    
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT OR REPLACE INTO %@ (uid, name, email, userToken, imageName, networkAbsoluteUrl, localRelativePath, sexType, birthday, modified, execTypeL) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%zd', '%@', '%@', '%@')", kCurrentTableName, info.uid, info.name, info.email, info.userToken, info.imageName, portraitImageNetworkAbsoluteUrl, portraitImageLocalRelativePath, info.sexType, birthdayString, info.modified, info.execTypeL];//DB Error: 1 "unrecognized token: ":"" 即要求插入的字符串需加引号'，而对于表名，属性名，可以不用像原来那样添加。
    return sql;
}


#pragma mark - remove
- (BOOL)removeAccountInfoWhereName:(NSString *)name {
    NSString *sql = [self sqlForRemoveInfoWhereName:name];
    return [[DemoFMDBFileManager sharedInstance] cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForRemoveInfoWhereName:(NSString *)name
{
    NSAssert(name, @"name cannot be nil!");
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where name = '%@'",kCurrentTableName, name];
    
    return sql;
}



#pragma mark - update
- (BOOL)updateAccountInfoExceptUID:(STDemoUser *)info whereUID:(NSString *)uid {
    NSString *sql = [self sqlForUpdateInfoExceptUID:info whereUID:uid];
    return [[DemoFMDBFileManager sharedInstance] cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForUpdateInfoExceptUID:(STDemoUser *)info whereUID:(NSString *)uid
{
    NSString *portraitImageLocalRelativePath = info.imagePathFileModel.localRelativePath;
    NSString *portraitImageNetworkAbsoluteUrl = info.imagePathFileModel.networkAbsoluteUrl;
    NSDateFormatter *birthdayDateFormatter = [STDemoUser birthdayDateFormatter];
    NSString *birthdayString = [birthdayDateFormatter stringFromDate:info.birthday];
    
    NSString *sql = [NSString stringWithFormat:
                     @"UPDATE %@ SET name = '%@', email = '%@', userToken = '%@', imageName = '%@', networkAbsoluteUrl = '%@', localRelativePath = '%@', sexType = '%zd', birthday = '%@' WHERE uid = '%@'", kCurrentTableName,
                     info.name, info.email, info.userToken, info.imageName, portraitImageNetworkAbsoluteUrl, portraitImageLocalRelativePath, info.sexType, birthdayString, uid];
    return sql;
}



- (BOOL)updateAccountInfoImagePath:(NSString *)imagePath whereUID:(NSString *)uid {
    NSString *sql = [self sqlForUpdateInfoImageUrl:imagePath whereUID:uid];
    return [[DemoFMDBFileManager sharedInstance] cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForUpdateInfoImagePath:(NSString *)imagePath whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                     @"update %@ set localRelativePath = '%@' where uid = '%@'", kCurrentTableName, imagePath, uid];
    return sql;
}


- (BOOL)updateAccountInfoImageUrl:(NSString *)imageUrl whereUID:(NSString *)uid {
    NSString *sql = [self sqlForUpdateInfoImageUrl:imageUrl whereUID:uid];
    return [[DemoFMDBFileManager sharedInstance] cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForUpdateInfoImageUrl:(NSString *)imageUrl whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                     @"update %@ set networkAbsoluteUrl = '%@' where uid = '%@'", kCurrentTableName, imageUrl, uid];
    return sql;
}



- (BOOL)updateAccountInfoExecTypeL:(NSString *)execTypeL whereUID:(NSString *)uid {
    NSString *sql = [self sqlForUpdateInfoExecTypeL:execTypeL whereUID:uid];
    return [[DemoFMDBFileManager sharedInstance] cjExecuteUpdate:@[sql]];
}


- (NSString *)sqlForUpdateInfoExecTypeL:(NSString *)execTypeL whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                     @"update %@ set execTypeL = '%@' where uid = '%@'", kCurrentTableName, execTypeL, uid];
    return sql;
}

#pragma mark - query
- (STDemoUser *)selectAccountInfoWhereUID:(NSString *)uid {
    NSString *sql = [self sqlForSelectInfoWhereUID:uid];
    
    NSArray *result = [[DemoFMDBFileManager sharedInstance] query:sql];
    
    NSMutableArray<STDemoUser *> *users = [[NSMutableArray alloc] init];
    for (NSDictionary *userDictionary in result) {
        STDemoUser *user = [[STDemoUser alloc] initWithUserDictionary:userDictionary];
        [users addObject:user];
    }
    
    if (users.count > 0) {
        STDemoUser *user = [users objectAtIndex:0];
        [user.imagePathFileModel updateLocalRelativePath:user.localRelativePath localSourceType:CJFileSourceTypeLocalSandbox];
        return user;
    } else {
        return nil;
    }
}

- (NSString *)sqlForSelectInfoWhereUID:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where uid = '%@'", kCurrentTableName, uid];
    return sql;
}


- (UIImage *)selectAccountImageWhereUid:(NSString *)uid
{
    NSString *sql = [self sqlForSelectImageWhereUid:uid];
    
    NSArray *result = [[DemoFMDBFileManager sharedInstance] query:sql];
    NSString *imagePath = result.count > 0 ?
    [result[0] objectForKey:@"imagePath"] : [[NSBundle mainBundle] pathForResource:@"people_logout" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

//为了在登录页面上，输入名字的时候可以显示出已经登录过的头像而加入的方法
- (NSString *)sqlForSelectImageWhereUid:(NSString *)uid
{
    NSString *sql = [NSString stringWithFormat:@"SELECT localRelativePath FROM %@ where uid = '%@'", kCurrentTableName, uid];
    
    return sql;
}


@end
