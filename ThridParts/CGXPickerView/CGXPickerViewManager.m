//
//  CGXPickerViewManager.m
//  CGXPickerView
//
//  Created by 曹贵鑫 on 2018/1/8.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import "CGXPickerViewManager.h"

@interface CGXPickerViewManager ()

@end
@implementation CGXPickerViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _kPickerViewH   = 200;
        _kTopViewH      = 50;
        _pickerTitleSize  =15;
        _pickerTitleColor = [UIColor blackColor];
        _lineViewColor = CGXPickerRGBColor(225, 225, 225, 1);
       
        _titleLabelColor = CGXPickerRGBColor(118, 202, 138, 1);
        _titleSize = 16;
        _titleLabelBGColor = [UIColor whiteColor];
        
        _rightBtnTitle   = @"完成";
        _rightBtnBGColor  = CGXPickerRGBColor(255, 255, 255, 1);
        _rightBtnTitleSize = 16;
        _rightBtnTitleColor = CGXPickerRGBColor(67, 67, 67, 1);
        
        _rightBtnborderColor = CGXPickerRGBColor(255, 255, 255, 1);
        _rightBtnCornerRadius = 6;
        _rightBtnBorderWidth  = 1;
        
        
        
        _leftBtnTitle = @"取消";
        _leftBtnBGColor  =  CGXPickerRGBColor(255, 255, 255, 1);
        _leftBtnTitleSize = 16;
        _leftBtnTitleColor = CGXPickerRGBColor(67, 67, 67, 1);
        
        _leftBtnborderColor = CGXPickerRGBColor(255, 255, 255, 1);
        _leftBtnCornerRadius = 6;
        _leftBtnBorderWidth = 1;
        
    }
    return self;
}
@end
