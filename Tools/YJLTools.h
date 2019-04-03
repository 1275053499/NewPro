//
//  YJLTools.h
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/27.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YJLTools : NSObject
+(YJLTools*)Sharemanager;

-(void)CCLoadingViewShow;
-(void)CCLoadingViewDismiss;
/**
 判断字符串是否有中文
 */
-(BOOL)IsChinese:(NSString *)str;//判断字符串是否有中文
/**
 快捷去登录
 */
-(void)GotoLogin:(BOOL)needbackoriginal;//Yes 需要返回个人信息

- (NSString *)cc_GetDeviceIdfa;
- (id)cc_Load:(NSString*)service;
- (void)cc_Save:(NSString*)service data:(id)data;
/**
 字符串是否空
 */
- (NSString *)YYVerifyStrIsEmpty:(NSString *) str;//字符串是否空
/**
 获取当前VC
 */
- (UIViewController *)getCurrentVC;////获取当前VC



/**
 自定义Label
 */
- (UILabel *)labelWithTitle:(NSString *)text Font:(NSInteger)font textColor:(UIColor *)color;

/**
 自定义button
 */
- (UIButton *)buttonWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color Selector:(SEL)btnSelect Target:(UIViewController *)vc;


/**
 自定义View层上button
 */
- (UIButton *)buttonFromViewWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color Selector:(SEL)btnSelect Target:(UIView *)vc;

/**
  获取文字宽度
 */
- (CGFloat)rectTextWidthWithString:(NSString *)string Font:(NSInteger)font TextHeight:(CGFloat)textHeight;
@end


