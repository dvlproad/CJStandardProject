//
//  GSPageViewController0.m
//  GSUITestDemo
//
//  Created by gersces on 2018/8/29.
//  Copyright © 2018年 gersces. All rights reserved.
//

#import "GSPageViewController0.h"

@interface GSPageViewController0 ()

@end

@implementation GSPageViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *tapLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, 345, 30)];
    tapLabel.backgroundColor = [UIColor redColor];
    tapLabel.textAlignment = NSTextAlignmentCenter;
    tapLabel.text = @"单击";
    [self.view addSubview:tapLabel];
    tapLabel.userInteractionEnabled = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [tapLabel addGestureRecognizer:tap];
    
    
    UILabel *doubleTapLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 150, 345, 30)];
    doubleTapLabel.backgroundColor = [UIColor orangeColor];
    doubleTapLabel.textAlignment = NSTextAlignmentCenter;
    doubleTapLabel.text = @"双击";
    [self.view addSubview:doubleTapLabel];
    doubleTapLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [doubleTapLabel addGestureRecognizer:doubleTap];
    
    
    UILabel *longLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 200, 345, 30)];
    longLabel.backgroundColor = [UIColor yellowColor];
    longLabel.textAlignment = NSTextAlignmentCenter;
    longLabel.text = @"长按";
    [self.view addSubview:longLabel];
    longLabel.userInteractionEnabled = YES;

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 1.0;
    [longLabel addGestureRecognizer:longPress];
    
    
    UILabel *swipeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 250, 345, 30)];
    swipeLabel.backgroundColor = [UIColor greenColor];
    swipeLabel.textAlignment = NSTextAlignmentCenter;
    swipeLabel.text = @"轻扫(right)";
    [self.view addSubview:swipeLabel];
    swipeLabel.userInteractionEnabled = YES;
    swipeLabel.accessibilityIdentifier = @"swipeRight";
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [swipeLabel addGestureRecognizer:swipe];
    
    
    UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(15, 300, 345, 80)];
    scroller.pagingEnabled = YES;
    scroller.contentSize = CGSizeMake(345*3, 80);
    [self.view addSubview:scroller];
    NSArray *colors = @[[UIColor blueColor],[UIColor cyanColor],[UIColor purpleColor]];
    for (int i = 0; i < 3; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(345*i, 0, 345, 80)];
        view.backgroundColor = colors[i];
        [scroller addSubview:view];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    [self showAlertWithTitle:@"单击"];
}
- (void)doubleTapAction:(UITapGestureRecognizer *)sender{
    [self showAlertWithTitle:@"双击"];
}
- (void)longPressAction:(UILongPressGestureRecognizer *)sender{
    [self showAlertWithTitle:@"长按"];
}
- (void)swipeAction:(UISwipeGestureRecognizer *)sender{
    [self showAlertWithTitle:@"轻扫"];
}


- (void)showAlertWithTitle:(NSString *)title{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
