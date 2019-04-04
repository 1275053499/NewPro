//
//  NewProLoginVC.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProLoginVC.h"
#import "NewProLoginBBCell.h"
#import "NewProLoginAACell.h"
@interface NewProLoginVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView               *   tableView;
@property (nonatomic, assign) BOOL                          state;//YES 验证码登录 NO 密码登录

@end

@implementation NewProLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.state = YES;
    self.navigationController.navigationBarHidden = YES;
    [self addShadowToView:self.MIDBgView withColor:RGBA(225, 194, 133, 0.3)];
    [self setnavcolor];
    [self maketableview];
    
}

-(void)setnavcolor{
    
    UIView *navview =[UIView new];
    navview.backgroundColor =  RGBA(253, 152, 84, 1);
    navview.frame           =   CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHegiht);
    [self.view addSubview:navview];
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,1);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 7;
    theView.layer.cornerRadius = 10;

}

- (IBAction)CloseAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)maketableview{
    
    self.tableView              = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.MIDBgView.frame.size.width, self.MIDBgView.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.bounces      = NO;
    [self.MIDBgView addSubview:self.tableView];
    self.tableView.sectionFooterHeight              = 1.0;
    self.tableView.showsHorizontalScrollIndicator   = NO;
    self.tableView.showsVerticalScrollIndicator     = NO;
    self.tableView.tableFooterView                  = [UIView new];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor      = [UIColor whiteColor];
    self.tableView.layer.cornerRadius   = 10;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark - UITableView DataSource Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAK
    if (self.state) {
        //    1:密码登录
        //    2:登录
        NewProLoginBBCell *cell = [NewProLoginBBCell cellWithTableView:tableView];
        cell.cellActionBlock = ^(NSInteger btntag,NSString *phone,NSString *code) {
            STRONG
            if (btntag==1) {
                self.state = NO;
                [self.tableView reloadData];
            }else{
                
            
                 [KEYWINDOW makeToast:@"验证码登录" duration:1 position:CSToastPositionCenter];
                
            }
        };
    
        return cell;
    }else{
        //    0:忘记密码
        //    1:验证码登录
        //    2:登录
        NewProLoginAACell *cell = [NewProLoginAACell cellWithTableView:tableView];
        cell.cellActionBlock = ^(NSInteger btntag,NSString *phone,NSString *password) {
            STRONG
            if (btntag==0) {
                
                 [self.navigationController pushViewController:[NSClassFromString(@"NewProForgotVC") new] animated:YES];
                
            }else if (btntag==1){
                self.state = YES;
                [self.tableView reloadData];
            }else{
                
//                 [self.navigationController pushViewController:[NSClassFromString(@"NewProRegisterVC") new] animated:YES];
//                 [KEYWINDOW makeToast:@"密码登录" duration:1 position:CSToastPositionCenter];
            }
        };
        return cell;
    }
    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 290;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 0.0001f;
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
