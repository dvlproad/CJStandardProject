//
//  STDemoSliderVCElementFactory.h
//  CJRadioDemo
//
//  Created by 李超前 on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJRadioButtonCycleComposeView.h"

@interface STDemoSliderVCElementFactory : NSObject

+ (CJButton *)stdemoRadioButton;
+ (NSArray<NSString *> *)stdemoComponentTitles;
+ (NSMutableArray<UIViewController *> *)stdemoComponentViewControllers;

@end
