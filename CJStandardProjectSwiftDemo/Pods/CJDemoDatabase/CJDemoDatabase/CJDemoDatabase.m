//
//  CJDemoDatabase.m
//  CJDemoDatabaseDemo
//
//  Created by ciyouzen on 2016/12/21.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDemoDatabase.h"

@interface CJDemoDatabase ()

@property (nonatomic, strong) NSArray<NSString *> *allCreateTableSqls;

@end


@implementation CJDemoDatabase

+ (CJDemoDatabase *)sharedInstance {
    static CJDemoDatabase *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

//方法1：copy
+ (void)copyDatabaseForUserName:(NSString *)databaseName {
    NSAssert(databaseName != nil && [databaseName length] > 0, @"userName不能为空");
    
    if ([databaseName hasSuffix:@".db"] == NO) {
        databaseName = [databaseName stringByAppendingString:@".db"];
    }
    
    NSString *directoryRelativePath = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative
                                                            bySubDirectoryPath:@"DB/Account"
                                                         inSearchPathDirectory:NSDocumentDirectory
                                                               createIfNoExist:YES];
    NSString *fileRelativePath = [directoryRelativePath stringByAppendingPathComponent:databaseName];
    
    //方法1：copy
    NSString *copyDatabasePath = [[NSBundle mainBundle] pathForResource:databaseName ofType:nil];
    [[CJDemoDatabase sharedInstance] createDatabaseInFileRelativePath:fileRelativePath
                                                          byCopyDatabasePath:copyDatabasePath
                                                             ifExistDoAction:CJFileExistActionUseOld];
}

//方法2:create
+ (void)createDatabaseForUserName:(NSString *)databaseName withAllCreateTableSqls:(NSArray<NSString *> *)allCreateTableSqls {
    NSAssert(databaseName != nil && [databaseName length] > 0, @"userName不能为空");
    
    [CJDemoDatabase sharedInstance].allCreateTableSqls = allCreateTableSqls;
    
    if ([databaseName hasSuffix:@".db"] == NO) {
        databaseName = [databaseName stringByAppendingString:@".db"];
    }
    
    NSString *directoryRelativePath = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative
                                                            bySubDirectoryPath:@"DB/Account"
                                                         inSearchPathDirectory:NSDocumentDirectory
                                                               createIfNoExist:YES];
    NSString *fileRelativePath = [directoryRelativePath stringByAppendingPathComponent:databaseName];
    
    //方法2:create
    [[CJDemoDatabase sharedInstance] createDatabaseInFileRelativePath:fileRelativePath
                                                          byCreateTableSqls:allCreateTableSqls
                                                            ifExistDoAction:CJFileExistActionUseOld];
}

+ (void)reCreateCurrentDatabase {
    NSArray *createTableSqls = [CJDemoDatabase sharedInstance].allCreateTableSqls;
    [[CJDemoDatabase sharedInstance] recreateDatabase:createTableSqls];
}

+ (BOOL)deleteFMDBDirectory {
    return [[CJDemoDatabase sharedInstance] deleteCurrentFMDBDirectory];
}





@end
