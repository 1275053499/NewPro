//
//  NewProAlertView.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/3.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

//  两个lUIlabel

#import <UIKit/UIKit.h>

@interface NewProAlertView : UIView


@property (weak, nonatomic) IBOutlet UIView     *BGview;
@property (weak, nonatomic) IBOutlet UILabel    *alerttitle_1;
@property (weak, nonatomic) IBOutlet UILabel    *alerttitle_2;
@property (weak, nonatomic) IBOutlet UIButton   *rightbtn;
@property (weak, nonatomic) IBOutlet UIButton   *leftbtn;
@property (nonatomic,copy ) void(^AlertBlock) (NSInteger index);//初始化
@property (nonatomic,strong) NSString   * title;//初始化

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SingleLabConstraint;
@property (nonatomic,assign) BOOL  iS_single;//是否只有一个文本框


/*
 
 NewProAlertView * alertview         = [[[NSBundle mainBundle]loadNibNamed:@"NewProAlertView" owner:nil options:nil]lastObject];

 alertview.alerttitle_1.text         = @"免费入驻 管理费首月免费";
 alertview.alerttitle_1.textColor    = RGBA(225, 194, 133, 1);
 alertview.alerttitle_1.font         = XFont(14);
 
 alertview.alerttitle_2.text         = @"管理费标准:1年/300元、1月/100元";
 alertview.alerttitle_2.textColor    = RGBA(102, 102, 102, 1);
 alertview.alerttitle_2.font         = XFont(11);
 
 alertview.iS_single         = NO;//只显示一个文本
 
 [alertview.leftbtn  setTitle:@"不开通" forState:UIControlStateNormal];
 [alertview.rightbtn setTitle:@"开通店铺" forState:UIControlStateNormal];
 alertview.backgroundColor           = RGBA(0, 0, 0, 0.7);
 [KEYWINDOW addSubview:alertview];
 alertview.AlertBlock = ^(NSInteger index) {
 if (index==1) {//右边按钮
 
 
    }else{
 
    }
 };
 
 */

@end


