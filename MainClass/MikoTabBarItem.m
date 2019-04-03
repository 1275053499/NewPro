//
//  MikoTabBarItem.m
//  FanZuKe
//
//  Created by yanjinlin on 2018/7/28.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import "MikoTabBarItem.h"

NSString *const kTabBarItemAttributeTitle               = @"TabBarItemAttributeTitle";
NSString *const kTabBarItemAttributeNormalImageName     = @"TabBarItemAttributeNormalImageName";
NSString *const kTabBarItemAttributeSelectedImageName   = @"TabBarItemAttributeSelectedImageName";
NSString *const kTabBarItemAttributeType                = @"TabBarItemAttributeType";


@implementation MikoTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self config];
    }
    
    return self;
}

- (void)config {
    self.adjustsImageWhenHighlighted = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    if (imageSize.width != 0 && imageSize.height != 0) {
        CGFloat imageViewCenterY = CGRectGetHeight(self.frame) - 3 - titleSize.height - imageSize.height / 2 - 5;
        self.imageView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, imageViewCenterY-3);
    } else {
        CGPoint imageViewCenter = self.imageView.center;
        imageViewCenter.x = CGRectGetWidth(self.frame) / 2;
        imageViewCenter.y = (CGRectGetHeight(self.frame) - titleSize.height) / 2;
        self.imageView.center = imageViewCenter;
    }
    
    CGPoint labelCenter = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) - 3 - titleSize.height / 2-3);
    self.titleLabel.center = labelCenter;
    
}


@end
