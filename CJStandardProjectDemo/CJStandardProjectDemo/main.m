//
//  main.m
//  CJStandardProjectDemo
//
//  Created by ciyouzen on 2018/8/29.
//  Copyright © 2018年 devlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

void writeMoviesToPlist() {
    NSArray *movies = @[@{@"name" : @"网络谜踪", @"imageUrl" : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2541019743.jpg"},@{@"name" : @"悲伤逆流成河", @"imageUrl" : @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2529701498.jpg"},@{@"name" : @"大象席地而坐", @"imageUrl" : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2511811355.jpg"},@{@"name" : @"碟中谍6：全面瓦解", @"imageUrl" : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2529365085.jpg"},@{@"name" : @"找到你", @"imageUrl" : @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2534471408.jpg"},@{@"name" : @"巴斯特·斯克鲁格斯的歌谣", @"imageUrl" : @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2539127687.jpg"},@{@"name" : @"摄影机不要停！", @"imageUrl" : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2541824676.jpg"},@{@"name" : @"一个明星的诞生", @"imageUrl" : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2524354600.jpg"},@{@"name" : @"江湖儿女", @"imageUrl" : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2533283770.jpg"},@{@"name" : @"昨日青空", @"imageUrl" : @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2533173724.jpg"}];
    
    //路径可以自己选择
    [movies writeToFile:@"/Users/lichaoqian/Desktop/doubanMovie.plist" atomically:YES];
}


int main(int argc, char * argv[]) {
    @autoreleasepool {
        writeMoviesToPlist();
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
