//
//  Healp.h
//  控件设置单个或多个圆角
//
//  Created by 栗子 on 2017/8/10.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Healp : NSObject

/*设置一个圆角
 适用于label imageView view
 [EncapsulationClass viewBeizerRect:imageView.bounds view:imageView corner:UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
*/
+(void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii ;


+(void)viewBeizerRect:(CGRect)rect view:(UIView *)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii strokeColor:(UIColor*)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth;



/*设置一个圆角
 适用于button
 */
+(void)ControlBeizerRect:(CGRect)rect Control:(UIControl *)Control  corner:(UIRectCorner)corner cornerRadii:(CGSize)radii;


// 使用方法 [Healp viewBeizerRect:_levelButton.bounds view:_levelButton corner:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];

//添加外框颜色
+(void)ControlBeizerRect:(CGRect)rect Control:(UIControl *)Control  corner:(UIRectCorner)corner cornerRadii:(CGSize)radii strokeColor:(UIColor*)strokeColor fillColor:(UIColor *)fillColor lineWidth:(CGFloat)lineWidth;



//colors 渐变的颜色
//locations 渐变颜色的分割点
//startPoint&endPoint 颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间，如(0,0)(1.0,0)代表水平方向渐变,(0,0)(0,1.0)代表竖直方向渐变
/*
 view 是要设置渐变字体的控件   bgVIew是view的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientview:(UIView *)view bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/*使用方法*/
/*
UILabel* testLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 400, 50)];
testLabel.text = @"label上渐变方法1";
testLabel.font = [UIFont systemFontOfSize:30];
[self.view addSubview:testLabel];
[Healp TextGradientview:testLabel bgVIew:self.view gradientColors:@[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor, (id)[UIColor blueColor].CGColor] gradientStartPoint:CGPointMake(0, 1) endPoint:CGPointMake(1, 1)];
*/
/*
 control 是要设置渐变字体的控件   bgVIew是control的父视图  colors是渐变的组成颜色  startPoint是渐变开始点 endPoint结束点
 */
+(void)TextGradientControl:(UIControl *)control bgVIew:(UIView *)bgVIew gradientColors:(NSArray *)colors gradientStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
/*
_btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 350, self.view.frame.size.width-20, 100)];
[self.view addSubview:_btn];
_btn.titleLabel.font=[UIFont systemFontOfSize:30];
_btn.titleLabel.numberOfLines=0;
[_btn setTitle:@"button上字体渐变色设置" forState:UIControlStateNormal];
[Healp TextGradientControl:_btn bgVIew:self.view gradientColors:@[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor, (id)[UIColor blueColor].CGColor] gradientStartPoint:CGPointMake(0, 1) endPoint:CGPointMake(1, 1)];

*/
@end
