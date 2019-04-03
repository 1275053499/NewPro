//
//  NewProCommunityVC.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProCommunityVC.h"
#import "NewProCommunityNeedCell.h"
@interface NewProCommunityVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView               *   tableView;
@property (nonatomic, assign) BOOL                          state;//YES 未开通 NO 开通
@end

@implementation NewProCommunityVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.state = YES;
    self.navigationController.navigationBarHidden = YES;
    [self maketableview];
    
}

-(void)maketableview{
    
    self.tableView              = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.bounces      = NO;
    [self.view addSubview:self.tableView];
    self.tableView.sectionFooterHeight              = 1.0;
    self.tableView.showsHorizontalScrollIndicator   = NO;
    self.tableView.showsVerticalScrollIndicator     = NO;
    self.tableView.tableFooterView                  = [UIView new];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor      = [UIColor whiteColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(-kStatusBarHegiht, 0, 0, 0));
    }];
    
}


#pragma mark - UITableView DataSource Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.state) {
        return 1;
    }else{
        return 2;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.state) {
        
        NewProCommunityNeedCell *cell = [NewProCommunityNeedCell cellWithTableView:tableView];
        [cell.ruzhuBtn addTarget:self action:@selector(ruzhu:)];
        
        return cell;
    }else{
        
        if (indexPath.row==0) {
            
            NewProCommunityNeedCell *cell = [NewProCommunityNeedCell cellWithTableView:tableView];
          
            return cell;
        }else{
            
            NewProCommunityNeedCell *cell = [NewProCommunityNeedCell cellWithTableView:tableView];
            
            return cell;
        }
    }
}

-(void)ruzhu:(UIButton *)btn{
    
     NewProAlertFieldView * alertview_2         = [[[NSBundle mainBundle]loadNibNamed:@"NewProAlertFieldView" owner:nil options:nil]lastObject];
    
     alertview_2.backgroundColor           = RGBA(0, 0, 0, 0.7);
    [KEYWINDOW addSubview:alertview_2];
    
    
    
    
//    NewProAlertView * alertview         = [[[NSBundle mainBundle]loadNibNamed:@"NewProAlertView" owner:nil options:nil]lastObject];
//
//    alertview.alerttitle_1.text         = @"免费入驻 管理费首月免费";
//    alertview.alerttitle_1.textColor    = RGBA(225, 194, 133, 1);
//    alertview.alerttitle_1.font         = XFont(14);
//
//    alertview.alerttitle_2.text         = @"管理费标准:1年/300元、1月/100元";
//    alertview.alerttitle_2.textColor    = RGBA(102, 102, 102, 1);
//    alertview.alerttitle_2.font         = XFont(11);
//
//     alertview.iS_single         = NO;//只显示一个文本
//
//    [alertview.leftbtn  setTitle:@"不开通" forState:UIControlStateNormal];
//    [alertview.rightbtn setTitle:@"开通店铺" forState:UIControlStateNormal];
//    alertview.backgroundColor           = RGBA(0, 0, 0, 0.7);
//    [KEYWINDOW addSubview:alertview];
//    alertview.AlertBlock = ^(NSInteger index) {
//        if (index==1) {//右边按钮
//
//
//        }else{
//
//        }
//    };
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (self.state) {
        return 667;
    }else{
        if (indexPath.row==0) {
            return 300;
        }else{
            return 500;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
