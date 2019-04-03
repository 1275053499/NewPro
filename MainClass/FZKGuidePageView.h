//
//  FZKGuidePageView.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/8/2.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GGuidePageBlcok) (UIView *view);
@interface FZKGuidePageView : UIView
@property(nonatomic, copy)GGuidePageBlcok guidePageBlcok;
@end
