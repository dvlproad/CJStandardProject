//
//  DemoFMDBFileManager.m
//  CJDemoDatabaseDemo
//
//  Created by ciyouzen on 2016/12/21.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DemoFMDBFileManager.h"

@interface DemoFMDBFileManager ()

@property (nonatomic, strong) NSArray<NSString *> *allCreateTableSqls;

@end


@implementation DemoFMDBFileManager

+ (DemoFMDBFileManager *)sharedInstance {
    static DemoFMDBFileManager *_sharedInstance = nil;
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
    [[DemoFMDBFileManager sharedInstance] createDatabaseInFileRelativePath:fileRelativePath
                                                          byCopyDatabasePath:copyDatabasePath
                                                             ifExistDoAction:CJFileExistActionUseOld];
}

//方法2:create
+ (void)createDatabaseForUserName:(NSString *)databaseName withAllCreateTableSqls:(NSArray<NSString *> *)allCreateTableSqls {
    NSAssert(databaseName != nil && [databaseName length] > 0, @"userName不能为空");
    
    [DemoFMDBFileManager sharedInstance].allCreateTableSqls = allCreateTableSqls;
    
    if ([databaseName hasSuffix:@".db"] == NO) {
        databaseName = [databaseName stringByAppendingString:@".db"];
    }
    
    NSString *directoryRelativePath = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative
                                                            bySubDirectoryPath:@"DB/Account"
                                                         inSearchPathDirectory:NSDocumentDirectory
                                                               createIfNoExist:YES];
    NSString *fileRelativePath = [directoryRelativePath stringByAppendingPathComponent:databaseName];
    
    //方法2:create
    [[DemoFMDBFileManager sharedInstance] createDatabaseInFileRelativePath:fileRelativePath
                                                          byCreateTableSqls:allCreateTableSqls
                                                            ifExistDoAction:CJFileExistActionUseOld];
}

+ (void)reCreateCurrentDatabase {
    NSArray *createTableSqls = [DemoFMDBFileManager sharedInstance].allCreateTableSqls;
    [[DemoFMDBFileManager sharedInstance] recreateDatabase:createTableSqls];
}

+ (BOOL)deleteFMDBDirectory {
    return [[DemoFMDBFileManager sharedInstance] deleteCurrentFMDBDirectory];
}





@end
