//
//  NSDictionary+Convert.m
//  CommonAFNUtilDemo
//
//  Created by lichq on 7/31/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import "NSDictionary+Convert.h"

@implementation NSDictionary (Convert)

- (NSString *)convertToString{
    NSString *resultString = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        resultString = [string stringByAppendingString:string];
    }
    return resultString;
}

//从服务器得到的JSON数据解析成NSDictionary后，通过递归遍历多维的NSDictionary可以方便的把字典中的所有键值输出出来方便测试检查。
- (NSString *)convertToString_byCycle{
    NSMutableString *str = [NSMutableString string];
    NSArray *keys = [self allKeys];
    for (NSString *key in keys) {
        if ([[self objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            id obj = [self objectForKey:key];
            [str appendFormat:@"\n%@: %@",key,[obj convertToString_byCycle]];
        }else if ([[self objectForKey:key] isKindOfClass:[NSArray class]]){
            [str appendFormat:@"\n%@:",key];
            for (id obj in [self objectForKey:key]) {
                [str appendFormat:@"\n%@",[obj convertToString_byCycle]];
            }
        }else{
            [str appendFormat:@"\n%@: %@",key,[self objectForKey:key]];
        }
    }
    return str;
}


- (NSData *)convertToData{
    NSData *data = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    }
    return data;
}


@end
