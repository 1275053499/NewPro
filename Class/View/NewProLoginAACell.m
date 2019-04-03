//
//  NewProLoginAACell.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProLoginAACell.h"

@implementation NewProLoginAACell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)textsecurestate:(UIButton *)sender {
    
    sender.selected                 = !sender.selected;
    self.Passfield.secureTextEntry  = !self.Passfield.secureTextEntry;
}


- (IBAction)Action:(UIButton *)sender {
//    0:忘记密码
//    1:验证码登录
//    2:登录
    
//    if (sender.tag==2) {
//
//        if (self.Phonefield.text.length!=11) {
//
//            [KEYWINDOW makeToast:@"号码不正确" duration:1 position:CSToastPositionCenter];
//            return;
//        }
//
//        if (self.Passfield.text.length<8) {
//
//            [KEYWINDOW makeToast:@"密码格式不正确" duration:1 position:CSToastPositionCenter];
//            return;
//        }
//    }
    
    self.cellActionBlock(sender.tag,_Phonefield.text,_Passfield.text);
   
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NewProLoginAACell *cell = (NewProLoginAACell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
    
}
@end
