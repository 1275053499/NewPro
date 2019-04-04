//
//  NewProRuZhuSXVC.h
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/4.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewFZKBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewProRuZhuSXVC : NewFZKBaseVC

@property(nonatomic,strong) void(^RZSX)(NSString * text,NSString * index);//初始化

@end

NS_ASSUME_NONNULL_END
