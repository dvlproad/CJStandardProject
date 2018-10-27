//
//  DemoFMDBFileManager.h
//  CJDemoDatabaseDemo
//
//  Created by ciyouzen on 2016/12/21.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJFile/CJFMDBFileManager.h>

@interface DemoFMDBFileManager : CJFMDBFileManager

+ (DemoFMDBFileManager *)sharedInstance;

//方法1：copy
+ (void)copyDatabaseForUserName:(NSString *)databaseName;

//方法2:create
+ (void)createDatabaseForUserName:(NSString *)databaseName withAllCreateTableSqls:(NSArray<NSString *> *)allCreateTableSqls;

+ (void)reCreateCurrentDatabase;

+ (BOOL)deleteFMDBDirectory;


@end
