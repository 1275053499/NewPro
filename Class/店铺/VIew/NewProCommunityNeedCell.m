//
//  NewProCommunityNeedCell.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/3.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProCommunityNeedCell.h"

@implementation NewProCommunityNeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NewProCommunityNeedCell *cell = (NewProCommunityNeedCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
    
}

@end
