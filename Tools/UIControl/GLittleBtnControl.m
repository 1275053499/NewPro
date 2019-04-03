
//
//  GLittleBtnControl.m
//  GOUDIWANG
//
//  Created by lee on 2017/11/9.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "GLittleBtnControl.h"

@implementation GLittleBtnControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    _titleLb = [[UILabel alloc] init];
    _titleLb.textColor = RGB(51, 51, 51);
    _titleLb.font = XFont(13);
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLb];

    _iconImgV = [[UIImageView alloc] init];
    _iconImgV.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_iconImgV];
    [_iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.height.mas_offset(20);
    }];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.right.equalTo(self).offset(-8);
        make.height.mas_offset(21);
        make.top.equalTo(self->_iconImgV.mas_bottom);
    }];
}

-(void)setTitleLbFont:(float)titleLbFont{
    _titleLb.font = XFont(titleLbFont);
    _titleLbFont = titleLbFont;
}
-(void)setTitleLbColor:(UIColor *)titleLbColor{
    _titleLb.textColor = titleLbColor;
    _titleLbColor = titleLbColor;
}
@end
