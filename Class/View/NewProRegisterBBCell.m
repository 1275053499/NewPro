//
//  NewProRegisterBBCell.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProRegisterBBCell.h"

@implementation NewProRegisterBBCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self initviews];
    [self addShadowToView:self.MIDBgView withColor:RGBA(225, 194, 133, 0.3)];
    
}

- (IBAction)textsecurestateone:(UIButton *)sender {
    
    sender.selected                 = !sender.selected;
    self.passwordfield.secureTextEntry  = !self.passwordfield.secureTextEntry;
}


- (IBAction)textsecurestatetwo:(UIButton *)sender {
    
    sender.selected                 = !sender.selected;
    self.againpassfield.secureTextEntry  = !self.againpassfield.secureTextEntry;
}

- (IBAction)GetCode:(UIButton *)sender {
    
    if (self.phonefield.text.length!=11) {
        
        [KEYWINDOW makeToast:@"号码好像出错了" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if ([sender.titleLabel.text isEqualToString:@"重新发送"]||[sender.titleLabel.text isEqualToString:@"获取验证码"]) {
        self.timeNUm = 60;
        [self.CodeBtn setTitle:[NSString stringWithFormat:@"%ldS",self.timeNUm] forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Timered:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [self getcode];
    }else{
        NSLog(@"不可点击了");
    }
    
}

- (void)Timered:(NSTimer*)timer {
    NSLog(@"%ld",self.timeNUm);
    self.timeNUm -- ;
    if ( self.timeNUm>0) {
        
        [self.CodeBtn setTitle:[NSString stringWithFormat:@"%ldS",self.timeNUm] forState:UIControlStateNormal];
        
    }else{
        
        [self.CodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
}

#pragma mark  注册发送验证码
-(void)getcode{
    
    //    [self.CodeBtn setTitle:@"倒计时60S" forState:UIControlStateNormal];
    
    //    NSDictionary *dic =@{   @"mobile":self.Phonefield.text,
    //                            @"work":@"2",
    //                            @"role":@"iOS"
    //                            };
    //    [GMBProgressShower showLoadData:self.contentView Text:@"发送验证码中..."];
    //    [HttpsRequest SelicePOST:Url_selice_sendSms  parameters:dic success:^(id responseObject) {
    //
    //        [GMBProgressShower hideHUDForView:self.contentView animated:NO];
    //        [KEYWINDOW makeToast:responseObject[@"msg"] duration:1 position:CSToastPositionCenter];
    //        if ([responseObject[@"code"] integerValue]==200) {
    //
    //        }else{
    //
    //            [self.CodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    //            [self.timer invalidate];
    //        }
    //
    //    } failure:^(NSError *error) {
    //        [GMBProgressShower hideHUDForView:self.contentView animated:NO];
    //
    //        [self.CodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    
    //        [self.timer invalidate];
    //    }];
}

-(void)initviews{
    
    [Healp viewBeizerRect:self.yqmView.bounds view:self.yqmView corner:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(25/2, 25/2)];
    

    self.xieyiLab  = [[YJLAttributesLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.MIDBgView.frame)+65, self.width , 30)];
    self.xieyiLab.font              = XFont(12);
    self.xieyiLab.textColor         = RGBA(179, 179, 179, 1);
    [self.contentView addSubview:self.xieyiLab];
    NSString *temp              = @"注册即代表您已同意凡租客用户服务协议、隐私协议";//全部显示的文字
    NSMutableArray * arr_text   = [[NSMutableArray alloc]initWithObjects:@"凡租客用户服务协议、",@"隐私协议", nil];//点击的文字设置
    NSMutableArray * arr_range  = [[NSMutableArray alloc]initWithObjects:@"9",@"19", nil];//点击的文字开始位置设置
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:temp];
    attrStr                     = [self textArr:arr_text AttributedString:attrStr Connet:temp];//点击的文字简单设置属性
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:12]
                    range:NSMakeRange(0, attrStr.length)];
    self.xieyiLab.YJLAttributesBlock = ^(NSString * _Nonnull clicktext) {//点击事件的d返回
        
        [KEYWINDOW makeToast:[NSString stringWithFormat:@"%@",clicktext] duration:1 position:CSToastPositionCenter];
       
        
        NewProProtocalVC*VC    = [[NewProProtocalVC alloc]init];
        VC.Url              = @"https://hou.zhetaow.com:789/registration_agreement.html";
        [[YJLTools_sub getCurrentVC].navigationController pushViewController:VC animated:YES];
        
    };
    [self.xieyiLab setAttributesText:attrStr actionText:arr_text actionRange:arr_range];//d添加到UILabel上面
   
}
/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,1);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 7;
    theView.layer.cornerRadius = 10;
    
}


#pragma mark  多个点击位置进行简单设置
-(NSMutableAttributedString *)textArr:(NSMutableArray *)textarr  AttributedString:(NSMutableAttributedString *)String Connet:(NSString *)connet{
    
    for (int i=0; i<textarr.count; i++) {
        NSRange range = [connet rangeOfString:textarr[i]];
        [String addAttribute:NSLinkAttributeName
                       value:textarr[i]
                       range: range];
    }
    return String;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


- (IBAction)RegistACtion:(UIButton *)sender {
    
     [KEYWINDOW makeToast:@"注册" duration:1 position:CSToastPositionCenter];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NewProRegisterBBCell *cell = (NewProRegisterBBCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

@end
