//
//  DemoMainViewController.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "DemoMainViewController.h"
#import <LGSideMenuController/LGSideMenuController.h>

#import "DemoMineViewController.h"
#import "STDemoOrderHomeViewController.h"
#import "MessageViewController.h"
#import "STDemoNavigationController.h"

#import "STDemoOrderListViewController.h"

@interface DemoMainViewController ()

@end

@implementation DemoMainViewController

- (instancetype)init {
    self = [super initWithRootViewController:({
//        STDemoOrderHomeViewController *home = [[STDemoOrderHomeViewController alloc] init];
        STDemoOrderListViewController *home = [[STDemoOrderListViewController alloc] init];
        STDemoNavigationController *navigation = [[STDemoNavigationController alloc] initWithRootViewController:home];
        navigation;
    }) leftViewController:({
        DemoMineViewController *mine = [[DemoMineViewController alloc] init];
        mine;
    }) rightViewController:nil];
    if (self) {
        self.panGesture.enabled = NO;
        
        self.leftViewWidth = 930.0 / 1242.0 * self.view.bounds.size.width;
        self.leftViewStatusBarHidden = YES;
        self.leftViewSwipeGestureEnabled = NO;
        self.leftViewStatusBarUpdateAnimation = UIStatusBarAnimationSlide;
        self.leftViewStatusBarStyle = UIStatusBarStyleLightContent;
        
        self.rootViewStatusBarUpdateAnimation = UIStatusBarAnimationSlide;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"首页", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
