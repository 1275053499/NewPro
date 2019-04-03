//
//  MikoTabBar.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/7/28.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MikoTabBarItem.h"

@protocol MikoTabBarDelegate <NSObject>

- (void)tabBarDidSelectedIconButton:(NSInteger)iconTag;
- (void)tabBarDidSelectedRiseButton;

@end


@interface MikoTabBar : UIView

@property (nonatomic, copy) NSArray<NSDictionary *> *tabBarItemAttributes;
@property (nonatomic, weak) id <MikoTabBarDelegate> delegate;

- (void)setSelectedIndex:(NSInteger)index;


@end
