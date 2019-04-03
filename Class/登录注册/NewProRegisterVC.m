//
//  NewProRegisterVC.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProRegisterVC.h"
#import "NewProRegisterAACell.h"
#import "NewProRegisterBBCell.h"
@interface NewProRegisterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView               *   tableView;



@end

@implementation NewProRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];

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
    
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row==0) {
        
        NewProRegisterAACell *cell = [NewProRegisterAACell cellWithTableView:tableView];
        [cell.closebtn addTarget:self action:@selector(close:)];
        
        return cell;
    }else{
       
        NewProRegisterBBCell *cell = [NewProRegisterBBCell cellWithTableView:tableView];
        return cell;
    }
}

-(void)close:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 320;
    }else{
        return 500;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return kStatusBarHegiht;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *navview =[UIView new];
    navview.backgroundColor =  RGBA(253, 152, 84, 1);
    return navview;
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
