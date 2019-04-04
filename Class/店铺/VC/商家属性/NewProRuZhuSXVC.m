//
//  NewProRuZhuSXVC.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/4.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProRuZhuSXVC.h"

@interface NewProRuZhuSXVC ()

@end

@implementation NewProRuZhuSXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家属性";
}

- (IBAction)XXAction:(UIButton *)sender {
    
    self.RZSX(@"线下商家", @"1");
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)XSACtion:(UIButton *)sender {
    self.RZSX(@"线上商家", @"2");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
