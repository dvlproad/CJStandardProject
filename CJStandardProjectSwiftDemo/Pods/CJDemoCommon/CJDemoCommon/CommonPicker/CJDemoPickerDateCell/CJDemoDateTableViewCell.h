//
//  CJDemoDateTableViewCell.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/4/1.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoDateTableViewCell : UITableViewCell {
    
}
@property (nonatomic, copy) void(^confirmCompleteBlock)(NSDate *seletedDate, NSString *seletedDateString);

@end

NS_ASSUME_NONNULL_END
