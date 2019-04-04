//
//  CCHudShowView.m
//  waterPull
//
//  Created by chenying on 2018/7/13.
//  Copyright © 2018年 chocolate. All rights reserved.
//

#import "CCHudShowView.h"
@interface CCHudShowView()
@property (weak, nonatomic) IBOutlet UIImageView *loadingImage;
@property (strong,nonatomic)NSTimer *textMovetimer;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@end
@implementation CCHudShowView

- (void)drawRect:(CGRect)rect {
    
    self.frame = [UIScreen mainScreen].bounds;
    _showLabel.text = @"拼命加载中...";
//    [self  drawAnimiationImageView:YES];
//    [self  drawAnimationImageViewLoading];
    [self drawGradientaLayerAmination];
}
// 翻转
- (void)drawAnimiationImageView:(BOOL)isImageView
{
    NSString *keyPath = isImageView ? @"transform.rotation.y" : @"transform.rotation.z" ;
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue=@(0);
    animation.toValue=@(M_PI*2);
    animation.duration=isImageView ? 1.3 : .8;
    animation.repeatCount=HUGE;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.loadingImage.layer addAnimation:animation forKey:@"animation"];
}
//贝塞尔
- (void)drawAnimationImageViewLoading
{
    CGPoint centerPoint= CGPointMake(self.loadingImage.frame.size.width/2.0f, self.loadingImage.frame.size.height/2.0f) ;
    UIBezierPath *beizPath=[UIBezierPath bezierPathWithArcCenter:centerPoint radius:centerPoint.x startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    CAShapeLayer *centerLayer=[CAShapeLayer layer];
    centerLayer.path=beizPath.CGPath;
    centerLayer.fillColor=[UIColor clearColor].CGColor;//填充色
    centerLayer.strokeColor=[UIColor orangeColor].CGColor;//边框颜色
    centerLayer.lineWidth=2.0f;
    centerLayer.lineCap=kCALineCapRound;//线框类型
    
    [self.loadingImage.layer addSublayer:centerLayer];
}

//菊花贝塞尔
- (void)drawGradientaLayerAmination
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    
    CGFloat layerRadius = self.loadingImage.frame.size.width/2*1.0f ;
    shapeLayer.frame = CGRectMake(.0f, .0f,  layerRadius*2.f+3,  layerRadius*2.f+3) ;
    
    CGFloat cp = layerRadius+3/2.f;
    UIBezierPath *p = [UIBezierPath bezierPathWithArcCenter:CGPointMake(cp, cp) radius:layerRadius startAngle:.0f endAngle:.75f*M_PI clockwise:YES];
    shapeLayer.path = p.CGPath;
    
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.lineWidth=2.0f;
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(.0f, .5f);
    gradientLayer.endPoint = CGPointMake(1.f, .5f);
    gradientLayer.frame = shapeLayer.frame ;
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:6];
    for(int i=10;i>=0;i-=2) {
        [tempArray addObject:(__bridge id)RGB(118,202,138).CGColor];
    }
    gradientLayer.colors = tempArray;
    gradientLayer.mask = shapeLayer;
    [self.loadingImage.layer addSublayer:gradientLayer];
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue = @(2.f*M_PI);
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [gradientLayer addAnimation:animation forKey:@"GradientLayerAnimation"];
}

-(void)setUptextMove
{
    _textMovetimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(textMove:) userInfo:nil repeats:YES];
    [_textMovetimer fire];
}

-(void)textMove:(NSTimer *)timer
{
    if ([_showLabel.text isEqualToString:@"拼命加载中..."]) {
        _showLabel.text = @"拼命加载中.";
    }else{
      _showLabel.text =  [NSString stringWithFormat:@"%@.",_showLabel.text];
    }
}


-(void)show
{
    if (self) {
        [self hide];
    }
    self.backgroundColor = [UIColor clearColor];
    [self setUptextMove];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(TIMEOUT * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self) {
            [self  hide];
        }
    });
}
-(void)hide
{
//    [self.textMovetimer ];
//    self.textMovetimer = nil;
    [self removeFromSuperview];
}

-(void)dealloc
{
    _textMovetimer = nil;
}

@end
