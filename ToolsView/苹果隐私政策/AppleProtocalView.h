//
//  AppleProtocalView.h
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/30.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppleProtocalView : UIView
@property (nonatomic,assign) BOOL   UseBgClose;//是否可以点击背景关闭pupview
@property (nonatomic,strong) UIView *pupview ;//pupview
@property (nonatomic,strong) UITapGestureRecognizer *recognizerTap;//背景关闭手势
-(void)show;//pupview显示
-(void)dismiss;//pupview关闭
@end

NS_ASSUME_NONNULL_END
