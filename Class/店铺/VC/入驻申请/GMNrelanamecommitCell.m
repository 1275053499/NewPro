//
//  GMNrelanamecommitCell.m
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/12/23.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import "GMNrelanamecommitCell.h"

@implementation GMNrelanamecommitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"勾选即代表您已阅读并同意《用户协议》"];
    
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"qq://"
                             range:[[attributedString string] rangeOfString:@"《用户协议》"]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    self.textView.attributedText = attributedString;

    self.textView.linkTextAttributes = @{NSForegroundColorAttributeName: RGBA(78, 159, 239, 1),
                                         NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                         NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)
                                         };
    
    self.textView.delegate  = self;
    self.textView.editable  = NO;        //必须禁止输入，否则点击将弹出输入键盘
    self.textView.scrollEnabled = NO;
    self.textView.textAlignment = NSTextAlignmentLeft;
    
    
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    if ([[URL scheme] isEqualToString:@"qq"]) {
        NSLog(@"《等级配额用户协议》---------------");
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程进行UI操作
            NewProProtocalVC*VC    = [[NewProProtocalVC alloc]init];
            VC.hidesBottomBarWhenPushed = YES;
            [[YJLTools_sub getCurrentVC].navigationController pushViewController:VC animated:YES];//《等级配额用户协议》
        });
        return NO;
    }
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

- (IBAction)GXbtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.Commit.enabled = YES;
        [self.Commit setBackgroundColor:RGB(118,202,138)];
       
    }else{
        self.Commit.enabled = NO;
        [self.Commit setBackgroundColor:RGB(225, 194, 133)];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    GMNrelanamecommitCell *cell = (GMNrelanamecommitCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
@end
