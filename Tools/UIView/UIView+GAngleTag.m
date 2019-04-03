//
//  UIView+GAngleTag.m
//  GOUDIWANG
//
//  Created by 曾国锐 on 2017/10/24.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "UIView+GAngleTag.h"
#import "UIView+Extension.h"
@interface UIView ()


@end

@implementation UIView (GAngleTag)
- (void)addAngleTagWithNumber:(NSString *)number{
    
    [self clearNumber];
    
    if ([number isEqualToString:@"0"]) {
       
        return;
    }
    
    CGSize textSize = [number sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    if (textSize.width < 12) {
        textSize.width = 18;
    }else if (textSize.width > 12){
        textSize.width = textSize.width + 10;
    }
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:label3];
    label3.text = number;
    label3.textColor = [UIColor whiteColor];
    label3.numberOfLines = 0;
    label3.font = [UIFont systemFontOfSize:9];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.frame = CGRectMake(self.frame.size.width-textSize.width/2-4., -6.5, textSize.width-2, 16);
    label3.backgroundColor = [UIColor redColor];
    label3.tag = 401;
    
    label3.layer.borderWidth = 1.0f;
    label3.layer.cornerRadius = 8;
    label3.layer.masksToBounds = YES;
    label3.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setEdgeInsetsMakeTop:(CGFloat)topY{
    UILabel *label = (UILabel *)[self viewWithTag:401];
    label.y = topY;
}

- (void)setEdgeInsetsMakeX:(CGFloat)leadingX{
    UILabel *label = (UILabel *)[self viewWithTag:401];
    label.x = leadingX;
}

- (void)clearNumber{
    UILabel *label = (UILabel *)[self viewWithTag:401];
    [label removeFromSuperview];
}



@end
