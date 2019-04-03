//
//  GMBHud.m
//  FanZuKe
//
//  Created by yanjinlin on 2018/7/28.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import "GMBHud.h"
#import <MBProgressHUD/MBProgressHUD.h>
@implementation GMBHud

+ (MBProgressHUD*)showLoadData:(UIView*)view Text:(NSString*)text
{
    //    UIView
    if (!view) {
        return nil;
    }
    MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text           = text;
    hud.bezelView.color               = RGBA(0, 0, 0, 0.7);
//    hud.mode = 切换系统动画样式 默认使用圈圈
    return hud;
}


+(MBProgressHUD *)showLoadData:(UIView *)view Text:(NSString *)text During:(NSTimeInterval)time{
    //    UIView
    if (!view) {
        return nil;
    }
    MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text           = text;
    hud.bezelView.color               = RGBA(0, 0, 0, 0.7);
    [hud hideAnimated:YES afterDelay:time];
    return hud;
}


+ (void)hideHUDForView:(UIView *)view animated:(BOOL)animated{
     [MBProgressHUD hideHUDForView:view animated:YES];
}

//自定义


+(void)showTextInError:(UIView*)view Text:(NSString*)text During:(NSTimeInterval)time
{
    if (!view) {
        return;
    }
    MBProgressHUD *HUD      = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode                = MBProgressHUDModeCustomView;
    HUD.detailsLabel.text    = text;
    HUD.detailsLabel.font    = [UIFont systemFontOfSize:15];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 80)];
    [imgV setTag:101];
    
    [imgV setImage:[UIImage imageNamed:@"ERRORICON"]];
    imgV.frame = CGRectMake(0, 0, 50, 50);
    
    HUD.customView = imgV;
    
    [HUD showAnimated:NO];
    HUD.bezelView.color = RGBA(0, 0, 0, 0.7);
    [HUD hideAnimated:YES afterDelay:time];
}

+(void)showTextInSucce:(UIView*)view Text:(NSString*)text During:(NSTimeInterval)time
{
    if (!view) {
        return;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabel.text    = text;
    HUD.detailsLabel.font    = [UIFont systemFontOfSize:15];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [imgV setTag:101];
    [imgV setImage:[UIImage imageNamed:@"SUCCESSICON"]];
    HUD.customView = imgV;
    
    [HUD showAnimated:NO];
    HUD.bezelView.color = RGBA(0, 0, 0, 0.7);
    [HUD hideAnimated:YES afterDelay:time];
}

+(void)showTextInCustomImgofPng:(UIView *)view Text:(NSString *)text During:(NSTimeInterval)time{
    if (!view) {
        return;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabel.text    = text;
    HUD.detailsLabel.font    = [UIFont systemFontOfSize:15];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [imgV setTag:101];
    [imgV setImage:[UIImage imageNamed:@"ERRORICON"]];
    HUD.customView = imgV;
    
    [HUD showAnimated:NO];
    HUD.bezelView.color = RGBA(0, 0, 0, 0.7);
    [HUD hideAnimated:YES afterDelay:time];
}

+(void)showTextInCustomImgofGif:(UIView *)view Text:(NSString *)text During:(NSTimeInterval)time{

    if (!view) {
        return;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabel.text    = text;
    HUD.detailsLabel.font    = [UIFont systemFontOfSize:15];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [imgV setTag:101];
    
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"titleimg" ofType:@"gif"];
    NSData *data    = [NSData dataWithContentsOfFile:path];
    [imgV setImage:[UIImage sd_animatedGIFWithData:data]];
    HUD.customView = imgV;
    
    [HUD showAnimated:NO];
    HUD.bezelView.color = RGBA(0, 0, 0, 0.7);
    [HUD hideAnimated:YES afterDelay:time];
    
}


+(void)showTextInCustomMoreImgofPng:(UIView *)view Text:(NSString *)text During:(NSTimeInterval)time{
    if (!view) {
        return;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabel.text    = text;
    HUD.detailsLabel.font    = [UIFont systemFontOfSize:15];
    
    //自定义动画
    UIImageView *gifImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sLoading_1"]];
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sLoading_%d", i + 1]];
        [arrM addObject:image];
    }
    [gifImageView setAnimationImages:arrM];
    [gifImageView setAnimationDuration:1.5];
    [gifImageView setAnimationRepeatCount:0];
    [gifImageView startAnimating];
    HUD.customView = gifImageView;
    
    [HUD showAnimated:NO];
    HUD.bezelView.color = RGBA(0, 0, 0, 0.7);
    [HUD hideAnimated:YES afterDelay:time];
}

@end
