//
//  NewProLoginBBCell.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewProLoginBBCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *Phonefield;
@property (weak, nonatomic) IBOutlet UITextField *Passfield;

@property(nonatomic,strong) void(^cellActionBlock)(NSInteger btntag,NSString *phone,NSString *code);//初始化

@property (weak, nonatomic) IBOutlet UIButton *CodeBtn;


@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger timeNUm;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
