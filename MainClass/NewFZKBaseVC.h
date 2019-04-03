//
//  NewFZKBaseVC.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewFZKBaseVC : UIViewController
@property (nonatomic, assign)BOOL showEmpty;//显示无数据
@property (nonatomic, assign)BOOL showEmptyNeterror;//是否网络错误
- (void)makeBackBlackBtn;
- (void)makeBackWhiteBtn;
- (void)makeNavBarColor;
@end

NS_ASSUME_NONNULL_END
