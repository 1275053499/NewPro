
//
//  Healp.m
//  控件设置单个或多个圆角
//
//  Created by 栗子 on 2017/8/10.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

#import "Healp.h"


@implementation Healp

/*设置一个圆角
 适用于label imageView view
 [EncapsulationClass viewBeizerRect:imageView.bounds view:imageView corner:UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
 
 */
+(void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii{
    UIBezierPath  *maskPath= [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame =view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
}


+(void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii strokeColor:(UIColor*)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth{
    UIBezierPath  *maskPath= [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame =view.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.strokeColor   = strokeColor.CGColor;
    maskLayer.fillColor = fillColor.CGColor;
    maskLayer.lineWidth = lineWidth;
    [view.layer addSublayer: maskLayer];

}




/*设置一个圆角
 适用于button
 
 */
+(void)ControlBeizerRect:(CGRect)rect Control:(UIControl *)Control  corner:(UIRectCorner)corner cornerRadii:(CGSize)radii{
    UIBezierPath  *maskPath= [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame =Control.bounds;
    maskLayer.path = maskPath.CGPath;
    Control.layer.mask = maskLayer;
}

/*设置一个圆角
 适用于button
 可添加外圆颜色
 */
+(void)ControlBeizerRect:(CGRect)rect Control:(UIControl *)Control  corner:(UIRectCorner)corner cornerRadii:(CGSize)radii strokeColor:(UIColor*)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth{
    UIBezierPath  *maskPath= [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame =Control.bounds;
    maskLayer.path          = maskPath.CGPath;
    maskLayer.strokeColor   = strokeColor.CGColor;
    maskLayer.fillColor = fillColor.CGColor;
    maskLayer.lineWidth = lineWidth;
    [Control.layer addSublayer: maskLayer];
}




+(void)TextGradientControl:(UIControl *)control bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = control.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = control.layer;
    control.frame = gradientLayer1.bounds;
}


+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer* gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame = view.frame;
    gradientLayer1.colors = colors;
    gradientLayer1.startPoint =startPoint;
    gradientLayer1.endPoint = endPoint;
    [bgVIew.layer addSublayer:gradientLayer1];
    gradientLayer1.mask = view.layer;
    view.frame = gradientLayer1.bounds;
}
@end
