//
//  YJLAttributesLabel.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJLAttributesLabel : UILabel
/**
 
 @param text 传入富文本类型的字符串
 @param actionText 要响应事件的字符串
 */
- (void)setAttributesText: (NSMutableAttributedString *)text
               actionText: (NSMutableArray *)actionText
              actionRange:(NSMutableArray *)actionrange;

/**
 点击事件回调
 */
@property (nonatomic , copy) void(^YJLAttributesBlock)(NSString *clicktext);
@end

NS_ASSUME_NONNULL_END
