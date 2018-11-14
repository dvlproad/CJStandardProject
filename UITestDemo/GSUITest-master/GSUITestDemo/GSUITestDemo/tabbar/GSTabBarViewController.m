//
//  GSTabBarViewController.m
//  GSUITestDemo
//
//  Created by gersces on 2018/8/29.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import "GSTabBarViewController.h"
#import "GSPageViewController0.h"
#import "GSPageViewController1.h"
#import "GSPageViewController2.h"
#import "GSPageViewController3.h"

@interface GSTabBarViewController ()

@end

static GSTabBarViewController *_tabbar = nil;

@implementation GSTabBarViewController

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_tabbar) {
            _tabbar = [[GSTabBarViewController alloc]init];
        }
    });
    return _tabbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addChildVc:[[GSPageViewController0 alloc]init] title:@"Page0" image:@"" selectedImage:@""];
    [self addChildVc:[[GSPageViewController1 alloc]init] title:@"Page1" image:@"" selectedImage:@""];
    [self addChildVc:[[GSPageViewController2 alloc]init] title:@"Page2" image:@"" selectedImage:@""];
    [self addChildVc:[[GSPageViewController3 alloc]init] title:@"Page3" image:@"" selectedImage:@""];

}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childVc.title = title;
    
    childVc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:childVc];
    [navc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [navc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    
    [self addChildViewController:navc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
