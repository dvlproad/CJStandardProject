//
//  STDemoSliderVCElementFactory.m
//  CJRadioDemo
//
//  Created by 李超前 on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "STDemoSliderVCElementFactory.h"
#import <CJBaseUIKit/UIColor+CJHex.h>
#import "STDemoNormalOrderListViewController.h"
#import "STDemoDDOrderListViewController.h"

@implementation STDemoSliderVCElementFactory

+ (CJButton *)stdemoRadioButton {
    CJButton *radioButton = [[CJButton alloc] init];
    radioButton.layer.masksToBounds = YES;
    radioButton.layer.cornerRadius = 15;
    radioButton.clipsToBounds = YES;
    
    radioButton.backgroundColor = [UIColor colorWithRed:105/255.0 green:193/255.0 blue:243/255.0 alpha:1]; //#69C1F3
    radioButton.textNormalColor = [UIColor blackColor];
    radioButton.textSelectedColor = [UIColor whiteColor];
    
    return radioButton;
}

+ (NSArray<NSString *> *)stdemoComponentTitles {
    return @[NSLocalizedString(@"待配送", nil),
             NSLocalizedString(@"配送中", nil),
             NSLocalizedString(@"已完成", nil)
             ];
}

+ (NSMutableArray<UIViewController *> *)stdemoComponentViewControllers {
    return [NSMutableArray arrayWithArray:
            @[[[STDemoNormalOrderListViewController alloc] init],
              [[STDemoDDOrderListViewController alloc] init],
              [[STDemoDDOrderListViewController alloc] init]
              ]
            ];
}

@end
