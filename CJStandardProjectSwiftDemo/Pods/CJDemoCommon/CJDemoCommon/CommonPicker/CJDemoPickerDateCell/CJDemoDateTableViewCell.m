//
//  CJDemoDateTableViewCell.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/4/1.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoDateTableViewCell.h"
#import "CJDemoDatePickerView.h"

@interface CJDemoDateTableViewCell () {
    
}
@property (nonatomic, strong) CJDemoDatePickerView *datePickerView;           /**< "驾驶证日期"选择视图 */


@end

@implementation CJDemoDateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.datePickerView show];
    }
    // Configure the view for the selected state
}

/// 日期选择视图
- (CJDemoDatePickerView *)datePickerView {
    if (_datePickerView == nil) {
        __weak typeof(self)weakSelf = self;
        _datePickerView = [[CJDemoDatePickerView alloc] initWithCancelHandle:nil confirmHandle:^(NSDate *seletedDate, NSString *seletedDateString) {
            if (weakSelf.confirmCompleteBlock) {
                weakSelf.confirmCompleteBlock(seletedDate, seletedDateString);
            }
        }];
        _datePickerView.maximumDate = [NSDate date];
        _datePickerView.minimumDate = [_datePickerView.dateFormatter dateFromString:@"1900-01-01"];
        
        NSDate *defaultDate = [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_dateFromString:@"2018-09-27"];
        [_datePickerView updateDefaultDate:defaultDate];
        [_datePickerView show];
    }
    return _datePickerView;
}

@end
