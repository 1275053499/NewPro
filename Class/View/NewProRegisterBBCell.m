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

    NSString *temp             = @"注册即代表您已同意凡租客用户服务协议、隐私协议";//全部显示的文字
    NSMutableArray * arr_text  = [[NSMutableArray alloc]initWithObjects:@"凡租客用户服务协议",@"隐私协议", nil];//点击的文字设置
    NSMutableArray * arr_range = [[NSMutableArray alloc]initWithObjects:@"9",@"19", nil];//点击的文字开始位置设置
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:temp];
    attrStr =   [self textArr:arr_text AttributedString:attrStr Connet:temp];//点击的文字简单设置属性
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14]
                    range:NSMakeRange(0, attrStr.length)];
//    WEAK
    self.xieyiLab.YJLAttributesBlock = ^(NSString * _Nonnull clicktext) {//点击事件的d返回
//       STRONG
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:clicktext delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alertView show];
    };
    [ self.xieyiLab setAttributesText:attrStr actionText:arr_text actionRange:arr_range];//d添加到UILabel上面
    
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
    
    
}



@end
