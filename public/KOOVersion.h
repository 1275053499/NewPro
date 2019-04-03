//
//  KOOVersion.h
//  KOO
//
//  Created by yanjinlin on 2019/3/25.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#ifndef KOOVersion_h
#define KOOVersion_h

#define APPLICATION         [UIApplication sharedApplication]
#define APPDLE              (AppDelegate*)[APPLICATION delegate]
// 将NSUserDefaults的实例化定义成宏
#define UserDedaults        [NSUserDefaults standardUserDefaults]
// 将NSUserDefaults同步数据
#define UserDedaultsSyn     [[NSUserDefaults standardUserDefaults] synchronize]
// 将NSNotificationCenter的实例化定义成宏
#define NotificationCenter  [NSNotificationCenter  defaultCenter]
// 屏幕宽度
#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
// 主窗口
#define KEYWINDOW           [UIApplication sharedApplication].keyWindow
// 主视图窗口
#define selfview            self.view


// app版本号
#define DEVICE_APP_VERSION      (NSString *)[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
// app Build版本号
#define DEVICE_APP_BUILD        (NSString *)[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
// 系统版本号（string）
#define DEVICE_OS_VERSION       [[UIDevice currentDevice] systemVersion]
// 系统版本号（float）
#define DEVICE_OS_VERSION_VALUE [DEVICE_OS_VERSION floatValue]
// 字体设置
#define XFont(font)         [UIFont systemFontOfSize:(font)]
//#define XXFont(font)        [UIFont fontWithName:@ "Arial-BoldMT"  size:(font)]
#define XXFont(font)        [UIFont fontWithName:@ "PingFang SC"  size:(font)]


#define IOS8    [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#define IOS7    [[[UIDevice currentDevice]systemVersion] floatValue] == 7.0
#define IOS9    [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0
#define IOS10   [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0
#define IOS10_3 [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.3
#define IOS11   [[[UIDevice currentDevice]systemVersion] floatValue] >= 11.0
#define IOS12   [[[UIDevice currentDevice]systemVersion] floatValue] >= 12.0

#define iPhoneX ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 812)

#define iPhoneXS ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 812)

#define iPhoneXR ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 896)

#define iPhoneXMAX ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 896)

#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)

#define iPhone6Plus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)

#define iPhone5sORiPhone5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.height) == 568)

#define iPhone4 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 480)

//((kScreenHeight == 812.0 || kScreenHeight == 896.0) ? 88 : 64) //X h=812,XR & XR max h=896


#define STATUS_HEIGHT    [[UIApplication sharedApplication] statusBarFrame].size.height//状态栏高度
#define kStatusBarHegiht ((iPhoneX||iPhoneXR||iPhoneXS||iPhoneXMAX)?44.0f:20.0f)// 顶部安全距离
#define kNavHegiht       ((iPhoneX||iPhoneXR||iPhoneXS||iPhoneXMAX)?88.0f:64.0f)// 导航栏高度
#define kTabbarHeight    ((iPhoneX||iPhoneXR||iPhoneXS||iPhoneXMAX)?83.0f:49.0f)// Tabbar高度
#define KIPHONEXPLUST    SCREEN_HEIGHT >= 812//有刘海屏的iphone手机
#define kSafeHeight      ((KIPHONEXPLUST)?34:0)// 底部安全距离



#define kHeaderViewHeight                  44.0f
#define kTableViewCellHeightSmall          44.0f
#define kTableViewCellHeightMiddle         60.0f


#ifdef DEBUG
#define MLLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif


#endif /* KOOVersion_h */
