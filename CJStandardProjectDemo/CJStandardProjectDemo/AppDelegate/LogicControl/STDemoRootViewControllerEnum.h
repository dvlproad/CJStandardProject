//
//  STDemoRootViewControllerEnum.h
//  CJStandardProjectDemo
//
//  Created by 李超前 on 10/29/18.
//  Copyright © 2018 devlproad. All rights reserved.
//

#ifndef STDemoRootViewControllerEnum_h
#define STDemoRootViewControllerEnum_h

/**
 *  启动页类型
 */
typedef NS_ENUM(NSUInteger, STDemoRootViewControllerType) {
    STDemoRootViewControllerTypeNone,
    STDemoRootViewControllerTypeGuide = 1,  /**< 引导页 */
    STDemoRootViewControllerTypeLogin,      /**< 登录页 */
    STDemoRootViewControllerTypeMain,       /**< 主页 */
};

#endif /* STDemoRootViewControllerEnum_h */
