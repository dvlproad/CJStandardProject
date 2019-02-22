//
//  CJDemoDatabase+User.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2017/10/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJDemoDatabase+User.h"

static NSString *kCurrentTableName = @"CJDemoUser";

@implementation CJDemoDatabase (User)

/*
- (BOOL)createTable
{
    NSString *sql = @"create table if not exists ACCOUNT (uid Text PRIMARY KEY, name TEXT, email TEXT, pasd TEXT, imageName Text, imageUrl Text, imagePath Text, modified TEXT, execTypeL Text);";
    
    return [CommonFMDBUtil create:sql];
}
*/

- (NSString *)sqlForCreateTable {
    NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (uid Text PRIMARY KEY, name TEXT, email TEXT, pasd TEXT, imageName Text, networkAbsoluteUrl Text, localRelativePath Text, sexType Interget, birthday Text, modified TEXT, execTypeL Text);", kCurrentTableName];
    
    return sql;
}


#pragma mark - insert
- (BOOL)insertAccountInfo:(DemoUser *)info {
    NSString *sql = [self sqlForInsertInfo:info];
    return [self cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForInsertInfo:(DemoUser *)info
{
    NSAssert(info, @"info cannot be nil!");
    
    NSString *portraitImageLocalRelativePath = info.imagePathFileModel.localRelativePath;
    NSString *portraitImageNetworkAbsoluteUrl = info.imagePathFileModel.networkAbsoluteUrl;
    NSDateFormatter *birthdayDateFormatter = [DemoUser birthdayDateFormatter];
    NSString *birthdayString = [birthdayDateFormatter stringFromDate:info.birthday];
    
    NSString *sql = [NSString stringWithFormat:
                     @"INSERT OR REPLACE INTO %@ (uid, name, email, pasd, imageName, networkAbsoluteUrl, localRelativePath, sexType, birthday, modified, execTypeL) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%zd', '%@', '%@', '%@')", kCurrentTableName, info.uid, info.name, info.email, info.pasd, info.imageName, portraitImageNetworkAbsoluteUrl, portraitImageLocalRelativePath, info.sexType, birthdayString, info.modified, info.execTypeL];//DB Error: 1 "unrecognized token: ":"" 即要求插入的字符串需加引号'，而对于表名，属性名，可以不用像原来那样添加。
    return sql;
}


#pragma mark - remove
- (BOOL)removeAccountInfoWhereName:(NSString *)name {
    NSString *sql = [self sqlForRemoveInfoWhereName:name];
    return [self cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForRemoveInfoWhereName:(NSString *)name
{
    NSAssert(name, @"name cannot be nil!");
    
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where name = '%@'",kCurrentTableName, name];
    
    return sql;
}



#pragma mark - update
- (BOOL)updateAccountInfoExceptUID:(DemoUser *)info whereUID:(NSString *)uid {
    NSString *sql = [self sqlForUpdateInfoExceptUID:info whereUID:uid];
    return [self cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForUpdateInfoExceptUID:(DemoUser *)info whereUID:(NSString *)uid
{
    NSString *portraitImageLocalRelativePath = info.imagePathFileModel.localRelativePath;
    NSString *portraitImageNetworkAbsoluteUrl = info.imagePathFileModel.networkAbsoluteUrl;
    NSDateFormatter *birthdayDateFormatter = [DemoUser birthdayDateFormatter];
    NSString *birthdayString = [birthdayDateFormatter stringFromDate:info.birthday];
    
    NSString *sql = [NSString stringWithFormat:
                     @"UPDATE %@ SET name = '%@', email = '%@', pasd = '%@', imageName = '%@', networkAbsoluteUrl = '%@', localRelativePath = '%@', sexType = '%zd', birthday = '%@' WHERE uid = '%@'", kCurrentTableName,
                     info.name, info.email, info.pasd, info.imageName, portraitImageNetworkAbsoluteUrl, portraitImageLocalRelativePath, info.sexType, birthdayString, uid];
    return sql;
}



- (BOOL)updateAccountInfoImagePath:(NSString *)imagePath whereUID:(NSString *)uid {
    NSString *sql = [self sqlForUpdateInfoImageUrl:imagePath whereUID:uid];
    return [self cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForUpdateInfoImagePath:(NSString *)imagePath whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                     @"update %@ set localRelativePath = '%@' where uid = '%@'", kCurrentTableName, imagePath, uid];
    return sql;
}


- (BOOL)updateAccountInfoImageUrl:(NSString *)imageUrl whereUID:(NSString *)uid {
    NSString *sql = [self sqlForUpdateInfoImageUrl:imageUrl whereUID:uid];
    return [self cjExecuteUpdate:@[sql]];
}

- (NSString *)sqlForUpdateInfoImageUrl:(NSString *)imageUrl whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                     @"update %@ set networkAbsoluteUrl = '%@' where uid = '%@'", kCurrentTableName, imageUrl, uid];
    return sql;
}



- (BOOL)updateAccountInfoExecTypeL:(NSString *)execTypeL whereUID:(NSString *)uid {
    NSString *sql = [self sqlForUpdateInfoExecTypeL:execTypeL whereUID:uid];
    return [self cjExecuteUpdate:@[sql]];
}


- (NSString *)sqlForUpdateInfoExecTypeL:(NSString *)execTypeL whereUID:(NSString *)uid{
    NSString *sql = [NSString stringWithFormat:
                     @"update %@ set execTypeL = '%@' where uid = '%@'", kCurrentTableName, execTypeL, uid];
    return sql;
}

#pragma mark - query
- (DemoUser *)selectAccountInfoWhereUID:(NSString *)uid {
    NSString *sql = [self sqlForSelectInfoWhereUID:uid];
    
    NSArray *result = [self query:sql];
    
    NSMutableArray<DemoUser *> *users = [[NSMutableArray alloc] init];
    for (NSDictionary *userDictionary in result) {
        DemoUser *user = [[DemoUser alloc] initWithUserDictionary:userDictionary];
        [users addObject:user];
    }
    
    if (users.count > 0) {
        DemoUser *user = [users objectAtIndex:0];
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
    
    NSArray *result = [self query:sql];
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
