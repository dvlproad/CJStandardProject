//
//  RACPropertyBindTableViewCell.m
//  CJViewModelDemo
//
//  Created by ciyouzen on 12/1/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "RACPropertyBindTableViewCell.h"
#import <CJFoundation/NSString+CJTextSize.h>

@interface RACPropertyBindTableViewCell () {
    
}
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *codeResultLabel;

@end


@implementation RACPropertyBindTableViewCell

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

- (void)setupViews {
    self.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    
    UIImage *normalImage = [UIImage imageNamed:@"login_username_gray"];
    UIImage *selectedImage = [UIImage imageNamed:@"login_username_blue"];
    CJTextField *textField = [STDemoTextFieldFactory textFieldWithNormalImage:normalImage selectedImage:selectedImage];
    textField.placeholder = NSLocalizedString(@"用户名", nil);
    textField.returnKeyType = UIReturnKeyNext;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [parentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeResultLabel.mas_bottom).mas_offset(2);
        make.centerX.mas_equalTo(codeResultLabel);
        make.left.mas_equalTo(codeResultLabel);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(parentView).mas_offset(-10);//使得cell自动计算高度，有此代码时候，外部不用实现heightForRowAtIndexPath
    }];
    self.textField = textField;
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
