//
//  GuideViewController.m
//  CJDemoModuleLoginDemo
//
//  Created by ciyouzen on 7/3/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "GuideViewController.h"
#import <EAIntroView/EAIntroView.h>

#import "CJDemoModuleLoginResourceUtil.h"

#import "GuideMainViewController.h"
#import "GuidePageView.h"

@interface GuideViewController () <EAIntroDelegate> {
    
}

@end



@implementation GuideViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSBundle *interfaceBundle = [CJDemoModuleLoginResourceUtil interfaceBundle];
    self = [super initWithNibName:nibNameOrNil bundle:interfaceBundle];
    if (self) {
        
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"引导", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self addGuideViewMethod1];
    [self addGuideViewMethod2];
}

/*
- (void)addGuideViewMethod1 {
    GuideContainerView *guideContainerView = [[GuideContainerView alloc] init];
    [self.view addSubview:guideContainerView];
    [guideContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    guideContainerView.skipHandle = ^{
        [self goGuideMainViewController];
    };
    self.guideContainerView = guideContainerView;
    
    UIImage *image1 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"guide0" ofType:@"png"];
    UIImage *image2 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"guide1" ofType:@"png"];
    UIImage *image3 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"guide2" ofType:@"png"];
    
    GuidePageView *guidePageView1 = [[GuidePageView alloc] init];
    guidePageView1.imageView.image = image1;
    
    GuidePageView *guidePageView2 = [[GuidePageView alloc] init];
    guidePageView2.imageView.image = image2;
    
    GuidePageView *guidePageView3 = [[GuidePageView alloc] init];
    guidePageView3.imageView.image = image3;
    
    [guideContainerView addGuidePageViews:@[guidePageView1, guidePageView2, guidePageView3]];
}
//*/

#pragma mark - EAIntroView
- (void)addGuideViewMethod2 {
    CGFloat pageViewWidth = CGRectGetWidth(self.view.frame);
    CGFloat pageViewHeight = CGRectGetHeight(self.view.frame);
    CGRect pageViewRect = CGRectMake(0, 0, pageViewWidth, pageViewHeight);
    
    //UIImage *image1 = [UIImage imageNamed:@"guide0.png"];
    UIImage *image1 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"guide0" ofType:@"png"];
    UIImage *image2 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"guide1" ofType:@"png"];
    UIImage *image3 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"guide2" ofType:@"png"];
    
    GuidePageView *guidePageView1 = [[GuidePageView alloc] init];
    guidePageView1.imageView.image = image1;
    guidePageView1.button.alpha = 0;
    
    GuidePageView *guidePageView2 = [[GuidePageView alloc] init];
    guidePageView2.imageView.image = image2;
    guidePageView2.button.alpha = 0;
    
    GuidePageView *guidePageView3 = [[GuidePageView alloc] init];
    guidePageView3.imageView.image = image3;
    guidePageView3.button.alpha = 1;
    [guidePageView3.button addTarget:self action:@selector(goGuideMainViewController) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *pageBGImage1 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"bg1" ofType:@"png"];
    UIImage *pageBGImage2 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"bg2" ofType:@"png"];
    UIImage *pageBGImage3 = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"bg3" ofType:@"png"];
    
    [guidePageView1 setFrame:pageViewRect];
    EAIntroPage *page1 = [EAIntroPage pageWithCustomView:guidePageView1];
    //EAIntroPage *page1 = [EAIntroPage pageWithCustomViewFromNibNamed:@"GuidePageView"];
    page1.bgImage = pageBGImage1;
    
    [guidePageView2 setFrame:pageViewRect];
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:guidePageView2];
    page2.bgImage = pageBGImage2;
    
    [guidePageView3 setFrame:pageViewRect];
    EAIntroPage *page3 = [EAIntroPage pageWithCustomView:guidePageView3];
    page3.bgImage = pageBGImage3;
    
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:pageViewRect andPages:@[page1,page2,page3]];
    
    intro.pageControl.alpha = 0;
    intro.skipButton.alpha = 0;
    /*
    //pageControl
    intro.pageControlY = 42.f;
    
    //custom skipButton
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *skipImage = [CJDemoModuleLoginResourceUtil bundleImageNamed:@"skipButton" ofType:@"png"];
    [btn setBackgroundImage:skipImage forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 270, 50)];
    intro.skipButton = btn;
    
    //skipButton
    intro.skipButtonAlignment = EAViewAlignmentCenter;
    intro.skipButtonY = 120.f;
    [intro.skipButton setTitle:@"Skip now" forState:UIControlStateNormal];
    
    // show skipButton only on 3rd page + animation
    intro.skipButton.alpha = 0.f;
    intro.skipButton.enabled = NO;
    page3.onPageDidAppear = ^{
        intro.skipButton.enabled = YES;
        [UIView animateWithDuration:0.3f animations:^{
            intro.skipButton.alpha = 1.f;
        }];
    };
    page3.onPageDidDisappear = ^{
        intro.skipButton.enabled = NO;
        [UIView animateWithDuration:0.3f animations:^{
            intro.skipButton.alpha = 0.f;
        }];
    };
    */
    [intro setDelegate:self];
    intro.tapToNext = YES;
    
    [intro showInView:self.view animateDuration:0.3];
}

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    if(wasSkipped) {
        NSLog(@"Intro skipped");
    } else {
        NSLog(@"Intro finished");
    }
    
    [self goGuideMainViewController];
}



#pragma mark - Event
- (void)goGuideMainViewController {
    GuideMainViewController *vc = [[GuideMainViewController alloc] initWithNibName:@"GuideMainViewController" bundle:nil];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:vc];
    navVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navVC animated:YES completion:NULL];
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
