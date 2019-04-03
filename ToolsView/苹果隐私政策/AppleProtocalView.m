//
//  AppleProtocalView.m
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/30.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import "AppleProtocalView.h"

#define BGHeight 407
#define BGWidth SCREEN_WIDTH-100
@implementation AppleProtocalView


-(void)setUseBgClose:(BOOL)UseBgClose{
    _UseBgClose = UseBgClose;
    _recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    [_recognizerTap setNumberOfTapsRequired:1];
    _recognizerTap.cancelsTouchesInView = NO;
    if (_UseBgClose) {
        [[UIApplication sharedApplication].keyWindow addGestureRecognizer:_recognizerTap];
    }
}

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        
        [self drawView];
    }
    return self;
}
- (void)drawView{
    
    self.pupview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BGWidth, BGHeight)];
    self.pupview.backgroundColor =RGB(255, 255, 255);
    self.pupview.layer.cornerRadius = 10;
    self.pupview.center = self.center;
    [self addSubview: self.pupview];
    
    UILabel *title  = [[UILabel alloc]initWithFrame:CGRectMake(0, 15,  BGWidth, 15)];
    title.text      = @"用户隐私政策概要";
    title.font      = XFont(18);
    title.textAlignment  = NSTextAlignmentCenter;
    title.textColor = RGB(67,67,67);
    [ self.pupview addSubview:title];
    
    UITextView *textview =  [[UITextView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(title.frame)+15,  self.pupview.frame.size.width-40, 280)];
    textview.scrollEnabled = YES;    //设置当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = NO;        //设置是否允许编辑内容，默认为“YES”
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0;
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : RGB(153,153,153),
                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSAttributedString *secondAtt = [[NSAttributedString alloc] initWithString:@"   1.为了加强互动，交流沟通，我们将会使用你的部分必要信息。\n   2.为提供上述服务，我们可能会使用并收集到你网络、联络方式、位置、相册、通知、机型等敏感信息，你有权拒绝或撤回授权。\n   3.未经你同意，我们不会从第三方获取、共享或者对外提供你的信息。\n  4.如你点击不同意，我们将不会对上述敏感信息进行收集，你可以到手机设置中撤回授权,有任何疑问，你可以随时联系我们" attributes:attributes];
    textview.attributedText = secondAtt;
    [ self.pupview addSubview:textview];
    
    
    UIView * line =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textview.frame)+35,  BGWidth, 0.5)];
    line.backgroundColor = RGB(153,153,153);
    [ self.pupview addSubview:line];
    
    UIButton *back1 = [UIButton buttonWithType:UIButtonTypeCustom];
    back1.frame = CGRectMake(10, CGRectGetMaxY(line.frame)+10, (BGWidth-20)/2, 19);
    [back1 setTitle:@"不同意" forState:UIControlStateNormal];
    back1.titleLabel.font = XFont(16);
    [back1 setTitleColor:RGB(249,12,62) forState:UIControlStateNormal];
    [back1 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [ self.pupview addSubview:back1];
    
    
    UIButton *back2 = [UIButton buttonWithType:UIButtonTypeCustom];
    back2.frame = CGRectMake(CGRectGetMaxX(back1.frame), CGRectGetMaxY(line.frame)+10,  (BGWidth-20)/2, 19);
    [back2 setTitle:@"同意" forState:UIControlStateNormal];
    back2.titleLabel.font = XFont(16);
    [back2 setTitleColor:RGB(153,153,153) forState:UIControlStateNormal];
    [back2 addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [ self.pupview addSubview:back2];
    
}


// 点击其他区域关闭弹窗
- (void)handleTapBehind:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint location = [sender locationInView:nil];
        if (![self.pupview pointInside:[self.pupview convertPoint:location fromView:self.pupview.window] withEvent:nil]){
            [self.pupview.window removeGestureRecognizer:sender];
            [self dismiss];
        }
    }
}


-(void)show{
    
    [[UIApplication  sharedApplication].keyWindow addSubview:self];
    self.pupview.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.pupview.alpha = 0;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.pupview.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.pupview.alpha = 1.0;
    } completion:nil];
}

-(void)dismiss{
    
    [UIView animateWithDuration:0.3f animations:^{
        self.pupview.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
        self.pupview.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"YSZC"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self removeFromSuperview];
    }];
}

@end
