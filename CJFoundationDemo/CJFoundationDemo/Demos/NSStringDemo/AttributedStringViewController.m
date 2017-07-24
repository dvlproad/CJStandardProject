//
//  AttributedStringViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzne on 2017/7/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AttributedStringViewController.h"
#import <CJBaseUIKit/UIColor+CJHex.h>

@interface AttributedStringViewController ()

@end

@implementation AttributedStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *string = @"NSParagraphStyleAttributeName 段落的风格";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    /*
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
    paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    paragraphStyle.headIndent = 20;//整体缩进(首行除外)
    paragraphStyle.tailIndent = 20;//
    paragraphStyle.minimumLineHeight = 10;//最低行高
    paragraphStyle.maximumLineHeight = 20;//最大行高
    paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
    paragraphStyle.paragraphSpacingBefore = 22.0f;//段首行空白空间 //Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph.
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;//从左到右的书写方向（一共➡️三种）
    paragraphStyle.lineHeightMultiple = 15; //Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height.
    paragraphStyle.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1
    */
    
    NSDictionary *attributes = @{NSFontAttributeName:           font,
                                 NSForegroundColorAttributeName:[UIColor whiteColor],
                                 NSBackgroundColorAttributeName:[UIColor cjColorWithHexString:@"fe5000"],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    NSRange range = [string rangeOfString:@"NSParagraphStyleAttributeName"];
    [attributedString addAttributes:attributes range:range];
    
    self.textView.attributedText = attributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
