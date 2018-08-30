//
//  DemoUserTableUtil.h
//  CJDemoModelDemo
//
//  Created by ciyouzen on 2017/10/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CJDemoDatabase/DemoFMDBFileManager.h>
#import "DemoUser.h"

@interface DemoUserTableUtil : NSObject

+ (NSString *)sqlForCreateTable;

#pragma mark - DemoUserTable
+ (BOOL)insertAccountInfo:(DemoUser *)info;
+ (BOOL)removeAccountInfoWhereName:(NSString *)name;

//update
+ (BOOL)updateAccountInfoExceptUID:(DemoUser *)info whereUID:(NSString *)uid;
+ (BOOL)updateAccountInfoImagePath:(NSString *)imagePath whereUID:(NSString *)uid;
+ (BOOL)updateAccountInfoImageUrl:(NSString *)imageUrl whereUID:(NSString *)uid;
+ (BOOL)updateAccountInfoExecTypeL:(NSString *)execTypeL whereUID:(NSString *)uid;

//query
+ (DemoUser *)selectAccountInfoWhereUID:(NSString *)uid;
+ (UIImage *)selectAccountImageWhereUid:(NSString *)uid;


@end
