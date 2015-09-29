//
//  PrivateSetting.h
//  Lee
//
//  Created by lichq on 14-11-6.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

@interface PrivateSetting : NSObject

+ (void)customStatusBar;

+ (void)customNavigationBarAppearance;
+ (void)customizeAppearanceForMenuBar:(UINavigationBar *)navBar;

+ (void)hideStatusBar:(BOOL)isHide;


+ (void)startAnimating;
+ (void)finishAnimating;

@end
