//
//  NewProLoginAACell.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface NewProLoginAACell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *Phonefield;
@property (weak, nonatomic) IBOutlet UITextField *Passfield;
@property(nonatomic,strong) void(^cellActionBlock)(NSInteger btntag,NSString *phone,NSString *password);//初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

