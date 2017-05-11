//
//  NSData+CJConvert.h
//  CJFoundationDemo
//
//  Created by lichq on 7/31/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CJConvert)

/**
 *  将data转为dictionary
 *
 *  return 返回新的
 */
- (NSDictionary *)cj_convertToDictionary;

@end
