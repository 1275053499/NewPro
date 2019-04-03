//
//  FZKGuidePageView.m
//  FanZuKe
//
//  Created by yanjinlin on 2018/8/2.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import "FZKGuidePageView.h"
#define IMAGECOUNT 3

@interface FZKGuidePageView ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation FZKGuidePageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //创建ScrollView
    UIScrollView *sv = [[UIScrollView alloc] init];
    sv.frame = self.bounds;
    //设置边缘不弹跳
    sv.bounces = NO;
    //整页滚动
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.delegate = self;
    sv.contentSize = CGSizeMake(IMAGECOUNT * sv.frame.size.width, sv.frame.size.height);
    [self addSubview:sv];
    
    //加入多个子视图(ImageView)
    for(NSInteger i=0; i<IMAGECOUNT; i++){
        CGRect frame = CGRectZero;
        frame.origin.x = i * sv.frame.size.width;
        frame.size = sv.frame.size;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.frame = frame;
        bgView.backgroundColor = [UIColor whiteColor];
        switch (i) {
            case 0:
            {
                bgView.backgroundColor = RGBA(243, 247, 254,1);
            }
                break;
            case 1:
            {
               bgView.backgroundColor =RGBA(243, 247, 254,1);
            }
                break;
            case 2:
            {
                bgView.backgroundColor = RGBA(243, 247, 254,1);
            }
                break;
                
            default:
                break;
        }
        [sv addSubview:bgView];
        
        NSString *imgName = [NSString stringWithFormat:@"引导页%ld", i+1];
        UIImage *image = [UIImage imageNamed:imgName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = frame;
        [sv addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
       
        UIImageView *pageimgview = [[UIImageView alloc]initWithFrame:CGRectMake((imageView.frame.size.width-53)/2, imageView.frame.size.height*0.9, 53, 4.5)];
        pageimgview.image = [UIImage imageNamed:[NSString stringWithFormat:@"pageControl%ld", i+1]];
        [imageView addSubview:pageimgview];
        
        if(i==IMAGECOUNT-1){
        
            UIButton *button = [[UIButton alloc]init];
            button.frame = CGRectMake((imageView.frame.size.width-217)/2, imageView.frame.size.height*0.8, 217, 61);
            [button setImage:[UIImage imageNamed:@"立即体验"] forState:UIControlStateNormal];
            [imageView addSubview:button];
            [button addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
        }
    }
  
    
    //加入页面指示控件PageControl
//    UIPageControl *pageControl = [[UIPageControl alloc]init];
//    self.pageControl = pageControl;
//    //设置frame
//    pageControl.frame = CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 20);
//    //分页面的数量
//    pageControl.numberOfPages = IMAGECOUNT;
//    //设置小圆点渲染颜色
//    pageControl.pageIndicatorTintColor = RGBA(255, 255, 255, 0.5);
//    //设置当前选中小圆点的渲染颜色
//    pageControl.currentPageIndicatorTintColor = RGBA(255, 155, 41, 1);
//    //关闭用户点击交互
//    pageControl.userInteractionEnabled = NO;
//
//    [self addSubview:pageControl];
    
}

- (void)enter
{
    NSLog(@"进入应用");
    [UserDedaults setObject:@"firstLogin" forKey:@"firstLogin"];
    if (_guidePageBlcok) {
        _guidePageBlcok(self);
    }
   
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//UIScrollViewDelegate方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGPoint offset = scrollView.contentOffset;
//    if(offset.x<=0){
//        offset.x = 0;
//        scrollView.contentOffset = offset;
//    }
//    NSUInteger index = round(offset.x / scrollView.frame.size.width);
//    self.pageControl.currentPage = index;
}

@end
