//
//  ColorUtil.h
//  LibraryAndUtilDemo
//
//  Created by lichq on 9/18/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface ColorUtil : NSObject

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString; //eg:@"868686"

@end
