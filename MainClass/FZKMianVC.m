//
//  FZKMianVC.m
//  FanZuKe
//
//  Created by yanjinlin on 2018/7/28.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import "FZKMianVC.h"
#import "MikoTabBarItem.h"
#import "MikoTabBar.h"
#import "FZKGuidePageView.h"
#import "FZKOpenVC.h"

@interface FZKMianVC ()

@end

@implementation FZKMianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabBars];
    
    
//    [self createOpenView];//可以自己关闭的启动页 现在用launchScreen加载
}


-(void)createOpenView{
    
    FZKOpenVC *OpenVC = [[FZKOpenVC alloc] init];
    [self.view addSubview:OpenVC.view];
    OpenVC.finishBlock = ^{
       
    };
}

- (void)createTabBars{
    
    NewProHomeVC *oneVC = [[NewProHomeVC alloc] init];
    RTRootNavigationController *HomeNav = [[RTRootNavigationController alloc] initWithRootViewController:oneVC];
    
    NewProMemberVC *twoVC = [[NewProMemberVC alloc] init];
    RTRootNavigationController *HouseNav = [[RTRootNavigationController alloc] initWithRootViewController:twoVC];
    
    NewProCommunityVC *threeVC = [[NewProCommunityVC alloc] init];
    RTRootNavigationController *RentNav = [[RTRootNavigationController alloc] initWithRootViewController:threeVC];
    
    NewProMineVC *fourVC = [[NewProMineVC alloc] init];
    RTRootNavigationController *MineNav = [[RTRootNavigationController alloc] initWithRootViewController:fourVC];
    
    
    self.viewControllers = @[HomeNav, HouseNav, RentNav,MineNav];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    MikoTabBar *tabBar = [[MikoTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.tabBarItemAttributes = @[@{kTabBarItemAttributeTitle : @"首页",
                                      kTabBarItemAttributeNormalImageName : @"Tabbaricon_A_2",
                                      kTabBarItemAttributeSelectedImageName : @"Tabbaricon_A_1",
                                      kTabBarItemAttributeType : @(MikoTabBarItemNormal)},
                                    @{kTabBarItemAttributeTitle : @"星级权益",
                                      kTabBarItemAttributeNormalImageName : @"Tabbaricon_B_2",
                                      kTabBarItemAttributeSelectedImageName : @"Tabbaricon_B_1",
                                      kTabBarItemAttributeType : @(MikoTabBarItemNormal)},
                                    @{kTabBarItemAttributeTitle : @"我的店铺",
                                      kTabBarItemAttributeNormalImageName : @"Tabbaricon_C_2",
                                      kTabBarItemAttributeSelectedImageName : @"Tabbaricon_C_1",
                                      kTabBarItemAttributeType : @(MikoTabBarItemNormal)},
                                    @{kTabBarItemAttributeTitle : @"我的",
                                      kTabBarItemAttributeNormalImageName : @"Tabbaricon_D_2",
                                      kTabBarItemAttributeSelectedImageName : @"Tabbaricon_D_1",
                                      kTabBarItemAttributeType : @(MikoTabBarItemNormal)}];
    
    tabBar.delegate = self;
    _MikoTabBar     = tabBar;
    [self.tabBar addSubview:tabBar];
    tabBar.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0 ));
}

#pragma mark - TabBarDelegate
- (void)tabBarDidSelectedIconButton:(NSInteger)iconTag{
    NSLog(@"第%ld个tabbar",iconTag);
}

- (void)tabBarDidSelectedRiseButton{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
