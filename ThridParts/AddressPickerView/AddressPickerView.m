//
//  AddressPickerView.m
//  testUTF8
//
//  Created by rhcf_wujh on 16/7/14.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "AddressPickerView.h"

#define SELFSIZE self.bounds.size
#define APBOUNDS [UIScreen mainScreen].bounds
#define APSIZE [UIScreen mainScreen].bounds.size
#define APBLUE [UIColor colorWithRed:30/255.0 green:112/255.0 blue:203/255.0 alpha:1]
static CGFloat const TITLEHEIGHT = 44.0;
static CGFloat const TITLEBUTTONWIDTH = 75.0;
static CGFloat const PICKERHEIGHT = 220.0f;
static CGFloat const OFFSET = 264.0f;

@interface AddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView   * maskBgView;
@property (nonatomic, strong) UIView   * pickView;
@property (nonatomic ,strong) UIView   * titleBackgroundView;/**< 标题栏背景*/
@property (nonatomic ,strong) UIButton * cancelBtn;/**< 取消按钮*/
@property (nonatomic, strong) UIButton * sureBtn;/**< 完成按钮*/
@property (nonatomic ,strong) UIPickerView   * addressPickerView;/**< 选择器*/

@property (nonatomic, strong) NSMutableArray *dayaArray;

@end
@implementation AddressPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //加载地址数据源
        [self loadAddressData];
        //加载选择器
        [self loadPickerView];
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:APBOUNDS];
}

#pragma mark - lazy

- (UIView *)maskBgView {
    if (!_maskBgView) {
        _maskBgView = [[UIView alloc] initWithFrame:APBOUNDS];
        _maskBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [_maskBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    }
    return _maskBgView;
}

- (UIView *)pickView {
    if (!_pickView) {
        _pickView = [[UIView alloc] initWithFrame:CGRectMake(0, APSIZE.height, APSIZE.width, OFFSET)];
    }
    return _pickView;
}

- (UIView *)titleBackgroundView{
    if (!_titleBackgroundView) {
        _titleBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APSIZE.width, TITLEHEIGHT)];
        _titleBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _titleBackgroundView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        
        _cancelBtn = [[UIButton alloc]initWithFrame:
                      CGRectMake(0, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_cancelBtn setTitle:@"取消"
                    forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:APBLUE
                         forState:UIControlStateNormal];
        [_cancelBtn addTarget:self
                       action:@selector(cancelBtnClicked)
             forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc]initWithFrame:
                    CGRectMake(SELFSIZE.width - TITLEBUTTONWIDTH, 0, TITLEBUTTONWIDTH, TITLEHEIGHT)];
        [_sureBtn setTitle:@"完成"
                  forState:UIControlStateNormal];
        [_sureBtn setTitleColor:APBLUE
                       forState:UIControlStateNormal];
        [_sureBtn addTarget:self
                     action:@selector(sureBtnClicked)
           forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
- (UIPickerView *)addressPickerView{
    if (!_addressPickerView) {
        _addressPickerView = [[UIPickerView alloc]initWithFrame:
                              CGRectMake(0, TITLEHEIGHT, APSIZE.width, PICKERHEIGHT)];
        _addressPickerView.backgroundColor = [UIColor colorWithRed:239/255.f
                                                             green:239/255.f
                                                              blue:244.0/255.f
                                                             alpha:1.0];
        _addressPickerView.delegate = self;
        _addressPickerView.dataSource = self;
    }
    return _addressPickerView;
}

#pragma mark  加载PickerView
- (void)loadPickerView{
    _pickerMode = APPickerModeArea;//默认3级选址
    
    //遮罩层
    [self addSubview:self.maskBgView];
    
    [self.titleBackgroundView addSubview:self.cancelBtn];
    [self.titleBackgroundView addSubview:self.sureBtn];
    [self.pickView addSubview:self.titleBackgroundView];
    [self.pickView addSubview:self.addressPickerView];
    
    [self addSubview:self.pickView];
}

- (void)setPickerMode:(APPickerMode)pickerMode {
    _pickerMode = pickerMode;
    [self.addressPickerView reloadAllComponents];
}

#pragma mark - 加载地址数据
- (void)loadAddressData{

    //JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"商家认证省市区" ofType:@"json"];
    
    //加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //将JSON数据转为NSArray或NSDictionary
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //将数组转为字典
    _dayaArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        GAreaModel *model = [[GAreaModel alloc] initWithDictionary:dict error:nil];
        [_dayaArray addObject:model];
    }
}

#pragma mark - UIPickerDatasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _pickerMode + 1;
}

//设置每列数量
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    if (0 == component) {
        return _dayaArray.count;
    }
    else if (1 == component){
        NSInteger selectProvince = [pickerView selectedRowInComponent:0];
        GAreaModel  * p            = _dayaArray[selectProvince];
        return p.children.count;
    }
    else if (2 == component){
        NSInteger selectProvince = [pickerView selectedRowInComponent:0];
        NSInteger selectCity     = [pickerView selectedRowInComponent:1];
        GAreaModel  * p            = _dayaArray[selectProvince];
        if (selectCity > p.children.count - 1) {
            return 0;
        }
        GCityModel * c = p.children[selectCity];
        return c.children.count;
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate
#pragma mark 填充文字
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    if (0 == component) {
        GAreaModel * p = _dayaArray[row];
        return p.name;
    }
    else if (1 == component) {
        GAreaModel * selectP = _dayaArray[[pickerView selectedRowInComponent:0]];//获取省滑动到的位置
        if (row > selectP.children.count - 1) {
            return nil;
        }
        GCityModel * city = selectP.children[row];
        return city.name;
    }
    else if (2 == component) {
        NSInteger selectProvince = [pickerView selectedRowInComponent:0];//获取省滑动到的位置
        NSInteger selectCity     = [pickerView selectedRowInComponent:1];//获取市滑动到的位置
        GAreaModel  * p            = _dayaArray[selectProvince];
        if (selectCity > p.children.count - 1) {
            return nil;
        }
        GCityModel * c = p.children[selectCity];
        if (row > c.children.count -1 ) {
            return nil;
        }
        GCountyModel *county = c.children[row];
        return county.name;
    }
    return nil;
}

#pragma mark pickerView被选中
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    if (0 == component) {
        switch (_pickerMode) {
            case APPickerModeProvince:
                break;
            case APPickerModeCity : {
                [self selectOneComponentWithPickerView:pickerView];
            }
                break;
            case APPickerModeArea: {
                [self selectOneComponentWithPickerView:pickerView];
                [self selectTwoComponentWithPickerView:pickerView];
            }
            default:
                break;
        }
    }
    else if (1 == component){
        switch (_pickerMode) {
            case APPickerModeArea: {
                [self selectTwoComponentWithPickerView:pickerView];
            }
                break;
                
            default:
                break;
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row forComponent:(NSInteger)component
           reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = [UIColor colorWithRed:51.0/255
                                                green:51.0/255
                                                 blue:51.0/255
                                                alpha:1.0];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    
    pickerLabel.text = [self pickerView:pickerView
                            titleForRow:row
                           forComponent:component];
    return pickerLabel;
}

- (void)selectOneComponentWithPickerView:(UIPickerView *)pickerView {
    NSInteger selectCity = [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectRow:selectCity inComponent:1 animated:YES];
}

- (void)selectTwoComponentWithPickerView:(UIPickerView *)pickerView {
    NSInteger selectCity = [pickerView selectedRowInComponent:2];
    [pickerView reloadComponent:2];
    [pickerView selectRow:selectCity inComponent:2 animated:YES];
}

#pragma mark - 解析json

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData  * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClicked{
    [self hide];
    if ([_delegate respondsToSelector:@selector(cancelBtnClick)]) {
        [_delegate cancelBtnClick];
    }
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.maskBgView.alpha = 0;
    self.pickView.frame = CGRectMake(0, APSIZE.height, APSIZE.width, OFFSET);
    [UIView animateWithDuration:.35 animations:^{
        self.maskBgView.alpha = 1;
        self.pickView.frame = CGRectMake(0, APSIZE.height - OFFSET, APSIZE.width, OFFSET);
    }];
}

- (void)hide{
    [UIView animateWithDuration:.35 animations:^{
        self.pickView.frame = CGRectMake(0, APSIZE.height, APSIZE.width, OFFSET);
        self.maskBgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)sureBtnClicked{
    [self hide];
    if ([_delegate respondsToSelector:@selector(sureBtnClickReturnProvince:City:Area:)]) {
        
        GAreaModel    *   p      = [self selectProvince];
        GCityModel    *   c      = [self selectCity];
        GCountyModel  *   county = [self selectArea];
        
        [_delegate sureBtnClickReturnProvince:p
                                         City:c
                                         Area:county];
    }
}

- (GAreaModel *)selectProvince {
    
    NSInteger selectProvince = [self.addressPickerView selectedRowInComponent:0];
    return _dayaArray[selectProvince];
}

- (GCityModel *)selectCity {
    
    NSInteger selectCity     = [self.addressPickerView selectedRowInComponent:1];
    GAreaModel * p = [self selectProvince];
    //解决省市同时滑动未结束时点击完成按钮的数组越界问题
    if (selectCity > p.children.count - 1) {
        selectCity = p.children.count - 1;
    }
    return p.children[selectCity];
}

- (GCountyModel *)selectArea {
    
    GCityModel * c = [self selectCity];
    NSInteger selectArea     = [self.addressPickerView selectedRowInComponent:2];
    //解决省市区同时滑动未结束时点击完成按钮的数组越界问题
    if (selectArea > c.children.count - 1) {
        selectArea = c.children.count - 1;
    }
    return c.children[selectArea];
}

@end
