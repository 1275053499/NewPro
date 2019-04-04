//
//  GMNrelanamecodeCell.h
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/12/23.
//  Copyright © 2018 yanjinlin. All rights reserved.
//  51

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMNrelanamecodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger timeNUm;
+ (instancetype)cellWithTableView:(UITableView *)tableView;//注册xib
@end

NS_ASSUME_NONNULL_END
