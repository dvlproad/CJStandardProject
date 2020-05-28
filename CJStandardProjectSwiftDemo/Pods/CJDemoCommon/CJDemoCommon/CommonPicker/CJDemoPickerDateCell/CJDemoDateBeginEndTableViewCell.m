//
//  CJDemoDateBeginEndTableViewCell.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/4/1.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoDateBeginEndTableViewCell.h"
#import <CJBaseUIKit/UIColor+CJHex.h>
#import "CJDemoConnectView.h"

@interface CJDemoDateBeginEndTableViewCell () {
    
}
@property (nonatomic, strong) CJDemoDateTextField *beginDateTextField;
@property (nonatomic, strong) UITextField *endDateTextField;
@property (nonatomic, strong) CJDemoConnectView *dateConnectView;

@end

@implementation CJDemoDateBeginEndTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Setter
- (void)setAllowPickDate:(BOOL)allowPickDate {
    _allowPickDate = allowPickDate;
    self.beginDateTextField.allowPickDate = allowPickDate;
    self.dateConnectView.showWave = !allowPickDate;
}

#pragma mark - Event
- (void)updateBeginDateSting:(NSString *)beginDateSting endDateString:(NSString *)endDateString
{
    [self.beginDateTextField updateTextFieldAndDatePickerWithDateString:beginDateSting];
    self.endDateTextField.text = endDateString;
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *parentView = self.contentView;
    
    [parentView addSubview:self.promptTitleLable];
    [self.promptTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(parentView).mas_offset(15);
        make.centerX.mas_equalTo(parentView);
        make.top.mas_equalTo(parentView).mas_offset(3);
        make.height.mas_equalTo(21);
    }];
    
    [parentView addSubview:self.beginDateTextField];
    [parentView addSubview:self.endDateTextField];
    [@[self.beginDateTextField, self.endDateTextField] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:15 tailSpacing:15];
    [@[self.beginDateTextField, self.endDateTextField] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.promptTitleLable.mas_bottom).mas_offset(12);
        make.height.mas_equalTo(40);
    }];
    
    [parentView addSubview:self.dateConnectView];
    [self.dateConnectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(parentView);
        make.centerY.mas_equalTo(self.beginDateTextField);
        make.size.mas_equalTo(CGSizeMake(20, 14));
    }];
}

- (UILabel *)promptTitleLable {
    if (_promptTitleLable == nil) {
        _promptTitleLable = [[UILabel alloc] init];
        _promptTitleLable.textAlignment = NSTextAlignmentLeft;
        _promptTitleLable.textColor = CJColorFromHexString(@"#333333");
        _promptTitleLable.font = [UIFont systemFontOfSize:15];
        _promptTitleLable.text = NSLocalizedString(@"健康证有效期", nil);
    }
    return _promptTitleLable;
}

- (CJDemoDateTextField *)beginDateTextField {
    if (_beginDateTextField == nil) {
        __weak typeof(self)weakSelf = self;
        _beginDateTextField = [[CJDemoDateTextField alloc] initWithConfirmCompleteBlock:^(NSDate * _Nonnull seletedDate, NSString * _Nonnull seletedDateString) {
            NSDate *nextYearDate = NSCalendarCJHelper_addYears(1, seletedDate);
            NSString *nextYearDateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_stringFromDate:nextYearDate];
            weakSelf.endDateTextField.text = nextYearDateString;
            
            if (weakSelf.confirmCompleteBlock) {
                weakSelf.confirmCompleteBlock(seletedDateString, nextYearDateString);
            }
        }];
        _beginDateTextField.placeholder = NSLocalizedString(@"选择日期", nil);
        _beginDateTextField.maximumDate = [NSDate date];
        _beginDateTextField.minimumDate = NSCalendarCJHelper_addYears(-150, [NSDate date]);
    }
    return _beginDateTextField;
}

- (UITextField *)endDateTextField {
    if (_endDateTextField == nil) {
        _endDateTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        _endDateTextField.textAlignment = NSTextAlignmentCenter;
        _endDateTextField.placeholder = NSLocalizedString(@"自动填写", nil);
        _endDateTextField.backgroundColor = CJColorFromHexString(@"#F9F9F9");
        _endDateTextField.layer.masksToBounds = YES;
        _endDateTextField.layer.cornerRadius = 4;
        _endDateTextField.enabled = NO;
    }
    return _endDateTextField;
}

- (CJDemoConnectView *)dateConnectView {
    if (_dateConnectView == nil) {
        _dateConnectView = [[CJDemoConnectView alloc] initWithFrame :CGRectMake(0, 0, 20, 14) waveMaxHeight:10];
        _dateConnectView.showWave = YES;
    }
    return _dateConnectView;
}


+ (CGFloat)cellHeight {
    return 3+21+12+40+3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
