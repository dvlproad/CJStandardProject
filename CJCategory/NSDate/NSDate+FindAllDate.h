//
//  NSDate+FindAllDate.h
//  Lee
//
//  Created by lichq on 15/4/9.
//  Copyright (c) 2015年 lichq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJDate.h"

@interface NSDate (FindAllDate)

- (NSMutableArray<CJDate *> *)findAllDateFromDate:(NSDate *)startDate;

@end
