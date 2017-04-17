//
//  DateViewController.m
//  CJFoundationDemo
//
//  Created by dvlproad on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DateViewController.h"

#import <CJBaseUIKit/CJAddSubtractTextField.h>
#import <CJPicker/CJDefaultDatePicker.h>
#import <CJPopupAction/UIView+CJShowExtendView.h>

#import "NSDate+CJDateDistance.h"

@interface DateViewController () {
    
}
@property (nonatomic, strong) CJAddSubtractTextField *dateTextField;
@property (nonatomic) NSDate *currentDate;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.currentDate = [NSDate date];
    
    [self setupChooseDateView];
}


- (void)setupChooseDateView {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.dateTextField = [[CJAddSubtractTextField alloc] initWithFrame:CGRectMake(30, 100, 200, 30)];
    self.dateTextField.text = [dateFormatter stringFromDate:self.currentDate];
    self.dateTextField.hideCursor = YES;
    self.dateTextField.hideMenuController = YES;
    
    __weak typeof(self)weakSelf = self;
    [self.dateTextField addLeftButtonImage:[UIImage imageNamed:@"plus"] withLeftHandel:^(UITextField *textField) {
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = [weakSelf.currentDate cj_yesterday];
        textField.text = [dateFormatter stringFromDate:date];
        
        weakSelf.currentDate = date;
    }];
    [self.dateTextField addRightButtonImage:[UIImage imageNamed:@"plus"] withRightHandel:^(UITextField *textField) {
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = [weakSelf.currentDate cj_tomorrow];
        textField.text = [dateFormatter stringFromDate:date];
        
        weakSelf.currentDate = date;
    }];
    [self.view addSubview:self.dateTextField];
    
    
    CJDefaultDatePicker *datePicker = [[CJDefaultDatePicker alloc] init];
    datePicker.datePicker.datePickerMode = UIDatePickerModeDate;
    __weak typeof(datePicker)weakdatePicker = datePicker;
    [datePicker.toolbar setConfirmHandle:^{
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = weakdatePicker.datePicker.date ;
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        self.dateTextField.text = dateString;
    }];
    /*
    [datePicker setValueChangedHandel:^(UIDatePicker *datePicker) {
        [weakSelf hideDateChoosePicker];
        NSDate *date = datePicker.date ;
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        self.dateTextField.text = dateString;
    }];
    */
    self.dateTextField.inputView = datePicker;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self hideDateChoosePicker];
}

- (void)hideDateChoosePicker {
    [self.dateTextField endEditing:YES];
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
