//
//  NewProAlertFieldView.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/3.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewProAlertFieldView : UIView
@property (weak, nonatomic) IBOutlet UIView     *BGview;
@property (weak, nonatomic) IBOutlet UIButton   *rightbtn;
@property (weak, nonatomic) IBOutlet UIButton   *leftbtn;
@property (nonatomic,copy ) void(^AlertBlock) (NSInteger index);//初始化


@end

NS_ASSUME_NONNULL_END
