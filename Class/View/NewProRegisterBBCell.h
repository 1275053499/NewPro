//
//  NewProRegisterBBCell.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewProRegisterBBCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *MIDBgView;
@property (nonatomic, strong) YJLAttributesLabel * xieyiLab;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIButton   *registBtn;
@property (weak, nonatomic) IBOutlet UIView     *yqmView;


@property (weak, nonatomic) IBOutlet UILabel     *yqmLab;//邀请码
@property (weak, nonatomic) IBOutlet UILabel     *yqrLab;//邀请人
@property (weak, nonatomic) IBOutlet UITextField *phonefield;//电话号码
@property (weak, nonatomic) IBOutlet UITextField *codefield;//验证码
@property (weak, nonatomic) IBOutlet UITextField *passwordfield;//密码
@property (weak, nonatomic) IBOutlet UITextField *againpassfield;//二次密码
@property (weak, nonatomic) IBOutlet UITextField *wxfield;//微信号
@property (weak, nonatomic) IBOutlet UIButton    *CodeBtn;//获取验证码按钮
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger timeNUm;


@end

NS_ASSUME_NONNULL_END
