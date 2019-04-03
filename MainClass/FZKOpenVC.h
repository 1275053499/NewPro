//
//  FZKOpenVC.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/8/2.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FZKOpenVC : UIViewController
@property (nonatomic, copy) void (^finishBlock)(void);
@end
