//
//  AppDelegate.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


+ (AppDelegate *)appDelegate;

@property (strong, nonatomic) UIWindow *window;

- (void)setSelectedTabBarIndex:(NSInteger)index;//选择tabbar index
@end

