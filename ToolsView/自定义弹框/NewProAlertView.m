//
//  NewProAlertView.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/3.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProAlertView.h"

@implementation NewProAlertView

- (void)drawRect:(CGRect)rect {
    
    self.frame = [UIScreen mainScreen].bounds;

    UITapGestureRecognizer *Ges = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(Tapclick:)];
    
    [self addGestureRecognizer:Ges];//添加到某个视图
    self.alerttitle_1.adjustsFontSizeToFitWidth = YES;
    self.alerttitle_2.adjustsFontSizeToFitWidth = YES;

}

#pragma mark 点击事件处理
-(void)Tapclick:(UITapGestureRecognizer *)sender{
    //    [self removeFromSuperview];
}

- (IBAction)clickAction:(UIButton *)sender {

    self.AlertBlock(sender.tag);
    [self removeFromSuperview];
}

-(void)setIS_single:(BOOL)iS_single{
    
    _iS_single  =  iS_single;
    
    if (iS_single) {
        self.alerttitle_2.hidden    = YES;
        self.SingleLabConstraint.constant =38.0f;
    }else{
        self.alerttitle_2.hidden    = NO;
        self.SingleLabConstraint.constant =32.0f;
    }
    
}

@end
