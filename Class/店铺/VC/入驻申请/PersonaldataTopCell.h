//
//  PersonaldataTopCell.h
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/21.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonaldataTopCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *IMG;
@property (weak, nonatomic) IBOutlet UIImageView *turnimg;

@end

NS_ASSUME_NONNULL_END
