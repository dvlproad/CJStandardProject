//
//  NSDictionary+Convert.h
//  CommonAFNUtilDemo
//
//  Created by lichq on 7/31/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Convert)

- (NSString *)convertToString;
- (NSString *)convertToString_byCycle;
- (NSData *)convertToData;

@end
