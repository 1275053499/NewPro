//
//  UIBarButtonItem+Badge.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/9/1.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Badge)
@property (strong, atomic) UILabel *badge;

// Badge value to be display
@property (nonatomic) NSString *badgeValue;
// Badge background color
@property (nonatomic) UIColor *badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *badgeTextColor;
// Badge font
@property (nonatomic) UIFont *badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL shouldAnimateBadge;



// 使用方法
//导入头文件 #import "UIBarButtonItem+Badge.h"
////小角标背景颜色(默认为红色)
//self.navigationItem.leftBarButtonItem.badgeBGColor = [UIColor blueColor];
////小角标字体颜色(默认为白色)
//self.navigationItem.leftBarButtonItem.textColor = [UIColor greenColor];
////小角标个数 (可在网络请求成功里面给小角标赋值)
//self.navigationItem.rightBarButtonItem.badgeValue = @"7";



@end
