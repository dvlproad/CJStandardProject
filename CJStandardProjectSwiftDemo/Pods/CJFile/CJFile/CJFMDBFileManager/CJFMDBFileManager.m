//
//  CJFMDBFileManager.m
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFMDBFileManager.h"

@interface CJFMDBFileManager () {
    
}
@property (nonatomic, copy, readonly) NSString *fileAbsolutePath;   /**< 当前数据库的绝对路径 */

@end



@implementation CJFMDBFileManager

/**
 *  取消对任何数据库的管理（账号切换的时候使用,即重新登录的时候）
 */
- (void)cancelManagerAnyDatabase {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *managerFileRelativePathKey = [self managerFileRelativePathKey];
    [userDefaults removeObjectForKey:managerFileRelativePathKey];
    [userDefaults synchronize];
}

#pragma mark - 创建数据库、数据表
/** 完整的描述请参见文件头部 */
- (BOOL)createDatabaseInFileRelativePath:(NSString *)fileRelativePath
                      byCopyDatabasePath:(NSString *)copyDatabasePath
               ifExistDoAction:(CJFileExistAction)fileExistAction
{
    [self cancelManagerAnyDatabase];
    
    BOOL canCreate = [self canCreateDatabaseFileInFileRelativePath:fileRelativePath ifExistDoAction:fileExistAction];
    if (canCreate == NO) {
        return NO;
    }
    NSString *homeDirectory = NSHomeDirectory();
    NSString *fileAbsolutePath = [homeDirectory stringByAppendingPathComponent:fileRelativePath];
    
    //复制数据库文件到我们指定的目录
    NSError *error = nil;
    BOOL copySuccess = [[NSFileManager defaultManager] copyItemAtPath:copyDatabasePath toPath:fileAbsolutePath error:&error];
    if (copySuccess) {
        NSLog(@"复制数据库文件%@到指定目录%@成功", [copyDatabasePath lastPathComponent], fileAbsolutePath);
    } else {
        NSLog(@"复制数据库文件%@到指定目录%@失败，因为%@", [copyDatabasePath lastPathComponent], fileAbsolutePath, [error localizedDescription]);
    }
    
    return copySuccess;
}

/** 完整的描述请参见文件头部 */
- (BOOL)createDatabaseInFileRelativePath:(NSString *)fileRelativePath
                       byCreateTableSqls:(NSArray<NSString *> *)createTableSqls
                         ifExistDoAction:(CJFileExistAction)fileExistAction
{
    [self cancelManagerAnyDatabase];
    
    BOOL canCreate = [self canCreateDatabaseFileInFileRelativePath:fileRelativePath ifExistDoAction:fileExistAction];
    if (canCreate == NO) {
        return NO;
    }
    NSString *homeDirectory = NSHomeDirectory();
    NSString *fileAbsolutePath = [homeDirectory stringByAppendingPathComponent:fileRelativePath];
    
    //创建数据库文件到我们指定的目录
    FMDatabase *db = [FMDatabase databaseWithPath:fileAbsolutePath];
    if (![db open]) { //执行open的时候，如果数据库不存在则会自动创建
        NSAssert(NO, @"创建数据库文件失败!", fileAbsolutePath);
        return NO;
        
    } else {
        NSLog(@"创建数据库到指定目录%@成功", fileAbsolutePath);
        for (NSString *createTableSql in createTableSqls) {
            BOOL result = [db executeUpdate:createTableSql];
            if (result == NO) {
                NSLog(@"操作数据表失败:%@", createTableSql);
            }
        }
        
        [db close];
        
        return YES;
    }
}

/** 完整的描述请参见文件头部 */
- (BOOL)recreateDatabase:(NSArray<NSString *> *)createTableSqls {
    CJFMDBFileDeleteResult *deleteResult = [self deleteCurrentFMDBFile];
    
    NSString *fileRelativePath = deleteResult.fileRelativePath;
    BOOL recreateSuccess = [self createDatabaseInFileRelativePath:fileRelativePath
                                                byCreateTableSqls:createTableSqls
                                                  ifExistDoAction:CJFileExistActionRerecertIt];
    return recreateSuccess;
}

#pragma mark - 删除数据库目录/数据库文件
/** 完整的描述请参见文件头部 */
- (CJFMDBFileDeleteResult *)deleteCurrentFMDBFile {
    CJFMDBFileDeleteResult *deleteResult = [[CJFMDBFileDeleteResult alloc] init];
    
    NSString *fileRelativePath = self.currentFileRelativePath;
    
    deleteResult.fileRelativePath = fileRelativePath;
    
    BOOL deleteFileSuccess = NO;
    if ([fileRelativePath length] == 0) {
        deleteResult.success = YES;
        
        //NSLog(@"总结：删除%@数据库文件：%@, 因为该文件路径不存在，默认删除成功(比如这里有可能是重复删除)", deleteResult.fileRelativePath, deleteResult.success ? @"成功":@"失败");
        return deleteResult;
        
    } else {
        NSString *home = NSHomeDirectory();
        NSString *fileAbsolutePath = [home stringByAppendingPathComponent:fileRelativePath];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        deleteFileSuccess = [fileManager removeItemAtPath:fileAbsolutePath error:nil];
        if (deleteFileSuccess) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *fileRelativePathKey = [self fileRelativePathKey];
            
            [userDefaults removeObjectForKey:fileRelativePathKey];
            _fileRelativePath = nil;
        }
        deleteResult.success = deleteFileSuccess;
        
        //NSLog(@"总结：删除%@数据库文件：%@", deleteResult.fileRelativePath, deleteResult.success ? @"成功":@"失败");
        return deleteResult;
    }
}

/** 完整的描述请参见文件头部 */
- (BOOL)deleteCurrentFMDBDirectory {
    NSString *fileAbsolutePath = self.fileAbsolutePath; //重启后为空
    
    NSString *lastPathComponent = [fileAbsolutePath lastPathComponent];
    NSString *directoryAbsolutePath = [self.fileAbsolutePath substringToIndex:self.fileAbsolutePath.length-(lastPathComponent.length+1) - 1];
    
    BOOL deleteDirectorySuccess = NO;
    if ([directoryAbsolutePath length] == 0) {
        //NSLog(@"文件夹不存在，默认删除成功");
        deleteDirectorySuccess = YES;
        
    } else {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        deleteDirectorySuccess = [fileManager removeItemAtPath:directoryAbsolutePath error:nil];
    }
    if (deleteDirectorySuccess) {

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:[self fileRelativePath]];
        
        _fileRelativePath = nil;
    }
    
    return deleteDirectorySuccess;
}



#pragma mark - 数据库表操作
- (NSMutableArray *)query:(NSString *)sql {
    return [self query:sql withCustomChangeBlock:nil];
    
}

- (NSMutableArray *)query:(NSString *)sql withCustomChangeBlock:(id (^)(FMResultSet *rs))customChangeBlock
{
    NSAssert(sql, @"sql cannot be nil!");
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:self.fileAbsolutePath];
    BOOL isOpenSuccess = [db open];
    if (!isOpenSuccess) {
        NSLog(@"打开数据库失败");
        return nil;
    }
    
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        if (customChangeBlock == nil) {
            NSDictionary *dictionary = [rs resultDictionary];
            [result addObject:dictionary];
        } else {
            id model = customChangeBlock(rs);
            [result addObject:model];
        }
    }
    
    [db close];
    db = nil;
    
    return result;
}

/** 完整的描述请参见文件头部 */
- (BOOL)cjExecuteUpdate:(NSArray<NSString *> *)sqls {
    return [self executeUpdate:sqls args:nil useTransaction:NO];
}

/** 完整的描述请参见文件头部 */
- (BOOL)cjExecuteUpdate:(NSArray<NSString *> *)sqls useTransaction:(BOOL)useTransaction {
    return [self executeUpdate:sqls args:nil useTransaction:useTransaction];
}

#pragma mark - private method

- (BOOL)executeUpdate:(NSArray<NSString *> *)sqls args:(NSArray *)args useTransaction:(BOOL)useTransaction
{
    FMDatabase *db = [FMDatabase databaseWithPath:self.fileAbsolutePath];
    BOOL isOpenSuccess = [db open];
    if (!isOpenSuccess) {
        NSLog(@"打开数据库失败");
        return NO;
    }
    
    //数据库打开成功的前提下
    BOOL findExecuteFailure = NO;
    if (useTransaction) {
//        NSDate *dateBeigin = [NSDate date];
        
        [db beginTransaction];
        BOOL isRollBack = NO;   //是否回滚到最初状态
        @try {
            findExecuteFailure = [self doSql:sqls inDatabase:db];
            
        } @catch (NSException *exception) {
            isRollBack = YES;
            [db rollback];
            
        } @finally {
            if (!isRollBack) {
                [db commit];
            }
        }
        
//        NSDate *dateEnd = [NSDate date];
//        NSTimeInterval timeInterval = [dateEnd timeIntervalSince1970] - [dateBeigin timeIntervalSince1970];
//        NSLog(@"  使用事务用时%.6lf秒", timeInterval);
        
    }else{
//        NSDate *dateBeigin = [NSDate date];
        
        findExecuteFailure = [self doSql:sqls inDatabase:db];
        
//        NSDate *dateEnd = [NSDate date];
//        NSTimeInterval timeInterval = [dateEnd timeIntervalSince1970] - [dateBeigin timeIntervalSince1970];
//        NSLog(@"不使用事务用时%.6lf秒", timeInterval);
        
    }
    
    [db close];
    
    db = nil;
    
    return findExecuteFailure;
}

- (BOOL)doSql:(NSArray<NSString *> *)sqls inDatabase:(FMDatabase *)db {
    BOOL findExecuteFailure = NO;
    
    NSInteger sqlCount = sqls.count;
    for (NSInteger i = 0; i < sqlCount; i++) {
        NSString *sql = [sqls objectAtIndex:i];
        NSAssert(sql, @"sql cannot be nil!");
        
        BOOL executeSuccess = [db executeUpdate:sql withArgumentsInArray:nil];
        if (executeSuccess == NO) {
            findExecuteFailure = YES;
            NSLog(@"第%zd条%@执行失败", i, sql);
        }
    }

    return findExecuteFailure;
}

#pragma mark - Setter
/**
 *  通过数据库的相对路径，判断数据库是否已经存在或生成（如果存在进行指定的操作，如果不存在不进行操作并返回YES）
 *
 *  @param fileRelativePath     新建的数据库的相对路径(可通过CJFileManager的
 getLocalDirectoryPathType:CJLocalPathTypeRelative...获得)
 *  @param fileExistAction      如果存在执行什么操作
 *
 *  return  是否新建成功
 */
- (BOOL)canCreateDatabaseFileInFileRelativePath:(NSString *)fileRelativePath
                                ifExistDoAction:(CJFileExistAction)fileExistAction {
    //保存本类当前操作的具体数据库，用于在账户切换的时候，先取消对之前具体的数据库的控制，进而控制新的数据库
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *managerFileRelativePathKey = [self managerFileRelativePathKey];
    NSString *managerFileRelativePath = [userDefaults objectForKey:[self managerFileRelativePathKey]];
    if ([managerFileRelativePath length] > 0 && ![managerFileRelativePath isEqualToString:fileRelativePath]) {
        NSAssert(NO, @"%@数据库控制器已用来管理数据库%@,请重新选择其他控制器来管理%@。或者您可以在创建/复制数据库前，通过cancelManagerAnyDatabase方法来取消%@对之前的数据库%@的管理，以此来让它管理现在的数据库%@", NSStringFromClass([self class]), managerFileRelativePath, fileRelativePath, NSStringFromClass([self class]), managerFileRelativePath, fileRelativePath);
    }
    [userDefaults setObject:fileRelativePath forKey:managerFileRelativePathKey];
    
    NSString *fileRelativePathKey = [self fileRelativePathKey];
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:fileRelativePath forKey:fileRelativePathKey];
    [userDefaults synchronize];
    
    NSString *home = NSHomeDirectory();
    NSString *fileAbsolutePath = [home stringByAppendingPathComponent:fileRelativePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileAbsolutePath]) {
        if (fileExistAction == CJFileExistActionShowError) {
            NSAssert(NO, @"创建数据库到指定目录失败，因为该目录已存在同名文件%@ !", fileAbsolutePath);
            return NO;
            
        } else if (fileExistAction == CJFileExistActionUseOld) {
            //NSLog(@"该目录已存在同名文件%@ !，故不重复创建，继续使用之前的", databasePath);
            return NO;
            
        } else if (fileExistAction == CJFileExistActionRerecertIt) {
            [self deleteCurrentFMDBFile]; //会将_fileRelativePath设为nil
        }
    }
    
    _fileRelativePath = fileRelativePath;
    
    return YES;
}


#pragma mark - Getter
- (NSString *)fileAbsolutePath {
    NSString *home = NSHomeDirectory();
    NSString *fileAbsolutePath = [home stringByAppendingPathComponent:self.currentFileRelativePath];
    
    return fileAbsolutePath;
}

- (NSString *)currentFileRelativePath {
    if (_fileRelativePath && [_fileRelativePath length] > 0) {
        return _fileRelativePath;
    }
    
    //重启后内存释放会导致获取不到，所以之前要保存fileRelativePath到plist，以备此时使用
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *fileRelativePath = [userDefaults objectForKey:self.fileRelativePathKey];
    
    return fileRelativePath;
}

- (NSString *)managerFileRelativePathKey {
    NSString *currentFMDBFileManagerName = NSStringFromClass([self class]); //加前缀是为了区分key的不同
    NSString *managerFileRelativePathKey = [NSString stringWithFormat:@"%@_%@", currentFMDBFileManagerName, @"managerFileRelativePathKey"]; /**< 该数据库管理器被用来管理哪个数据库(如果为空，则表示该数据库管理器未被使用来管理任何数据库)  */
    
    return managerFileRelativePathKey;
}

- (NSString *)fileRelativePathKey {
    NSString *currentFMDBFileManagerName = NSStringFromClass([self class]); //加前缀是为了区分key的不同
    NSString *fileRelativePathKey = [NSString stringWithFormat:@"%@_%@", currentFMDBFileManagerName, @"fileRelativePathKey"];
    
    return fileRelativePathKey;
}




@end
