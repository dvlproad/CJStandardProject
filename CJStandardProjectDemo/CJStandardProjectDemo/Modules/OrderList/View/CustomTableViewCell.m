//
//  CustomTableViewCell.m
//  CJStandardProjectDemo
//
//  Created by 李超前 on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.backgroundColor=[UIColor whiteColor];
        _titleLabel.font=[UIFont systemFontOfSize:14];
       
    }
    return self;
}

@end
