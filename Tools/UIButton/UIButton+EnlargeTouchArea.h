//
//  UIButton+EnlargeTouchArea.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/9/6.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)
//扩大按钮点击范围
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

- (void)setEnlargeEdge:(CGFloat) size;
/*
使用方法
UIButton *button = [UIButton new];
[button setEnlargeEdge:20];
//或者
[button setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
*/
@end
