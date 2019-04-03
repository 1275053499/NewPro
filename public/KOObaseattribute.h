//
//  KOObaseattribute.h
//  KOO
//
//  Created by yanjinlin on 2019/3/25.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#ifndef KOObaseattribute_h
#define KOObaseattribute_h

#define ISLOGIN             [[HDLoginModel shareLoginModelManager] hasToken]//判断是否登录
#define UserId              [HDUserinfoBaseModel shareUserInfoModelManager].userModel.userId//取缓存的用户id

#define isDebugData         NO         //NO 关闭某些不开放的功能     YES 打开某些不开放的功能
//#define isDebugData         YES         //NO 关闭某些不开放的功能     YES 打开某些不开放的功能

#define USERMODEL           [HDUserinfoBaseModel shareUserInfoModelManager].userModel
#define USERMODELCOMMIT     [[HDUserinfoBaseModel shareUserInfoModelManager]saveUserInfoModel]





//颜色
#define RGBA(r,g,b,a)       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)          RGBA(r,g,b,1.0f)
#define RandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0]
#define RGBForm(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBAForm(rgbValue, a) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define UIScreenBgColor           RGBA(  0,   0,  0,0.4)//遮罩层颜色值
#define MainColor                 RGBA(225, 194, 133, 1) ////主题橘色
#define MainNavColor              RGBA(255, 167, 89,  1)//橘色
#define GreyColor                 RGBA(153, 153, 153, 1)//灰色
#define WhiteColor                RGBA(255, 255, 255, 1)//白色
#define DarkgreyColor             RGBA(102, 102, 102, 1)//深灰色
#define TableViewBackgroundColor  [UIColor groupTableViewBackgroundColor];
//#define kMain_5Color             RGBA(255, 255, 255, 1)//白色
//#define kMain_6Color             RGBA(255, 255, 255, 1)//白色


//判断数据是否为空
#define StringIsEmpty(str)     ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define ArrayIsEmpty(array)    (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define DictIsEmpty(dic)       (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

// 控件尺寸比例
#define ScreenRate         (SCREEN_WIDTH/375.f)
// 实际尺寸
#define SuitSize(size)      ScreenRate * (size)

//判断是否模拟器 1 真 0 否
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR    1
#else
#define SIMULATOR    0
#endif


#define WEAK  @weakify(self);
#define STRONG  @strongify(self);




#define kMainBgColor          RGB(240,242,245)


#endif /* KOObaseattribute_h */
