//
//  DemoUsePermissionModel.h
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 2016/12/14.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoUsePermissionModel : NSObject

@property (assign, nonatomic) BOOL checked;
@property (assign, nonatomic) NSInteger menuId;
@property (strong, nonatomic) NSString *menuName;
@property (assign, nonatomic) NSInteger menuParent;
@property (assign, nonatomic) NSInteger permission;
@property (assign, nonatomic) BOOL rootNode;
@property (strong, nonatomic) NSString *typeInfo;

@end
