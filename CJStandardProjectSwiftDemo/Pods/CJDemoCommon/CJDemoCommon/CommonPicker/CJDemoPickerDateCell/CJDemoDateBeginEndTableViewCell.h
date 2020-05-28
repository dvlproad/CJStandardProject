//
//  CJDemoDateBeginEndTableViewCell.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/4/1.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  始止日期选择(cell高80)

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <CJDemoCommon/CJDemoDateTextField.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoDateBeginEndTableViewCell : UITableViewCell {
    
}
@property (nonatomic, strong) UILabel *promptTitleLable;
@property (nonatomic, assign) BOOL allowPickDate;   /**< 允许选择日期 */

@property (nonatomic, copy) void(^confirmCompleteBlock)(NSString *beginDateSting, NSString *endDateString);

- (void)updateBeginDateSting:(NSString *)beginDateSting endDateString:(NSString *)endDateString;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
