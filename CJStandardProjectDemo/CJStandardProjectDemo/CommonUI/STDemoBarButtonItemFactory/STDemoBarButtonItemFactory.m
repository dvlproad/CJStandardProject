//
//  STDemoBarButtonItemFactory.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/10/12.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "STDemoBarButtonItemFactory.h"

@implementation STDemoBarButtonItemFactory

UIBarButtonItem *demoDoneBarButtonItem(id target, SEL action) {
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", nil) style:UIBarButtonItemStylePlain target:target action:action];
    return doneBarButtonItem;
}

UIBarButtonItem *cjBarButtonItem(id target, NSString *title, SEL action) {
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    return doneBarButtonItem;
}

@end
