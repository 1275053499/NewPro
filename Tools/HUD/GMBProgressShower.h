//
//  GMBProgressShower.h
//  GOUDIWANG
//
//  Created by 曾国锐 on 2017/11/2.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface GMBProgressShower : NSObject

/**
 展示文本

 @param view 展示文本的view
 @param text 展示文本内容
 @return HUD实例
 */
+ (MBProgressHUD*)showLoadData:(UIView*)view
                          Text:(NSString*)text;

/**
 隐藏hud

 @param view 展示文本的view
 @param animated 隐藏动画
 */
+ (void)hideHUDForView:(UIView *)view
              animated:(BOOL)animated;

/**
 固定时间消失的图片-请求错误

 @param view 展示文本的view
 @param text 展示文本内容
 @param time 动画时间
 */
+(void)showTextInError:(UIView*)view
                  Text:(NSString*)text
                During:(NSTimeInterval)time;

/**
 固定时间消失的图片-请求成功

 @param view 展示文本的view
 @param text 展示文本内容
 @param time 动画时间
 */
+(void)showTextInSucce:(UIView*)view
                  Text:(NSString*)text
                During:(NSTimeInterval)time;

@end
