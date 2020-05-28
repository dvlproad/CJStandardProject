//
//  CJFMDBFileManager.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJFileManager.h"
#import "CJFileManager+GetCreatePath.h"

#import <FMDB/FMDB.h>
#import "CJFMDBFileDeleteResult.h"

/**
 *  数据库文件管理类（每个数据库的管理类都必须继承此类，并实现单例方法）
 */
@interface CJFMDBFileManager : CJFileManager {
    
}
@property (nonatomic, copy, readonly) NSString *fileRelativePath;   /**< 当前数据库的相对路径 */


#pragma mark - 创建数据库、数据表
/**
 *  在指定目录创建数据库(每次登录时候必须调用此方法，因为账号可能变更，操作的数据库可能随账号变化而变化)
 *
 *  @param fileRelativePath     指定的目录的路径(可通过CJFileManager的
                                getLocalDirectoryPathType:CJLocalPathTypeRelative...获得)
 *  @param copyDatabasePath     要复制的数据库的路径
 *  @param fileExistAction      如果该指定目录存在则执行什么操作
 *
 *  return 是否创建成功
 */
- (BOOL)createDatabaseInFileRelativePath:(NSString *)fileRelativePath
                      byCopyDatabasePath:(NSString *)copyDatabasePath
                         ifExistDoAction:(CJFileExistAction)fileExistAction;

/**
 *  在指定目录创建数据库(每次登录时候必须调用此方法，因为账号可能变更，操作的数据库可能随账号变化而变化)
 *
 *  @param fileRelativePath     指定的目录的路径(可通过CJFileManager的
                                getLocalDirectoryPathType:CJLocalPathTypeRelative...获得)
 *  @param createTableSqls      创建数据表的sql
 *  @param fileExistAction      如果该指定目录存在则执行什么操作
 *
 *  return 是否创建成功
 */
- (BOOL)createDatabaseInFileRelativePath:(NSString *)fileRelativePath
                       byCreateTableSqls:(NSArray<NSString *> *)createTableSqls
                         ifExistDoAction:(CJFileExistAction)fileExistAction;


/**
 *  重新创建新数据库（新数据库的数据库名和位置和原来的一样）
 *
 *  @param createTableSqls      新数据库数据表的创建语句
 *
 *  return 是否重建成功
 */
- (BOOL)recreateDatabase:(NSArray<NSString *> *)createTableSqls;

#pragma mark - 删除数据库目录/数据库文件
/**
 *  删除当前数据库文件（清除缓存的时候使用）
 *
 *  return 删除后的结果状态
 */
- (CJFMDBFileDeleteResult *)deleteCurrentFMDBFile;

/**
 *  删除数据库所在的文件夹（应用更新的时候使用）
 *
 *  return 是否删除成功
 */
- (BOOL)deleteCurrentFMDBDirectory;

#pragma mark - 数据库表操作
/**
 *  查询数据表（暂未把查询的语句放到和cjExecuteUpdate一起）
 *
 *  @param sql  查询的语句
 *
 *  return  查询结果
 */
- (NSMutableArray *)query:(NSString *)sql;

- (NSMutableArray *)query:(NSString *)sql withCustomChangeBlock:(id (^)(FMResultSet *rs))customChangeBlock;

/**
 *  执行sqls语句
 *
 *  @param sqls             要执行的sql语句
 *
 *  return  是否执行成功
 */
- (BOOL)cjExecuteUpdate:(NSArray<NSString *> *)sqls;

/**
 *  执行sqls语句
 *
 *  @param sqls             要执行的sql语句
 *  @param useTransaction   是否使用事务
 *
 *  return  是否执行成功
 */
- (BOOL)cjExecuteUpdate:(NSArray<NSString *> *)sqls useTransaction:(BOOL)useTransaction;

@end
