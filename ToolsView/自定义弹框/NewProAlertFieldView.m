//
//  NewProAlertFieldView.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/3.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProAlertFieldView.h"

@implementation NewProAlertFieldView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.frame = [UIScreen mainScreen].bounds;
    
    UITapGestureRecognizer *Ges = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(Tapclick:)];
    
    [self addGestureRecognizer:Ges];//添加到某个视图
}


#pragma mark 点击事件处理
-(void)Tapclick:(UITapGestureRecognizer *)sender{
    //    [self removeFromSuperview];
}


- (IBAction)clickAction:(UIButton *)sender {
    
    self.AlertBlock(sender.tag);
    [self removeFromSuperview];
}


@end
