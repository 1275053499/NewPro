//
//  FZKOpenVC.m
//  FanZuKe
//
//  Created by yanjinlin on 2018/8/2.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import "FZKOpenVC.h"

@interface FZKOpenVC (){
    NSTimer *timer;
    UIButton *cancelBtn;
    int num;
}
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation FZKOpenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    num     = 5;
    [self setADimage];
    [self setCancelBtn];
    [self setTimer];
}

- (void)setADimage{
    
    _bgImageView       = [[UIImageView alloc] init];
  
    
//    NSLog(@"1111111===:%@",[GMNTools deviceVersion]);
//    NSLog(@"2222222===:%@",[[UIDevice currentDevice] model]);
    
    if ([[YJLTools_sub deviceVersion] isEqualToString:@"iPhone X"]) {
         _bgImageView.image = [UIImage imageNamed:@"IOS_lauchX"];
        
    }else if([[YJLTools_sub deviceVersion] isEqualToString:@"iPhone XS"]) {
        _bgImageView.image = [UIImage imageNamed:@"IOS_lauchX"];
        
    }
    else if ([[YJLTools_sub deviceVersion] isEqualToString:@"iPhone XR"]) {
        _bgImageView.image = [UIImage imageNamed:@"IOS_lauchXR"];
        
        
    }else if ([[YJLTools_sub deviceVersion] isEqualToString:@"iPhone XS Max"]) {
        _bgImageView.image = [UIImage imageNamed:@"IOS_lauchXSMax"];
        
    }else{
        
         _bgImageView.image = [UIImage imageNamed:@"IOS_lauch"];
    }
    
    [self.view addSubview:_bgImageView];
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)setCancelBtn{
    
    cancelBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(SCREEN_WIDTH-70, 20, 60, 60);
    if (KIPHONEXPLUST) {
        cancelBtn.y = 40;
    }
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setTitle:@"跳过\n5s" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font             = XFont(13);
    cancelBtn.titleLabel.lineBreakMode    = 0;
    cancelBtn.adjustsImageWhenHighlighted = NO;
    cancelBtn.titleLabel.textAlignment    = NSTextAlignmentCenter;
    [cancelBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"倒计时背景"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissAD) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
}

- (void)setTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tickDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)tickDown{
    if (num > 1) {
        num --;
        [cancelBtn setTitle:[NSString stringWithFormat:@"跳过\n%is",num] forState:UIControlStateNormal];
        
    }else{
        [self dismissAD];
    }
}

- (void)dismissAD{
    
    [timer invalidate];
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
        if (self->_finishBlock) {
            self->_finishBlock();
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
