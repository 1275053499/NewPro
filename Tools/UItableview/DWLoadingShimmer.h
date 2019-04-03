//
//  DWLoadingShimmer.h
//  DWLoadingShimmer
//  预加载覆盖闪动图
//  Created by Dwyane on 2018/11/27.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
// https://github.com/iDwyane/DWLoadingShimmer

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DWLoadingShimmer : NSObject

/* 开始覆盖子控件 */
+ (void)startCovering:(UIView *)view;
/** 停止覆盖子控件 */
+ (void)stopCovering:(UIView *)view;
@end

//[DWLoadingShimmer startCovering:self.tableView];
//[DWLoadingShimmer stopCovering:self.tableView];



NS_ASSUME_NONNULL_END
