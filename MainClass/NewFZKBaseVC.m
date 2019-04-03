//
//  NewFZKBaseVC.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewFZKBaseVC.h"
#import "RTRootNavigationController.h"
@interface NewFZKBaseVC ()

@end

@implementation NewFZKBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initui];
}

-(void)initui{
    
    self.view.backgroundColor = WhiteColor;
    [self makeNavBarWhiteColor];
    if (self.rt_navigationController.rt_viewControllers.count > 1) {
        [self makeBackBtn];
    }
}

- (void)makeBackBtn{
    
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"NewBack"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)dismiss
{
    if (self.rt_navigationController.rt_viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        if (self.isViewLoaded && !self.view.window)
        {
            self.view = nil;
        }
    }
}

//黑色返回
- (void)makeBackBlackBtn
{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"FZK_BLACK_return"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

//白色返回
- (void)makeBackWhiteBtn{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"FZK_WHITE_return"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

//导航栏重新设置
- (void)makeNavBarColor
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    UIImage *image              = [YJLTools_sub imageWithColor:MainColor];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

//导航栏设置
- (void)makeNavBarWhiteColor
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(67,67,67),NSForegroundColorAttributeName,nil]];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    UIImage *image              = [YJLTools_sub imageWithColor:RGB(255, 255, 255)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


#pragma mark 状态栏会变化
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

@end
