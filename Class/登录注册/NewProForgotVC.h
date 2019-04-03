//
//  NewProForgotVC.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NewProForgotVC : NewFZKBaseVC

@property (weak, nonatomic) IBOutlet UITextField *Phonefield;
@property (weak, nonatomic) IBOutlet UITextField *codefield;
@property (weak, nonatomic) IBOutlet UITextField *passwordfield;
@property (weak, nonatomic) IBOutlet UITextField *againpasswordfield;





@property (weak, nonatomic) IBOutlet UIButton *CodeBtn;


@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,assign)NSInteger timeNUm;
@end

NS_ASSUME_NONNULL_END
