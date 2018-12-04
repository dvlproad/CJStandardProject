//
//  RACBindTextFieldViewController.m
//  CJViewModelDemo
//
//  Created by 李超前 on 12/1/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACBindTextFieldViewController.h"

@interface RACBindTextFieldViewController ()

@end

@implementation RACBindTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)bindViewModel {
    RACTextFieldBindViewModel *viewModel = [[RACTextFieldBindViewModel alloc] init];
    self.viewModel = viewModel;
    
    NSAssert(self.textField1 || self.textField2 || self.textField3, @"有textField未设置，无法进行下面的绑定，无法测试");
    
    // 知识点：
    // 当通过code改变self.textField.text的值的时候,才会把RACChannelTo(self.textField, text)这个值发送出去
    // 当通过键盘改变self.textField.text的值的时候,才会把self.textField.rac_newTextChannel这个值发送出去
    
    // textField1: 键盘修改textField有问题的例子
    RACChannelTo(self.viewModel, text1) = RACChannelTo(self.textField1, text);
    
    // textField2: 代码修改textField有问题的例子
    RACChannelTo(self.viewModel, text2) = self.textField2.rac_newTextChannel;
    
    // textField3: 键盘和代码修改textField都没问题的例子
    RACChannelTo(self.viewModel, text3) = RACChannelTo(self.textField3, text);
    [self.textField3.rac_textSignal subscribe:RACChannelTo(self.textField3, text)];
    /*
    // 附:[self.textField3.rac_textSignal subscribe:RACChannelTo(self.textField3, text)];简化前的代码如下：
    @weakify(self);
    [self.textField3.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.viewModel.text3 = x;
    }];
    */
    
    // textField4
    //RACChannelTerminal *textFieldChannelTerminal4 = self.textField4.rac_newTextChannel;
    //RAC(self.viewModel, text4) = textFieldChannelTerminal4;
    //[RACObserve(self.viewModel, text4) subscribe:textFieldChannelTerminal4];
}


/// 键盘修改textField有问题的例子
- (void)implementFlawKeyExampleInCell:(RACTextFieldBindTableViewCell *)cell
{
    cell.backgroundColor = [UIColor greenColor];
    
    self.textField1 = cell.textField;
    
    NSString *codeString = @"\
    RACChannelTo(self.viewModel, text1) = RACChannelTo(self.textField1, text);";
    cell.codeLabelText = codeString;
    
    NSString *codeResultString = @"会出现通过键盘给文本框赋值(文本框没收回来)时候，model的值没改变";
    cell.codeResultLabelText = codeResultString;
    
    [cell setupChangeTextFieldTextBlock:^{
        self.textField1.text = [NSString stringWithFormat:@"%d", rand()%100];
        
    } changeViewModelTextBlock:^{
        self.viewModel.text1 = [NSString stringWithFormat:@"%d", rand()%100];
        
    } printTextBlock:^{
        NSString *message1 = [NSString stringWithFormat:@"1.viewModel:%@, textField:%@", self.viewModel.text1, self.textField1.text];
        NSString *allMessage = [NSString stringWithFormat:@"\n----------------------------\n%@\n----------------------------", message1];
        NSLog(@"%@", allMessage);
    }];
}

/// 代码修改textField有问题的例子
- (void)implementFlawCodeExampleInCell:(RACTextFieldBindTableViewCell *)cell
{
    cell.backgroundColor = [UIColor greenColor];
    
    self.textField2 = cell.textField;
    
    NSString *codeString = @"\
    RACChannelTo(self.viewModel, text2) = self.textField2.rac_newTextChannel;";
    cell.codeLabelText = codeString;
    
    NSString *codeResultString = @"会出现通过代码给文本框赋值时候，model的值没改变";
    cell.codeResultLabelText = codeResultString;
    
    [cell setupChangeTextFieldTextBlock:^{
        self.textField2.text = [NSString stringWithFormat:@"%d", rand()%100];
        
    } changeViewModelTextBlock:^{
        self.viewModel.text2 = [NSString stringWithFormat:@"%d", rand()%100];
        
    } printTextBlock:^{
        NSString *message1 = [NSString stringWithFormat:@"2.viewModel:%@, textField:%@", self.viewModel.text2, self.textField2.text];
        NSString *allMessage = [NSString stringWithFormat:@"\n----------------------------\n%@\n----------------------------", message1];
        NSLog(@"%@", allMessage);
    }];
}

/// 键盘和代码修改textField都没问题的例子
- (void)implementOKExampleInCell:(RACTextFieldBindTableViewCell *)cell
{
    cell.backgroundColor = [UIColor greenColor];
    
    self.textField3 = cell.textField;
    
    NSString *codeString = @"\
    RACChannelTo(self.viewModel, text3) = RACChannelTo(self.textField3, text);\
    \n\
    [self.textField3.rac_textSignal subscribe:RACChannelTo(self.textField3, text)];";
    cell.codeLabelText = codeString;
    
    NSString *codeResultString = @"额外解决了通过键盘给文本框赋值,model没改变的问题,从而真正实现了双向绑定";
    cell.codeResultLabelText = codeResultString;
    
    [cell setupChangeTextFieldTextBlock:^{
        self.textField3.text = [NSString stringWithFormat:@"%d", rand()%100];
        
    } changeViewModelTextBlock:^{
        self.viewModel.text3 = [NSString stringWithFormat:@"%d", rand()%100];
        
    } printTextBlock:^{
        NSString *message1 = [NSString stringWithFormat:@"3.viewModel:%@, textField:%@", self.viewModel.text3, self.textField3.text];
        NSString *allMessage = [NSString stringWithFormat:@"\n----------------------------\n%@\n----------------------------", message1];
        NSLog(@"%@", allMessage);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.view endEditing:YES];
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
