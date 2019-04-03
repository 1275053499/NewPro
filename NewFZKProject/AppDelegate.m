//
//  AppDelegate.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/2.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "AppDelegate.h"
#import "AppleProtocalView.h"
@interface AppDelegate ()
@property (nonatomic, strong) FZKMianVC *mainVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 启动图片延时: 1秒
    [NSThread sleepForTimeInterval:0.5];
    
    
    
    /************rootview************/
    [self buidMain     ];
    /************rootview************/
    
    /************键盘设置************/
    [self setIQKEY     ];
    /************键盘设置************/
    return YES;
}
#pragma mark - 选择tabbar index
- (void)setSelectedTabBarIndex:(NSInteger)index{
    [self.mainVC.MikoTabBar setSelectedIndex:index];
}

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (void)buidMain{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor     = [UIColor whiteColor];
    
    //    if (![UserDedaults objectForKey:@"firstLogin"]) {//第一次登录
    //        FZKGuidePageView * guidePageView = [[FZKGuidePageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    //        guidePageView.guidePageBlcok = ^(UIView *view) {
    //
    //            FZKMianVC * mainVC              = [[FZKMianVC alloc] init];
    //            self.mainVC = mainVC;
    //            self.window.rootViewController  = mainVC;
    //
    //             if (![[NSUserDefaults standardUserDefaults] boolForKey:@"YSZC"]) {
    //
    //                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //                        AppleProtocalView *View = [[AppleProtocalView alloc]init];
    //                        View.UseBgClose = NO;
    //                        [View show];
    //
    //                 });
    //             }
    //        };
    //        self.window.rootViewController          =  [[UIViewController alloc]init];
    //        [self.window.rootViewController.view addSubview:guidePageView];
    //        [self.window makeKeyAndVisible         ];
    //    }else{
    //        FZKMianVC * mainVC              = [[FZKMianVC alloc] init];
    //        self.window.rootViewController  = mainVC;
    //        self.mainVC = mainVC;
    //        [self.window makeKeyAndVisible         ];
    //
    //    }
    
    FZKMianVC * mainVC              = [[FZKMianVC alloc] init];
    self.window.rootViewController  = mainVC;
    self.mainVC                     = mainVC;
    [self.window makeKeyAndVisible         ];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"YSZC"]) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            AppleProtocalView *View = [[AppleProtocalView alloc]init];
            View.UseBgClose = NO;
            [View show];
            
        });
    }
}

-(void)setIQKEY{
    
    //键盘处理
    //写入这个方法后,这个页面将没有这种效果
    //    [IQKeyboardManager sharedManager].enable = YES;
    //在键盘上方有一个tooBar,当我们不想它显示出来的时候
    //    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
