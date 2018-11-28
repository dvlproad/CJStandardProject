//
//  STDemoServiceUserManager+UserTable.h
//  STDemoServiceDemo
//
//  Created by ciyouzen on 2017/10/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "STDemoServiceUserManager.h"

#import "DemoFMDBFileManager.h"

#import "STDemoUser.h"

@interface STDemoServiceUserManager (UserTable)

- (NSString *)sqlForCreateTable;

- (BOOL)insertAccountInfo:(STDemoUser *)info;
- (BOOL)removeAccountInfoWhereName:(NSString *)name;

//update
- (BOOL)updateAccountInfoExceptUID:(STDemoUser *)info whereUID:(NSString *)uid;
- (BOOL)updateAccountInfoImagePath:(NSString *)imagePath whereUID:(NSString *)uid;
- (BOOL)updateAccountInfoImageUrl:(NSString *)imageUrl whereUID:(NSString *)uid;
- (BOOL)updateAccountInfoExecTypeL:(NSString *)execTypeL whereUID:(NSString *)uid;

//query
- (STDemoUser *)selectAccountInfoWhereUID:(NSString *)uid;
- (UIImage *)selectAccountImageWhereUid:(NSString *)uid;


@end
