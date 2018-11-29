//
//  RACTextFieldBindViewController.m
//  CJViewModelDemo
//
//  Created by 李超前 on 11/29/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACTextFieldBindViewController.h"
#import "RACTextFieldBindViewModel.h"
#import "STDemoTextFieldFactory.h"

@interface RACTextFieldBindViewController () {
    
}
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;

@property (nonatomic, strong) RACTextFieldBindViewModel *viewModel;

@end



@implementation RACTextFieldBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
    
    [self bindViewModel];
}

- (void)bindViewModel {
    RACTextFieldBindViewModel *viewModel = [[RACTextFieldBindViewModel alloc] init];
    self.viewModel = viewModel;
    
    // textField1
    RACChannelTo(self.viewModel, text1) = RACChannelTo(self.textField1, text);
    //1、这算双向绑定了吗？如果不是，那这样操作会有什么隐患？怎么重现隐患？
    
    //RACChannelTo(self.textField1, text) = RACChannelTo(self.viewModel, text1);
    //1、怎么在变化的时候打印text的值？？
    
    
    // textField2
    RACChannelTerminal *textFieldChannelTerminal2 = self.textField2.rac_newTextChannel;
    RAC(self.viewModel, text2) = textFieldChannelTerminal2;
    [RACObserve(self.viewModel, text2) subscribe:textFieldChannelTerminal2];
    
    // textField3
    RACChannelTo(self.viewModel, text3) = RACChannelTo(self.textField3, text);
    [self.textField3.rac_textSignal subscribe:RACChannelTo(self.textField3, text)];
    
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self printText];
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)setupViews {
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.backgroundColor = [UIColor cyanColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:20];
    label1.numberOfLines = 0;
    label1.text = @"RACChannelTo(self.textField, text)\n会出现通过键盘给self.textField.text赋值时候，model的值没改变";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(88);
    }];
    CJTextField *textField1 = [STDemoTextFieldFactory textFieldWithLeftLabelText:@"1.键盘改文本"];
    textField1.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField1];
    [textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).mas_offset(0);
        make.centerX.mas_equalTo(label1);
        make.left.mas_equalTo(label1).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    self.textField1 = textField1;
    UIButton *button1 = [STDemoButtonFactory blueButton];
    [button1 setTitle:@"点击以执行使用代码修改文本框<1>的操作" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(changeTextFieldText1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textField1.mas_bottom).mas_offset(0);
        make.centerX.mas_equalTo(textField1);
        make.left.mas_equalTo(textField1).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.backgroundColor = [UIColor cyanColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:20];
    label2.numberOfLines = 0;
    label2.text = @"self.textField.rac_textSignal\n会出现通过代码给self.textField.text赋值时候，model的值没改变";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(button1.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(button1);
        make.left.mas_equalTo(button1).mas_offset(0);
        make.height.mas_equalTo(88);
    }];
    CJTextField *textField2 = [STDemoTextFieldFactory textFieldWithLeftLabelText:@"2.代码改文本"];
    textField2.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField2];
    [textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).mas_offset(0);
        make.centerX.mas_equalTo(label2);
        make.left.mas_equalTo(label2).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    self.textField2 = textField2;
    UIButton *button2 = [STDemoButtonFactory blueButton];
    [button2 setTitle:@"点击以执行使用代码修改文本框<2>的操作" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(changeTextFieldText2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textField2.mas_bottom).mas_offset(0);
        make.centerX.mas_equalTo(textField2);
        make.left.mas_equalTo(textField2).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
    label3.backgroundColor = [UIColor cyanColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:20];
    label3.numberOfLines = 0;
    label3.text = @"结合使用\n都OK";
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(button2.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(button2);
        make.left.mas_equalTo(button2).mas_offset(0);
        make.height.mas_equalTo(88);
    }];
    CJTextField *textField3 = [STDemoTextFieldFactory textFieldWithLeftLabelText:@"3.键盘和代码改文本都OK"];
    textField3.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField3];
    [textField3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label3.mas_bottom).mas_offset(0);
        make.centerX.mas_equalTo(label3);
        make.left.mas_equalTo(label3).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    self.textField3 = textField3;
    UIButton *button3 = [STDemoButtonFactory blueButton];
    [button3 setTitle:@"点击以执行使用代码修改文本框<3>的操作" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(changeTextFieldText3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textField3.mas_bottom).mas_offset(0);
        make.centerX.mas_equalTo(textField3);
        make.left.mas_equalTo(textField3).mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    
    
    UIButton *printButton = [STDemoButtonFactory blueButton];
    [printButton setTitle:@"printText" forState:UIControlStateNormal];
    [printButton addTarget:self action:@selector(printText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:printButton];
    [printButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-20);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(44);
    }];
    
    
    UIButton *changeViewModelTextButton = [STDemoButtonFactory blueButton];
    [changeViewModelTextButton setTitle:@"changeViewModelTextButton" forState:UIControlStateNormal];
    [changeViewModelTextButton addTarget:self action:@selector(changeViewModelText) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeViewModelTextButton];
    [changeViewModelTextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(printButton.mas_top).mas_offset(-20);
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.height.mas_equalTo(44);
    }];
}

- (void)changeViewModelText {
    self.viewModel.text1 = [NSString stringWithFormat:@"%zd", rand()%100];
    self.viewModel.text2 = [NSString stringWithFormat:@"%zd", rand()%100];
    self.viewModel.text3 = [NSString stringWithFormat:@"%zd", rand()%100];
}

- (void)changeTextFieldText1 {
    self.textField1.text = [NSString stringWithFormat:@"%zd", rand()%100];
}

- (void)changeTextFieldText2 {
    self.textField2.text = [NSString stringWithFormat:@"%zd", rand()%100];
}

- (void)changeTextFieldText3 {
    self.textField3.text = [NSString stringWithFormat:@"%zd", rand()%100];
}

- (void)printText {
    NSString *message1 = [NSString stringWithFormat:@"1.viewModel:%@, textField:%@", self.viewModel.text1, self.textField1.text];
    NSString *message2 = [NSString stringWithFormat:@"1.viewModel:%@, textField:%@", self.viewModel.text2, self.textField2.text];
    NSString *message3 = [NSString stringWithFormat:@"1.viewModel:%@, textField:%@", self.viewModel.text3, self.textField3.text];
    NSString *allMessage = [NSString stringWithFormat:@"\n----------------------------\n%@\n%@\n%@\n-\n----------------------------", message1, message2, message3];
    NSLog(@"%@", allMessage);
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
