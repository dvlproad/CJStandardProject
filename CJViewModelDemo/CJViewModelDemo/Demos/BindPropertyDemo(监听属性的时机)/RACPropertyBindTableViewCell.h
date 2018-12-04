//
//  RACPropertyBindTableViewCell.h
//  CJViewModelDemo
//
//  Created by ciyouzen on 12/1/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STDemoTextFieldFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACPropertyBindTableViewCell : UITableViewCell {
    
}
@property (nonatomic, strong) CJTextField *textField;

@property (nonatomic, copy) NSString *codeLabelText;
@property (nonatomic, copy) NSString *codeResultLabelText;

@end

NS_ASSUME_NONNULL_END
