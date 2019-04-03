//
//  YJLTools_sub.h
//  KOO
//
//  Created by yanjinlin on 2019/3/25.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJLTools_sub : NSObject
typedef NS_ENUM(NSInteger, TurnType) {
    TurnTypeOfPush,
    TurnTypeOfPresent,
};

+ (UIViewController *)getCurrentVC;//获取当前控制器
+(void)blurEffect:(UIView *)view;//设置毛玻璃效果
+(void)turnToVC:(UIViewController *)viewController Observer:(UIViewController *)observer TurnType:(TurnType)turnType Animated:(BOOL)animated HidesBottomBarWhenPushed:(BOOL)hideBottomBar;
+ (NSString *)getCalculateCache;//计算缓存
+ (void)clearTmpPics;//清除图片缓存
+(NSString *)gettimeWithData:(NSString *)longstr;//10位时间戳转时间2018-09-09
+(NSString *)getsixtimeWithData:(NSString *)longstr;//10位时间戳转时间2018-09-09 12:21:34
+ (NSString *)getTimestampWithDate:(NSDate *)timeDate;//转换时间戳
+ (UIImage *)imageWithColor:(UIColor *)color;//色值转换图片
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;//高斯模糊
+ (void)setGradientLayer:(UIView *)view StarColor:(UIColor *)starColor EndColor:(UIColor *)endColor;//渐变色
+(NSString *)nameaddxx:(NSString *)name;            //姓名加****
+(NSString*)changeTelephone:(NSString*)teleStr;     //号码加****
+(BOOL)ismobileNum:(NSString *)mobileNum;           //验证手机号码
+(BOOL)checkIdentityCardNo:(NSString*)IDNumber;     //验证身份证号码
+ (BOOL)isPureNumandCharacters:(NSString *)string;//判断是否为纯数字
+ (BOOL)openLocationServiceWithBlock:(BOOL)autopupview;//iOS开发检测是否开启定位:
+ (BOOL)openMessageNotificationService;//iOS开发检测是否允许消息推送:
+(void)showNetLinkerErrorViewFromCurrentView:(UIView *)currentView reloadClick:(void(^)(NSInteger index))clickBlock;//展示404页面
+(NSString *)numChangetoStr:(NSInteger )Number;//数字转字符串
+(NSInteger)StrChangetoNum:(NSString* )Str;     //字符串转数字
+(NSString *)timeChangeStr:(NSString *)time;    //服务器时间转换成几分钟 几小时前....
+(float)LogstrTwo:(NSString *)log2 LatstrTwo:(NSString *)lat2 LogstrOne:(NSString *)log1 LatstrOne:(NSString *)lat1;//两个经纬度间距离
+(NSString *)Emojicoding:(NSString *)Text;   //emoji编码UTF-8
+(NSString *)Emojidecoding:(NSString *)Text;//emoji解码UTF-8
+(NSString *)clearSpacestr:(NSString *)text;//去除用户输入的空格号
//https://www.cnblogs.com/mkai/p/6193972.html//去空格方法
+(NSString *)filter:(NSString *)text;           //过滤某些字符
+ (NSString *)removeSpace:(NSString *)string;   //删除空格
+(NSString *)HasFrontStrOrBackStr:(NSString *)text;//判断字符串是否有某一个前缀和后缀
+(BOOL)HasSpecified:(NSString *)text;           //判断字符串是否有某一个子字符串
+(CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;

+ (id)CCGetDataFromModelWithKey:(NSString *)key;
+ (void)CCSaveDataFromModel:(id)dataModel   WithKey:(NSString *)key;

+(NSMutableAttributedString*)YYchangeLabelColorWithText:(NSString*)needText totalStr:(NSString *)total color:(UIColor *)color;

+ (NSString*)deviceVersion;

+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;


@end

NS_ASSUME_NONNULL_END
