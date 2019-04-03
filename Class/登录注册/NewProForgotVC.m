//
//  NewProForgotVC.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProForgotVC.h"

@interface NewProForgotVC ()

@end

@implementation NewProForgotVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title                  = @"重置密码";
    self.view.backgroundColor   = [UIColor groupTableViewBackgroundColor];
    
}

#pragma mark  验证码
- (IBAction)action:(UIButton *)sender {
    
    [self.Phonefield resignFirstResponder];
    [self.codefield resignFirstResponder];
    [self.passwordfield resignFirstResponder];
    [self.againpasswordfield resignFirstResponder];
    
    if (self.Phonefield.text.length!=11) {
        
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


#pragma mark  提交
- (IBAction)commitaction:(UIButton *)sender {
    
    [self.Phonefield resignFirstResponder];
    [self.codefield resignFirstResponder];
    [self.passwordfield resignFirstResponder];
    [self.againpasswordfield resignFirstResponder];
    
    
    
    if (self.Phonefield.text.length!=11) {
        
        [KEYWINDOW makeToast:@"号码不正确" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if (self.codefield.text.length<6) {
        
        [KEYWINDOW makeToast:@"验证码格式不正确" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if (self.passwordfield.text.length<8) {
        
        [KEYWINDOW makeToast:@"密码格式不正确" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    if (self.againpasswordfield.text.length<8) {
        
        [KEYWINDOW makeToast:@"密码格式不正确" duration:1 position:CSToastPositionCenter];
        return;
    }

    if (![self.passwordfield.text isEqualToString:self.againpasswordfield.text]) {
        
        [KEYWINDOW makeToast:@"两次密码不相同" duration:1 position:CSToastPositionCenter];
        return;
    }
    
     [KEYWINDOW makeToast:[NSString stringWithFormat:@"%@-%@-%@-%@",self.Phonefield.text,self.codefield.text,self.passwordfield.text,self.againpasswordfield.text] duration:1 position:CSToastPositionCenter];
    
    NSLog(@"%@-%@-%@-%@",self.Phonefield.text,self.codefield.text,self.passwordfield.text,self.againpasswordfield.text);
    
}

#pragma mark判断字符串是否有中文
-(BOOL)IsChinese:(NSString *)str {
    
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    } return NO;
}

#pragma mark判断字符串是否有空格
-(BOOL)isHaveEmptyString:(NSString *) string {
    
    NSRange range = [string rangeOfString:@" "];
    
    if (range.location != NSNotFound) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark 判断字符串全是纯数字
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
