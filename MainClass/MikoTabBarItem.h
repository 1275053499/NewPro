//
//  MikoTabBarItem.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/7/28.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MikoTabBarItemType) {
    MikoTabBarItemNormal = 0,
    MikoTabBarItemRise,
};

extern NSString *const kTabBarItemAttributeTitle;// NSString
extern NSString *const kTabBarItemAttributeNormalImageName;// NSString
extern NSString *const kTabBarItemAttributeSelectedImageName;// NSString
extern NSString *const kTabBarItemAttributeType;// NSNumber, LLTabBarItemType


@interface MikoTabBarItem : UIButton

@property (nonatomic, assign) MikoTabBarItemType tabBarItemType;

@end
