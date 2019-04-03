//
//  FZKMianVC.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/7/28.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MikoTabBar.h"
@interface FZKMianVC : UITabBarController<MikoTabBarDelegate>
@property (nonatomic, strong)MikoTabBar *MikoTabBar;
@end
