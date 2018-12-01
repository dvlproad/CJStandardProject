//
//  RACTextFieldBindTableViewCell.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 12/1/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACTextFieldBindTableViewCell.h"
#import <CJFoundation/NSString+CJTextSize.h>

@interface RACTextFieldBindTableViewCell () {
    
}
@property (nonatomic, copy) void (^changeTextFieldTextBlock)(void);
@property (nonatomic, copy) void (^changeViewModelTextBlock)(void);
@property (nonatomic, copy) void (^printTextBlock)(void);

@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *codeResultLabel;
@property (nonatomic, strong) UIButton *changeTextFieldTextButton;
@property (nonatomic, strong) UIButton *changeViewModelTextButton;
@property (nonatomic, weak) NSTimer *timer;

@end


@implementation RACTextFieldBindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupChangeTextFieldTextBlock:(void(^)(void))changeTextFieldTextBlock
             changeViewModelTextBlock:(void(^)(void))changeViewModelTextBlock
                       printTextBlock:(void(^)(void))printTextBlock
{
    self.changeTextFieldTextBlock = changeTextFieldTextBlock;
    self.changeViewModelTextBlock = changeViewModelTextBlock;
    self.printTextBlock = printTextBlock;
}

- (void)startListen {
    [self.timer setFireDate:[NSDate date]];
}

- (void)stopListen {
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)changeTextFieldText {
    NSAssert(self.changeTextFieldTextBlock, @"请完善self.changeTextFieldTextBlock");
    self.changeTextFieldTextBlock();
}

- (void)changeViewModelText {
    NSAssert(self.changeViewModelTextBlock, @"请完善self.changeViewModelTextBlock");
    self.changeViewModelTextBlock();
}

- (void)printText {
    NSAssert(self.printTextBlock, @"请完善self.printTextBlock");
    self.printTextBlock();
}

- (void)setupViews {
    self.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(printText) userInfo:nil repeats:YES];
    [self stopListen];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.layer.cornerRadius = 3;
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view]; //使用staticCell的时候只能用self,不能用self.contentView，否则布局会有问题
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.bottom.mas_equalTo(self).mas_offset(-10);
    }];
    
    UIView *parentView = view;
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    codeLabel.backgroundColor = [UIColor clearColor];
    codeLabel.textAlignment = NSTextAlignmentLeft;
    codeLabel.font = [UIFont systemFontOfSize:14];
    codeLabel.numberOfLines = 0;
    codeLabel.text = @"code";
    [parentView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(parentView).mas_offset(10);
        make.centerX.mas_equalTo(parentView);
        make.left.mas_equalTo(parentView).mas_offset(10);
        make.height.mas_equalTo(88);
    }];
    self.codeLabel = codeLabel;
    
    UILabel *codeResultLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    codeResultLabel.backgroundColor = [UIColor clearColor];
    codeResultLabel.textAlignment = NSTextAlignmentLeft;
    codeResultLabel.font = [UIFont systemFontOfSize:17];
    codeResultLabel.numberOfLines = 0;
    codeResultLabel.text = @"codeResult";
    [parentView addSubview:codeResultLabel];
    [codeResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeLabel.mas_bottom);
        make.centerX.mas_equalTo(codeLabel);
        make.left.mas_equalTo(codeLabel);
        make.height.mas_equalTo(88);
    }];
    self.codeResultLabel = codeResultLabel;
    
    CJTextField *textField = [STDemoTextFieldFactory textFieldWithLeftLabelText:@"文本框:"];
    textField.placeholder = @"请输入文本";
    textField.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    [parentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeResultLabel.mas_bottom).mas_offset(2);
        make.centerX.mas_equalTo(codeResultLabel);
        make.left.mas_equalTo(codeResultLabel);
        make.height.mas_equalTo(44);
    }];
    self.textField = textField;
    
    UIButton *changeTextFieldTextButton = [STDemoButtonFactory blueButton];
    [changeTextFieldTextButton setTitle:@"点击以执行使用代码修改文本框的操作" forState:UIControlStateNormal];
    [changeTextFieldTextButton addTarget:self action:@selector(changeTextFieldText) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:changeTextFieldTextButton];
    [changeTextFieldTextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textField.mas_bottom).mas_offset(2);
        make.centerX.mas_equalTo(textField);
        make.left.mas_equalTo(textField);
        make.height.mas_equalTo(44);
    }];
    self.changeTextFieldTextButton = changeTextFieldTextButton;
    
    UIButton *changeViewModelTextButton = [STDemoButtonFactory blueButton];
    [changeViewModelTextButton setTitle:@"改变ViewModel的文本" forState:UIControlStateNormal];
    [changeViewModelTextButton addTarget:self action:@selector(changeViewModelText) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:changeViewModelTextButton];
    [changeViewModelTextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(changeTextFieldTextButton.mas_bottom).mas_offset(2);
        make.centerX.mas_equalTo(changeTextFieldTextButton);
        make.left.mas_equalTo(changeTextFieldTextButton);
        make.height.mas_equalTo(44);
    }];
    self.changeViewModelTextButton = changeViewModelTextButton;
    
    
    // 开始监听文本 + 停止监听文本
    UIButton *startListenTextButton = [STDemoButtonFactory blueButton];
    [startListenTextButton setTitle:@"开始监听文本" forState:UIControlStateNormal];
    [startListenTextButton addTarget:self action:@selector(startListen) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:startListenTextButton];
    
    UIButton *stopListenTextButton = [STDemoButtonFactory blueButton];
    [stopListenTextButton setTitle:@"停止监听文本" forState:UIControlStateNormal];
    [stopListenTextButton addTarget:self action:@selector(stopListen) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:stopListenTextButton];
    
    NSArray<UIButton *> *listenButtons = @[startListenTextButton, stopListenTextButton];
    [listenButtons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:20 tailSpacing:20];
    [listenButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(changeViewModelTextButton.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(parentView).mas_offset(-10);//使得cell自动计算高度
    }];
}

- (void)setCodeLabelText:(NSString *)codeLabelText {
    _codeLabelText = codeLabelText;
    _codeLabel.text = codeLabelText;
    
    CGFloat screentWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = screentWidth - 10 -10;
    CGFloat textHeight = [codeLabelText cjTextHeightWithFont:[UIFont systemFontOfSize:17] infiniteHeightAndMaxWidth:maxWidth];
    [_codeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
}

- (void)setCodeResultLabelText:(NSString *)codeResultLabelText {
    _codeResultLabelText = codeResultLabelText;
    _codeResultLabel.text = codeResultLabelText;
    
    CGFloat screentWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = screentWidth - 10 -10;
    CGFloat textHeight = [codeResultLabelText cjTextHeightWithFont:[UIFont systemFontOfSize:17] infiniteHeightAndMaxWidth:maxWidth];
    [_codeResultLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
