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
    [self setupViews];
    
    [self bindViewModel];
}

- (void)setupViews {
    
}

- (void)bindViewModel {
    RACTextFieldBindViewModel *viewModel = [[RACTextFieldBindViewModel alloc] init];
    self.viewModel = viewModel;
    
    // textField1
    RACChannelTo(self.viewModel, text1) = RACChannelTo(self.textField1, text);
    [self.textField1.rac_textSignal subscribe:RACChannelTo(self.textField1, text)];
    
    // textField2
    RACChannelTo(self.viewModel, text2) = RACChannelTo(self.textField2, text);
    [self.textField2.rac_textSignal subscribe:RACChannelTo(self.textField2, text)];
    
    
    // textField3
    RACChannelTerminal *textFieldChannelTerminal3 = self.textField3.rac_newTextChannel;
    RAC(self.viewModel, text3) = textFieldChannelTerminal3;
    //    [RACObserve(self.viewModel, text3) subscribe:textFieldChannelTerminal3];
}


- (void)implementFlawExampleInCell:(RACTextFieldBindTableViewCell *)cell
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

- (void)implementOKExampleInCell:(RACTextFieldBindTableViewCell *)cell
{
    cell.backgroundColor = [UIColor greenColor];
    
    self.textField2 = cell.textField;
    
    NSString *codeString = @"\
    RACChannelTo(self.viewModel, text2) = RACChannelTo(self.textField2, text);\
    \n\
    [self.textField2.rac_textSignal subscribe:RACChannelTo(self.textField2, text)];";
    cell.codeLabelText = codeString;
    
    NSString *codeResultString = @"额外解决了通过键盘给文本框赋值,model没改变的问题,从而真正实现了双向绑定";
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
