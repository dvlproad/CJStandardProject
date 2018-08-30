//
//  CJFMDBFileDeleteResult.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 2016/1/4.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJFMDBFileDeleteResult : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *fileRelativePath;

@end
