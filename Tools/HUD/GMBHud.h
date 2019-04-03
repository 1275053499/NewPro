//
//  GMBHud.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/7/28.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIImage+GIF.h"
@interface GMBHud : NSObject

/**
 展示文本
 
 @param view 展示文本的view
 @param text 展示文本内容
 @return HUD实例
 */
+ (MBProgressHUD*)showLoadData:(UIView*)view
                          Text:(NSString*)text;

+ (MBProgressHUD*)showLoadData:(UIView*)view
                          Text:(NSString*)text
                        During:(NSTimeInterval)time;;


/**
 隐藏hud
 
 @param view 展示文本的view
 @param animated 隐藏动画
 */
+ (void)hideHUDForView:(UIView *)view
              animated:(BOOL)animated;

/**
 固定时间消失的MB系统图片-请求错误
 
 @param view 展示文本的view
 @param text 展示文本内容
 @param time 动画时间
 */
+(void)showTextInError:(UIView*)view
                  Text:(NSString*)text
                During:(NSTimeInterval)time;

/**
 固定时间消失的MB系统图片-请求成功
 
 @param view 展示文本的view
 @param text 展示文本内容
 @param time 动画时间
 */
+(void)showTextInSucce:(UIView*)view
                  Text:(NSString*)text
                During:(NSTimeInterval)time;



/**
  固定时间消失的自定义GIF图片

 @param view 展示文本的view
 @param text 展示文本内容
 @param time 动画时间
 */
+(void)showTextInCustomImgofGif:(UIView *)view
                           Text:(NSString *)text
                         During:(NSTimeInterval)time;

/**
固定时间消失的自定义PNG图片

 @param view 展示文本的view
 @param text 展示文本内容
 @param time 动画时间
 */
+(void)showTextInCustomImgofPng:(UIView *)view
                           Text:(NSString *)text
                         During:(NSTimeInterval)time;

/**
 固定时间消失的自定义多个PNG图片设置成GIF效果  (需要完善添加图片进来)

 @param view 展示文本的view
 @param text 展示文本内容
 @param time 动画时间
 */
+(void)showTextInCustomMoreImgofPng:(UIView *)view
                               Text:(NSString *)text
                             During:(NSTimeInterval)time;


@end
