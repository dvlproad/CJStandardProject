//
//  GuideContainerView.m
//  CJTotalDemo
//
//  Created by ciyouzen on 2017/10/27.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "GuideContainerView.h"

@interface GuideContainerView () {
    
}
@property (nonatomic, weak) UIScrollView *pageScrollView;
@property (nonatomic, weak) UIView *pageContainerView;

@property (nonatomic, weak) UIButton *skipButton;

@end




@implementation GuideContainerView

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
    UIScrollView *pageScrollView = [[UIScrollView alloc] init];
    pageScrollView.pagingEnabled = YES;
    pageScrollView.showsHorizontalScrollIndicator = NO;
    pageScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:pageScrollView];
    [pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
    }];
    self.pageScrollView = pageScrollView;
    
    UIView *pageContainerView = [[UIView alloc] init];
    pageContainerView.backgroundColor = [UIColor clearColor];
    [pageScrollView addSubview:pageContainerView];
    [pageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(pageScrollView);
        make.top.bottom.mas_equalTo(pageScrollView);
        make.width.mas_equalTo(pageScrollView.mas_width).multipliedBy(3).mas_offset(0);
        make.height.mas_equalTo(pageScrollView.mas_height);
    }];
    self.pageContainerView = pageContainerView;
    
    UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [skipButton addTarget:self action:@selector(skipButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:skipButton];
    [skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(40);
        make.right.mas_equalTo(self).mas_equalTo(-40);
        make.bottom.mas_equalTo(self).mas_equalTo(-44);
        make.height.mas_equalTo(100);
    }];
    
}

- (void)skipButtonAction:(UIButton *)skipButton {
    if (self.skipHandle) {
        self.skipHandle();
    }
}


- (void)addGuidePageViews:(NSArray<GuidePageView *> *)guidePageViews {
    UIView *lastViewAddInScrollView = nil;

    NSInteger count = guidePageViews.count;
    for (NSInteger i = 0; i < count; i++) {
        GuidePageView *guidePageView = [guidePageViews objectAtIndex:i];
        [self.pageContainerView addSubview:guidePageView];

        [guidePageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self.pageScrollView);
            make.width.mas_equalTo(self.pageScrollView.mas_width);

            if (lastViewAddInScrollView) {
                make.left.mas_equalTo(lastViewAddInScrollView.mas_right).mas_offset(0);
            } else {
                make.left.mas_equalTo(self.pageScrollView);
            }

        }];

        lastViewAddInScrollView = guidePageView;
    }
}


@end
