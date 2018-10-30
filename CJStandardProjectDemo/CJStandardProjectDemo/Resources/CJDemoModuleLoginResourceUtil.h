//
//  STDemoModuleLoginResourceUtil.h
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/4/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface STDemoModuleLoginResourceUtil : NSObject

#pragma mark - Bundle
/**
 *  获取interface(xib,storyboard)所在的bundle
 *
 *  @return interface(xib,storyboard)所在的bundle
 */
+ (NSBundle *)interfaceBundle;

/**
 *  获取image所在的bundle
 *
 *  @return image所在的bundle
 */
+ (NSBundle *)imageBundle;


#pragma mark - GetImage
/**
 *  获取bundle中的图片
 *
 *  @param name 图片的名字
 *  @param typeName 图片的类型(png、jpg)
 *
 *  @return 图片
 */
+ (UIImage *)bundleImageNamed:(NSString *)name ofType:(NSString *)typeName;

@end
