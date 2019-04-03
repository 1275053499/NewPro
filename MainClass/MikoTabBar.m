//
//  MikoTabBar.m
//  FanZuKe
//
//  Created by yanjinlin on 2018/7/28.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import "MikoTabBar.h"

@interface MikoTabBar ()

@property (strong, nonatomic) NSMutableArray *tabBarItems;

@end

@implementation MikoTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (void)config {
    
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, SCREEN_WIDTH, 5)];
    topLine.image = [UIImage imageNamed:@"Tabbaricon_line"];
    [self addSubview:topLine];
}

- (void)setSelectedIndex:(NSInteger)index {
    
    for (MikoTabBarItem *item in self.tabBarItems) {
        if (item.tag == index) {
            item.selected = YES;
        } else {
            item.selected = NO;
        }
    }
    
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    UITabBarController *tabBarController = (UITabBarController *)keyWindow.rootViewController;
    if (tabBarController) {
        tabBarController.selectedIndex = index;
    }
}

- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath       = @"transform.scale";
    animation.values        = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration      = 1;
    animation.repeatCount   = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

#pragma mark - Touch Event

- (void)itemSelected:(MikoTabBarItem *)sender {
    
    if (sender.tabBarItemType != MikoTabBarItemRise) {
       
//        if ((!ISLOGIN && sender.tag == 2)||(!ISLOGIN && sender.tag == 3)) {
        if ((sender.tag == 3)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[YJLTools Sharemanager] GotoLogin:NO];
                    [KEYWINDOW makeToast:@"需求去登录页面" duration:1 position:CSToastPositionCenter];

            });
            return;
        }
        
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedIconButton:)]) {
                [self.delegate tabBarDidSelectedIconButton:sender.tag];
            }
        }
        [self setSelectedIndex:sender.tag];
        [self  addScaleAnimationOnView:sender repeatCount:1];
    } else {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedRiseButton)]) {
                [self.delegate tabBarDidSelectedRiseButton];
            }
        }
    }
}

#pragma mark - Setter

- (void)setTabBarItemAttributes:(NSArray<NSDictionary *> *)tabBarItemAttributes {
    _tabBarItemAttributes = tabBarItemAttributes.copy;
    
    CGFloat itemWidth = SCREEN_WIDTH / _tabBarItemAttributes.count;
    CGFloat tabBarHeight = CGRectGetHeight(self.frame);
    NSInteger itemTag = 0;
    BOOL passedRiseItem = NO;
    
    _tabBarItems = [NSMutableArray arrayWithCapacity:_tabBarItemAttributes.count];
    for (id item in _tabBarItemAttributes) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            NSDictionary *itemDict = (NSDictionary *)item;
            
            MikoTabBarItemType type = [itemDict[kTabBarItemAttributeType] integerValue];
            CGRect frame = CGRectMake(itemTag * itemWidth + (passedRiseItem ? itemWidth : 0), 0, itemWidth, tabBarHeight);
            
            MikoTabBarItem *tabBarItem = [self tabBarItemWithFrame:frame
                                                           title:itemDict[kTabBarItemAttributeTitle]
                                                 normalImageName:itemDict[kTabBarItemAttributeNormalImageName]
                                               selectedImageName:itemDict[kTabBarItemAttributeSelectedImageName] tabBarItemType:type];
            if (itemTag == 0) {
                tabBarItem.selected = YES;
            }
            
            [tabBarItem addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            if (tabBarItem.tabBarItemType != MikoTabBarItemRise) {
                tabBarItem.tag = itemTag;
                itemTag++;
            } else {
                passedRiseItem = YES;
            }
            
            [_tabBarItems addObject:tabBarItem];
            [self addSubview:tabBarItem];
        }
    }
}

- (MikoTabBarItem *)tabBarItemWithFrame:(CGRect)frame
                                title:(NSString *)title
                      normalImageName:(NSString *)normalImageName
                    selectedImageName:(NSString *)selectedImageName
                       tabBarItemType:(MikoTabBarItemType)tabBarItemType {
    
    MikoTabBarItem *item = [[MikoTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:10];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setTitleColor:GreyColor forState:UIControlStateNormal];
    [item setTitleColor:MainColor forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}


@end
