//
//  GMNrelanamecodeCell.m
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/12/23.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import "GMNrelanamecodeCell.h"

@implementation GMNrelanamecodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancel) name:@"timercancel" object:nil];
    
    self.codeBtn.layer.cornerRadius = 15;
    [self.codeBtn setBackgroundColor:RGBA(225, 194, 133, 1)];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:RGB(255,255,255) forState:UIControlStateNormal];
    self.codeBtn.titleLabel.font = XFont(11);
    WEAK
    [[self.code rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        STRONG
        if (x.length>6) {
            self.code.text = [x substringWithRange:NSMakeRange(0, 6)];
        }
    }];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    GMNrelanamecodeCell *cell = (GMNrelanamecodeCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (IBAction)CodeAction:(UIButton *)sender {
//    if (USERMODEL.mobile.length<1) {
//        [KEYWINDOW makeToast:@"请返回先获取个人信息" duration:1 position:CSToastPositionCenter];
//        return;
//    }
   
    if ([sender.titleLabel.text isEqualToString:@"再次获取验证码"]||[sender.titleLabel.text isEqualToString:@"获取验证码"]) {
        self.timeNUm = 60;
        [self.codeBtn setTitle:[NSString stringWithFormat:@"倒计时%ldS",self.timeNUm] forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Timered:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];

        [self getcode];

    }else{
        NSLog(@"不可点击了");
    }
}

#pragma mark  注册发送验证码
-(void)getcode{

//    if (USERMODEL.mobile.length<1) {
//         [KEYWINDOW makeToast:@"请返回先获取个人信息" duration:1 position:CSToastPositionCenter];
//        return;
//    }
    
//    NSDictionary *dic =@{   @"mobile":@"213213213213",
//                            @"work":@"6",
//                            @"role":@"iOS"
//                            };
//    [KEYWINDOW makeToast2:@"验证码发送中..."];
//    [HttpsRequest SelicePOST:Url_selice_sendSms  parameters:dic success:^(id responseObject) {
//        [KEYWINDOW hideToast];
//        [KEYWINDOW makeToast:responseObject[@"msg"] duration:1 position:CSToastPositionCenter];
//        if ([responseObject[@"code"] integerValue]==200) {
//
//        }else{
//
//            [self.codeBtn setBackgroundColor:RGB(118,202,138)];
//            [self.codeBtn setTitle:@"再次获取验证码" forState:UIControlStateNormal];
//            self.codeBtn.titleLabel.font = XFont(9);
//            [self.codeBtn setTitleColor:RGB(255,255,255) forState:UIControlStateNormal];
//            [self.timer invalidate];
//        }
//
//    } failure:^(NSError *error) {
//        [KEYWINDOW hideToast];
//        [self.codeBtn setBackgroundColor:RGB(118,202,138)];
//        [self.codeBtn setTitle:@"再次获取验证码" forState:UIControlStateNormal];
//        self.codeBtn.titleLabel.font = XFont(9);
//        [self.codeBtn setTitleColor:RGB(255,255,255) forState:UIControlStateNormal];
//        [self.timer invalidate];
//    }];
}

- (void)Timered:(NSTimer*)timer {
    NSLog(@"%ld",self.timeNUm);
    if ( self.timeNUm>0) {
        self.timeNUm -- ;
        [self.codeBtn setBackgroundColor:RGBA(225, 194, 133, 1)];
        [self.codeBtn setTitle:[NSString stringWithFormat:@"倒计时%ldS",self.timeNUm] forState:UIControlStateNormal];
        self.codeBtn.titleLabel.font = XFont(10);
        [self.codeBtn setTitleColor:RGB(255,255,255) forState:UIControlStateNormal];
    }else{

        [self.codeBtn setBackgroundColor:RGB(118,202,138)];
        [self.codeBtn setTitle:@"再次获取验证码" forState:UIControlStateNormal];
        self.codeBtn.titleLabel.font = XFont(9);
        [self.codeBtn setTitleColor:RGB(153,153,153) forState:UIControlStateNormal];
        [self.timer invalidate];
    }
}

-(void)cancel{

    [self.timer invalidate];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}





@end
