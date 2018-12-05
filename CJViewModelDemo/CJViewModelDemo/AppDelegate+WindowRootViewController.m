//
//  AppDelegate+WindowRootViewController.m
//  CJNetworkDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "AppDelegate+WindowRootViewController.h"


#import "BindTextFieldHomeViewController.h"
#import "BindPropertyHomeViewController.h"
#import "ListenSelectedHomeViewController.h"
#import "ListenArrayHomeViewController.h"

#import "ViewModelHomeViewController.h"

@implementation AppDelegate (WindowRootViewController)

- (UIViewController *)getMainRootViewController {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_BG"];
    
    /*
    知识点(UITabBarController):
    ①设置标题tabBarItem.title：为了使得tabBarItem中的title可以和显示在顶部的navigationItem的title保持各自，分别设置.tabBarItem.title和.navigationItem的title的值
    ②设置图片tabBarItem.image：会默认去掉图片的颜色，如果要看到原图片，需要设置图片的渲染模式为UIImageRenderingModeAlwaysOriginal
    ③设置角标tabBarItem.badgeValue：如果没有设置图片，角标默认显示在左上角，设置了图片就会在图片的右上角显示
    */
    BindPropertyHomeViewController *bindPropertyHomeViewController = [[BindPropertyHomeViewController alloc] init];
    bindPropertyHomeViewController.view.backgroundColor = [UIColor whiteColor];
    bindPropertyHomeViewController.navigationItem.title = NSLocalizedString(@"Bind Property首页", nil);
    bindPropertyHomeViewController.tabBarItem.title = NSLocalizedString(@"Bind Property", nil);
    bindPropertyHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *bindPropertyHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:bindPropertyHomeViewController];
    [tabBarController addChildViewController:bindPropertyHomeNavigationController];
    
    BindTextFieldHomeViewController *bindTextFieldHomeViewController = [[BindTextFieldHomeViewController alloc] init];
    bindTextFieldHomeViewController.navigationItem.title = NSLocalizedString(@"Bind TextField首页", nil);
    bindTextFieldHomeViewController.tabBarItem.title = NSLocalizedString(@"Bind TextField", nil);
    bindTextFieldHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //homeViewController. = @"10";
    UINavigationController *bindTextFieldHomeNavigationController = [[UINavigationController alloc] initWithRootViewController:bindTextFieldHomeViewController];
    [tabBarController addChildViewController:bindTextFieldHomeNavigationController];
    
    ListenSelectedHomeViewController *listenSelectedViewController = [[ListenSelectedHomeViewController alloc] init];
    listenSelectedViewController.view.backgroundColor = [UIColor whiteColor];
    listenSelectedViewController.navigationItem.title = NSLocalizedString(@"Listen Selected首页", nil);
    listenSelectedViewController.tabBarItem.title = NSLocalizedString(@"Listen Selected", nil);
    listenSelectedViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *listenSelectedNavigationController = [[UINavigationController alloc] initWithRootViewController:listenSelectedViewController];
    [tabBarController addChildViewController:listenSelectedNavigationController];
    
    ListenArrayHomeViewController *listenArrayHomeViewController = [[ListenArrayHomeViewController alloc] init];
    listenArrayHomeViewController.navigationItem.title = NSLocalizedString(@"Listen Array首页", nil);
    listenArrayHomeViewController.tabBarItem.title = NSLocalizedString(@"Listen Array", nil);
    listenArrayHomeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-settings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *listenArrayNavigationController = [[UINavigationController alloc] initWithRootViewController:listenArrayHomeViewController];
    [tabBarController addChildViewController:listenArrayNavigationController];
    
    ViewModelHomeViewController *homeViewController = [[ViewModelHomeViewController alloc] init];
    homeViewController.navigationItem.title = NSLocalizedString(@"ViewModel首页", nil);
    homeViewController.tabBarItem.title = NSLocalizedString(@"ViewModel", nil);
    homeViewController.tabBarItem.image = [[UIImage imageNamed:@"icons8-home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //homeViewController. = @"10";
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    [tabBarController addChildViewController:homeNavigationController];
    
//    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController, navigationController3, navigationController4] animated:YES];
    
    return tabBarController;
}

@end
