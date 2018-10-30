//
//  STDemoModuleLoginResourceUtil.m
//  STDemoModuleLoginDemo
//
//  Created by ciyouzen on 2018/4/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJDemoModuleLoginResourceUtil.h"

@implementation STDemoModuleLoginResourceUtil

/* //参考：[SVProgressHUD](https://github.com/SVProgressHUD)
+ (UIImage *)image {
    NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
    NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    _errorImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];
}
*/

#pragma mark - Bundle
/* 完整的描述请参见文件头部 */
+ (NSBundle *)interfaceBundle {
#ifdef STDemoModuleLoginInMain  //当模块代码是直接拷贝的时候，直接使用mainBundle即可。
    return [NSBundle mainBundle];
#else                           //pod的时候由于有bundle一定要使用如下
    NSBundle *bundle = [NSBundle bundleForClass:[STDemoModuleLoginResourceUtil class]];
    NSURL *bundleURL = [bundle URLForResource:@"STDemoModuleLoginResources" withExtension:@"bundle"];
    //NSURL *interfacesBundleURL = [bundleURL URLByAppendingPathComponent:@"interfaces"];
    NSURL *interfacesBundleURL = bundleURL;
    
    NSBundle *interfaceBundle = [NSBundle bundleWithURL:interfacesBundleURL];
    return interfaceBundle;
#endif
}

/* 完整的描述请参见文件头部 */
+ (NSBundle *)imageBundle {
#ifdef STDemoModuleLoginInMain  //当模块代码是直接拷贝的时候，直接使用mainBundle即可。
    return [NSBundle mainBundle];
#else                           //pod的时候由于有bundle一定要使用如下
    NSBundle *bundle = [NSBundle bundleForClass:[STDemoModuleLoginResourceUtil class]];
    NSURL *bundleURL = [bundle URLForResource:@"STDemoModuleLoginResources" withExtension:@"bundle"];
    //NSURL *imageBundleURL = [bundleURL URLByAppendingPathComponent:@"images"];
    NSURL *imageBundleURL = bundleURL;
    
    NSBundle *imageBundle = [NSBundle bundleWithURL:imageBundleURL];
    return imageBundle;
#endif
}

#pragma mark - GetImage
/* 完整的描述请参见文件头部 */
+ (UIImage *)bundleImageNamed:(NSString *)name ofType:(NSString *)typeName {
    return [self bundleImageNamed:name ofType:typeName inBundle:[self imageBundle]];
}

#pragma mark - Private
+ (UIImage *)bundleImageNamed:(NSString *)name ofType:(NSString *)typeName inBundle:(NSBundle *)bundle {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:typeName]];
#else
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:typeName]];
    }
#endif
}


@end
