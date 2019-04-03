//
//  GMBProgressShower.m
//  GOUDIWANG
//
//  Created by 曾国锐 on 2017/11/2.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "GMBProgressShower.h"

@implementation GMBProgressShower

+ (MBProgressHUD*)showLoadData:(UIView*)view Text:(NSString*)text
{
    //    UIView
    if (!view) {
        return nil;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.bezelView.color = RGBA(0, 0, 0, 0.7);
    return hud;
}

+ (void)hideHUDForView:(UIView *)view animated:(BOOL)animated{
    [MBProgressHUD hideHUDForView:view animated:animated];
}

+(void)showTextInError:(UIView*)view Text:(NSString*)text During:(NSTimeInterval)time
{
    if (!view) {
        return;
    }
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabel.text = text;
    HUD.detailsLabel.font = [UIFont systemFontOfSize:15];
    
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
    HUD.detailsLabel.text = text;
    HUD.detailsLabel.font = [UIFont systemFontOfSize:15];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [imgV setTag:101];
    [imgV setImage:[UIImage imageNamed:@"SUCCESSICON"]];
    HUD.customView = imgV;
    
    [HUD showAnimated:NO];
    HUD.bezelView.color = RGBA(0, 0, 0, 0.7);
    [HUD hideAnimated:YES afterDelay:time];
}

@end
