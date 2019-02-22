//
//  GuidePageView.m
//  CJTotalDemo
//
//  Created by ciyouzen on 2017/10/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "GuidePageView.h"
#import "CJDemoModuleLoginResourceUtil.h"

@implementation GuidePageView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubviewFromXibWithCompleteBlock:nil];
}
    
//知识点：[使用XIB实现嵌套自定义XIB视图](http://blog.csdn.net/u013263917/article/details/49586423)
- (void)addSubviewFromXibWithCompleteBlock:(void (^)(UIView *subview))completeBlock
{
    NSBundle *interfaceBundle = [CJDemoModuleLoginResourceUtil interfaceBundle];

    NSString *nibName = NSStringFromClass([self class]);
    
    //NSArray *views = [interfaceBundle loadNibNamed:nibName owner:self options:nil]; //错误
    UINib *nib = [UINib nibWithNibName:nibName bundle:interfaceBundle];
    NSArray *views = [nib instantiateWithOwner:self options:nil];
    UIView *containerView = [views firstObject];
    [self addSubview:containerView];
    
    //CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //containerView.frame = newFrame;
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    if (completeBlock) {
        completeBlock(containerView);
    }
}

@end
