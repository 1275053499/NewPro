//
//  PersonaldataTopCell.m
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/21.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import "PersonaldataTopCell.h"

@implementation PersonaldataTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.IMG.layer.cornerRadius = 47/2;
    self.IMG.clipsToBounds      = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    PersonaldataTopCell *cell = (PersonaldataTopCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
    
    
   
    
   
    
    
}

@end
