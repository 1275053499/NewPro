//
//  GMNrelanamecommitCell.h
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/12/23.
//  Copyright © 2018 yanjinlin. All rights reserved.
//  130

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMNrelanamecommitCell : UITableViewCell<UITextViewDelegate>
+ (instancetype)cellWithTableView:(UITableView *)tableView;//注册xib

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *Commit;

@property (weak, nonatomic) IBOutlet UIButton *GXbtn;

@end

NS_ASSUME_NONNULL_END
