//
//  GMNmerchantTopSubCell.m
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/19.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import "GMNmerchantTopSubCell.h"

@implementation GMNmerchantTopSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.turnimg.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    GMNmerchantTopSubCell *cell = (GMNmerchantTopSubCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
    
}
@end
