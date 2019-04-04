//
//  NewProRuZhuVC.m
//  NewFZKProject
//
//  Created by yanjinlin on 2019/4/4.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "NewProRuZhuVC.h"
#import "GMNrelanameDownCell.h"
#import "GMNmerchantTopSubCell.h"
#import "GMNmerchantsModel.h"
#import <Contacts/Contacts.h>
#import "GMNrealnameGetModel.h"
#import "GMNrelanamecodeCell.h"
#import "GMNrelanamecommitCell.h"
#import "PersonaldataTopCell.h"
#import "AddressPickerView.h"
#import "NewProRuZhuSXVC.h"
@interface NewProRuZhuVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AddressPickerViewDelegate,AMapSearchDelegate>
@property (nonatomic, strong) UITableView      *   tableView;
@property (nonatomic, strong) GMNmerchantsModel *   merchantsModel;
@property (nonatomic, strong) NSString *TXLtext;
@property (nonatomic, strong) GMNrealnameGetModel *   InfoModel;
@property (nonatomic, assign) BOOL  canchangevalue;
@property(nonatomic,assign) float  sizeheight;//初始化
@property (nonatomic, strong) GMNrelanameDownCell *photoCell;

@property (nonatomic, strong)UIImagePickerController *imagePickerController;
@property (nonatomic, strong)NSString *image1;
@property (nonatomic, strong)NSString *image2;

@property (nonatomic, strong) AddressPickerView * pickerView;
@property (nonatomic, strong) NSMutableArray * JsonArray;
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) NSArray<AMapGeocode *> *geocodes;

@end

@implementation NewProRuZhuVC

- (AddressPickerView *)pickerView{
    
    if (!_pickerView) {
        _pickerView             = [[AddressPickerView alloc]init];
        _pickerView.delegate    = self;
        //        _pickerView.pickerMode  = APPickerModeArea;
    }
    return _pickerView;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self GetJsonData   ];//获取街道数据
   
}

-(void)GetJsonData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        //JSON文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"商家认证街道" ofType:@"json"];
        
        //加载JSON文件
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        //将JSON数据转为NSArray或NSDictionary
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.JsonArray = [[NSMutableArray alloc]init];
        //将数组转为字典
        for (NSDictionary *dict in dictArray) {
            GAreaModel *model = [[GAreaModel alloc] initWithDictionary:dict error:nil];
            [ self.JsonArray addObject:model];
        }
        
        NSLog(@"json数据个数:%ld",self.JsonArray.count);
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title         = @"申请入驻";
    [self makeBackBtn  ];
    
    if (self.merchantsModel.renlian) {
        
    }else{
        self.merchantsModel         = [[GMNmerchantsModel alloc] init];
        self.merchantsModel.renlian = NO;
        self.merchantsModel.images  = [NSMutableArray arrayWithCapacity:2];
        for (int i = 0; i < 2; i++) {
            [self.merchantsModel.images addObject:[NSNull null]];
        }
        NSLog(@"初始化图片存储:%@",self.merchantsModel.images);
        //        [self maketableview];
        [self getoldinfo   ];
    }
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        self.tableView              = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        self.tableView.delegate     = self;
        self.tableView.dataSource   = self;
        self.tableView.bounces      = NO;
        [self.view addSubview:self.tableView];
        self.tableView.sectionFooterHeight = 1.0;
        self.tableView.estimatedSectionFooterHeight = 0.0;
        self.tableView.estimatedSectionHeaderHeight = 0.0;
        self.tableView.showsHorizontalScrollIndicator   = NO;
        self.tableView.showsVerticalScrollIndicator     = NO;
        self.tableView.tableFooterView =[UIView new];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, kSafeHeight, 0));
        
        [ self.tableView registerNib:[UINib nibWithNibName:@"PersonaldataTopCell" bundle:nil] forCellReuseIdentifier:@"PersonaldataTopCell"];
       
    }
    
    return _tableView;
    
}

//黑色返回
- (void)makeBackBtn
{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"NewBack"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)dismiss{
    
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"timercancel" object:nil];

    return;
    
    
    NewProAlertView * alertview         = [[[NSBundle mainBundle]loadNibNamed:@"NewProAlertView" owner:nil options:nil]lastObject];
    alertview.alerttitle_1.text         = @"认证未完成,确认退出";
    alertview.alerttitle_1.textColor    = RGBA(225, 194, 133, 1);
    alertview.alerttitle_1.font         = XFont(14);
    
//    alertview.alerttitle_2.text         = @"管理费标准:1年/300元、1月/100元";
//    alertview.alerttitle_2.textColor    = RGBA(102, 102, 102, 1);
//    alertview.alerttitle_2.font         = XFont(11);
    
    alertview.iS_single         = YES;//只显示一个文本
    
    [alertview.leftbtn  setTitle:@"确定" forState:UIControlStateNormal];
    [alertview.rightbtn setTitle:@"取消" forState:UIControlStateNormal];
    alertview.backgroundColor           = RGBA(0, 0, 0, 0.7);
    [KEYWINDOW addSubview:alertview];
    alertview.AlertBlock = ^(NSInteger index) {
        if (index==1) {//右边按钮
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"timercancel" object:nil];
            
        }else{
            
        }
    };
}

#pragma mark  获取之前的认证信息
-(void)getoldinfo{
    [self makebase];
//    [HttpsRequest SelicePOST:Url_selice_api_person_certified parameters:nil success:^(id responseObject) {
//
//        NSLog(@"%@",responseObject);
//        if ([responseObject[@"code"] integerValue]==200) {
//            self.InfoModel = [[GMNrealnameGetModel alloc]initWithDictionary:responseObject error:nil];
//            [self makebase];
//        }
//
//    } failure:^(NSError *error) {
//        [GMNTools showNetLinkerErrorViewFromCurrentView:self.view reloadClick:^(NSInteger index) {
//            switch (index) {
//                case 0:{
//                    [self getoldinfo];
//                }break;
//
//                default:{
//
//                    [self dismissViewControllerAnimated:YES completion:NULL];
//                    [[NSNotificationCenter defaultCenter]postNotificationName:@"timercancel" object:nil];
//                }
//                    break;
//            }
//        }];
//    }];
}

-(void)makebase{
    
    if (self.InfoModel.data.token.length>0) {
        
        self.merchantsModel.contact = self.InfoModel.data.real_name;
        self.merchantsModel.sex     = self.InfoModel.data.true_sex.integerValue==1?@"男":@"女";
        self.merchantsModel.Idcard  = self.InfoModel.data.card_id;
        self.merchantsModel.bank    = self.InfoModel.data.bankcard;
        self.merchantsModel.phone   = self.InfoModel.data.mobile;
        self.canchangevalue         = NO;
        self.merchantsModel.codenum = @"";
        
    }else{
        
        self.merchantsModel.contact = @"";
        self.merchantsModel.sex     = @"";
        self.merchantsModel.Idcard  = @"";
        self.merchantsModel.bank    = @"";
        self.merchantsModel.phone   = @"153221321312";
        self.canchangevalue         = YES;
        self.merchantsModel.codenum = @"";
    }
    
    [self.tableView reloadData];
}

-(void)maketableview{
    
    self.tableView              = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    self.tableView.bounces      = NO;
    [self.view addSubview:self.tableView];
    self.tableView.sectionFooterHeight = 1.0;
    self.tableView.estimatedSectionFooterHeight = 0.0;
    self.tableView.estimatedSectionHeaderHeight = 0.0;
    self.tableView.showsHorizontalScrollIndicator   = NO;
    self.tableView.showsVerticalScrollIndicator     = NO;
    self.tableView.tableFooterView =[UIView new];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, kSafeHeight, 0));
    
}

#pragma mark - UITableView DataSource Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 13;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        case 0://个人头像
        {
//           PersonaldataTopCell *cell = [PersonaldataTopCell cellWithTableView:tableView];
//           [cell.IMG sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
            
            PersonaldataTopCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PersonaldataTopCell" forIndexPath:indexPath];
            
            [cell.IMG sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
            
            return cell;
            break;
        }
        case 1://店铺名称
        {
            
            GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
            cell.lineview.hidden        = YES;
            cell.title.text             = @"商铺名称";
            cell.textfield.placeholder  = @"请输入您的商铺名称";
            cell.textfield.text         = _merchantsModel.contact;
            [cell.textfield addTarget:self action:@selector(textFieldChanged_1:) forControlEvents:UIControlEventEditingChanged];
            return cell;
            break;
        }
           
        case 2://商家属性
        {
            
            GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
            cell.lineview.hidden        = YES;
            cell.title.text             = @"入驻属性";
            cell.textfield.placeholder  = @"线上商家";
            cell.textfield.text         = _merchantsModel.address;
            cell.turnimg.hidden         = NO;
            cell.textfield.enabled      = NO;
            return cell;
            break;
        }
        case 3://省市区
        {
            
            GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
            cell.lineview.hidden    = YES;
            cell.title.text         = @"所在地区";
            cell.textfield.placeholder = @"请选择省市区";
            cell.textfield.text     = _merchantsModel.address;
            cell.turnimg.hidden     = NO;
            cell.textfield.enabled  = NO;
            return cell;
            break;
        }
            
        case 4://街道
        {
            GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
            cell.lineview.hidden    = YES;
            cell.title.text         = @"所在街道";
            cell.textfield.placeholder = @"请输所在街道";
            cell.textfield.text = _merchantsModel.street;
            cell.turnimg.hidden = NO;
            cell.textfield.enabled = NO;
            return  cell;
             break;
        }
           
        case 5://微信
        {
            
            GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
            cell.lineview.hidden        = YES;
            cell.title.text             = @"店家微信";
            cell.textfield.placeholder  = @"请输入";
            cell.textfield.text = _merchantsModel.contact;
            [cell.textfield addTarget:self action:@selector(textFieldChanged_1:) forControlEvents:UIControlEventEditingChanged];
            return cell;
            break;
        }
           
        case 6://身份证
        {
                GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
                cell.lineview.hidden = YES;
                cell.title.text = @"身份证";
                cell.textfield.placeholder  = @"请输入身份证号码";
                cell.textfield.text         = _merchantsModel.Idcard;
                [cell.textfield addTarget:self action:@selector(textFieldChanged_2:) forControlEvents:UIControlEventEditingChanged];
                cell.textfield.keyboardType = UIKeyboardTypeASCIICapable;
                return cell;
                break;
        }
           
        case 7://银行卡
        {
            
            GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
            cell.lineview.hidden       = YES;
            cell.title.text             = @"银行卡号";
            cell.textfield.placeholder = @"请输入本人绑定卡号";
            cell.textfield.text         = _merchantsModel.bank;
            [cell.textfield addTarget:self action:@selector(textFieldChanged_3:) forControlEvents:UIControlEventEditingChanged];
            cell.textfield.keyboardType = UIKeyboardTypeNumberPad;
            return cell;
            break;
        }
           
        case 8://号码
        {
            
            GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
            cell.lineview.hidden        = YES;
            cell.title.text             = @"手机号码";
            cell.textfield.text         = _merchantsModel.phone.length>8? [YJLTools_sub changeTelephone:_merchantsModel.phone]:_merchantsModel.phone;
            cell.textfield.enabled      = NO;
            return cell;
             break;
        }
           
        case 9://验证码
        {
            
            GMNrelanamecodeCell *cell = [GMNrelanamecodeCell cellWithTableView:tableView];
            cell.code.text            = _merchantsModel.codenum;
            [cell.code addTarget:self action:@selector(textFieldChanged_4:) forControlEvents:UIControlEventEditingChanged];
            return cell;
             break;
        }
           
        case 10://相片
        {
            
            //            WEAK
            GMNrelanameDownCell *cell = [GMNrelanameDownCell cellWithTableView:tableView];
            self.photoCell = cell;
            [cell.leftBtn addTarget:self action:@selector(leftimgAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.rightBtn addTarget:self action:@selector(rightimgAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
             break;
        }
           
        case 11://人脸
        {
            GMNmerchantTopSubCell *cell = [GMNmerchantTopSubCell cellWithTableView:tableView];
            cell.title.text             = @"人脸认证";
            cell.textfield.placeholder  = @"去认证";
            cell.textfield.text         = _merchantsModel.renlian?@"已认证":@"";
            cell.textfield.enabled      =    NO;
            cell.turnimg.hidden         = _merchantsModel.renlian;
            return cell;
            break;
        }
           
        case 12://提交
        {
            
            GMNrelanamecommitCell *cell = [GMNrelanamecommitCell cellWithTableView:tableView];
            [cell.Commit addTarget:self action:@selector(commitdata:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            break;
        }
        default:{
            return [UITableViewCell new];
        }
           
    }
}


-(void)leftimgAction:(UIButton *)sender{
    self.image1 = @"yes";
    self.image2 = @"no";
    [self showphoto];
}

-(void)rightimgAction:(UIButton *)sender{
    self.image1 = @"no";
    self.image2 = @"yes";
    [self showphoto];
}


-(void)showphoto{
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    WEAK
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                NSString *errorStr = @"请您设置允许APP访问您的相机->设置->隐私->相机";
                [KEYWINDOW makeToast:errorStr duration:1 position:CSToastPositionCenter];
                
            }else{
                STRONG
                BOOL isOpen = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
                if (isOpen) {
                    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;//相机获取照片
                    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;//相机捕获类型
                    self.imagePickerController.delegate   = self;
                    [self presentViewController:self.imagePickerController animated:YES completion:nil];
                }
            }
        }];
        
        UIAlertAction *deleteAction2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            self.imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePickerController.delegate   = self;
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Cancel Action");
        }];
        [deleteAction setValue:MainColor forKey:@"titleTextColor"];
        [deleteAction2 setValue:MainColor forKey:@"titleTextColor"];
        [cancelAction setValue:RGB(67,67,67) forKey:@"titleTextColor"];
        [alertController addAction:deleteAction];
        [alertController addAction:deleteAction2];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    });
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    // 获得原始的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
    NSLog(@"原始图片信息:%@",image);
    
    if ([self.image1 isEqualToString:@"yes"]) {
        self.photoCell.leftImg.image = image;
        [self.merchantsModel.images replaceObjectAtIndex:0 withObject:image];
    }
    
    if ([self.image2 isEqualToString:@"yes"]) {
        self.photoCell.rightImg.image = image;
        [self.merchantsModel.images replaceObjectAtIndex:1 withObject:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==10) {
        return 220;
    }else if (indexPath.section==12){
        return 140;
    }else if (indexPath.section==0){
        return 75;
    }
    
    else{
        return 51;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1||section==12||section==6) {
        return 10;
    }else{
        return 0.000001f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2) {
        NewProRuZhuSXVC *VC= [[NewProRuZhuSXVC alloc]init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.RZSX = ^(NSString * text, NSString * index) {
            
             [KEYWINDOW makeToast:[NSString stringWithFormat:@"%@-%@",text,index] duration:1 position:CSToastPositionCenter];
            
        };
        [self.navigationController pushViewController:VC animated:YES];
        
    }

    if (indexPath.section==3) {//
        //选择省市区
        [self choosecity];
    
    }
    
    if (indexPath.section==4) {//
       
        //街道
        if (self.merchantsModel.address.length<1) {
            [KEYWINDOW makeToast:@"请先选择省市区" duration:1 position:CSToastPositionCenter];
            return;
        }
        [self choosestreet];
    }
    
    
    if (indexPath.section==10)
    {//认证
        if (_merchantsModel.codenum.length<1) {
            
            [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写验证码" During:1.0f];
            return;
        }
        
        for (int i =0; i<_merchantsModel.images.count; i++) {
            if ([_merchantsModel.images[i] isEqual:[NSNull null]]) {
                [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请按要求上传必要照片" During:1.0f];
                return;
            }
        }
        
        if (self.merchantsModel.renlian) {
            return;
        }else{
            
//            [self startrenlian];
        }
    }
}

/*
#pragma mark  人脸识别信息比对
-(void)startrenlian{
    
    if (self.InfoModel.data.token.length>0) {
//        WEAK
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"message:@"是否确认使用当前填写信息进行认证" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            STRONG
            [RPSDK start: self.InfoModel.data.token rpCompleted:^(AUDIT auditState) {
                NSLog(@"verifyResult = %ld",(unsigned long)auditState);
                if(auditState == AUDIT_PASS) { //认证通过

                    [KEYWINDOW makeToast:@"认证通过" duration:1 position:CSToastPositionCenter];
                    self.merchantsModel.renlian = YES;

                    [UIView performWithoutAnimation:^{

                        [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:7] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                }
                else if(auditState == AUDIT_FAIL) { //认证不通过
                    [KEYWINDOW makeToast:@"认证不通过" duration:1 position:CSToastPositionCenter];

                }
                else if(auditState == AUDIT_IN_AUDIT) { //认证中，通常不会出现，只有在认证审核系统内部出现超时，未在限定时间内返回认证结果时出现。此时提示用户系统处理中，稍后查看认证结果即可。
                    [KEYWINDOW makeToast:@"认证中" duration:1 position:CSToastPositionCenter];

                }
                else if(auditState == AUDIT_NOT) { //未认证，用户取消
                    [KEYWINDOW makeToast:@"未认证，用户取消" duration:1 position:CSToastPositionCenter];
                }
                else if(auditState == AUDIT_EXCEPTION) { //系统异常
                    [KEYWINDOW makeToast:@"系统异常" duration:1 position:CSToastPositionCenter];
                }
            }withVC:self.navigationController];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];           // A
        [alertController addAction:cancelAction];       // B
        [cancelAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
        [okAction setValue:MainColor forKey:@"titleTextColor"];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        if (_merchantsModel.contact.length<1) {
            [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写您的姓名" During:1.0f];
            return;
        }
        
        if (_merchantsModel.sex.length<1 ) {
            [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确选择您的性别" During:1.0f];
            return;
        }
        if (_merchantsModel.Idcard.length<1) {
            [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写您的身份证号码" During:1.0f];
            return;
        }
        if (_merchantsModel.bank.length<1) {
            [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写您的银行卡号" During:1.0f];
            return;
        }
        if (_merchantsModel.phone.length<1) {
            
            [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写手机号码" During:1.0f];
            return;
        }
        if (_merchantsModel.codenum.length<1) {
            
            [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写验证码" During:1.0f];
            return;
        }
        
        for (int i =0; i<_merchantsModel.images.count; i++) {
            if ([_merchantsModel.images[i] isEqual:[NSNull null]]) {
                [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请按要求上传必要照片" During:1.0f];
                return;
            }
        }
        WEAK
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"message:@"是否确认使用当前填写信息进行认证" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            STRONG
            NSDictionary *dic = @{@"real_name"      :self.merchantsModel.contact
                                  ,@"true_sex"      :[self.merchantsModel.sex isEqualToString:@"男"]?@"1":@"2"
                                  ,@"card_number"   :self.merchantsModel.Idcard
                                  ,@"bank_account"  :self.merchantsModel.bank
                                  ,@"mobile"        :self.merchantsModel.phone
                                  ,@"status"        :@"1"
                                  ,@"code":          self.merchantsModel.codenum
                                  };
            NSLog(@"人脸验证参数  ：%@",dic);
            [GMBProgressShower showLoadData:self.view Text:@"信息验证中..."];
            [HttpsRequest SelicePOST:Url_selice_api_person_authentication parameters:dic success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                [GMBProgressShower hideHUDForView:self.view animated:NO];

                if ([responseObject[@"code"] integerValue]==200) {
                    self.canchangevalue = NO;
                    [KEYWINDOW makeToast:@"开启人脸认证" duration:1 position:CSToastPositionCenter];
                    [RPSDK start: responseObject[@"data"] rpCompleted:^(AUDIT auditState) {
                        NSLog(@"verifyResult = %ld",(unsigned long)auditState);
                        if(auditState == AUDIT_PASS) { //认证通过

                            [KEYWINDOW makeToast:@"认证通过" duration:1 position:CSToastPositionCenter];
                            self.merchantsModel.renlian = YES;

                            [UIView performWithoutAnimation:^{

                                //                                    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone ];
                                //                                    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:1] withRowAnimation:UITableViewRowAnimationNone ];
                                //                                    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:2] withRowAnimation:UITableViewRowAnimationNone ];
                                //                                    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:3] withRowAnimation:UITableViewRowAnimationNone ];
                                //                                    [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
                                [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:7] withRowAnimation:UITableViewRowAnimationNone];
                            }];
                        }
                        else if(auditState == AUDIT_FAIL) { //认证不通过
                            [KEYWINDOW makeToast:@"认证不通过" duration:1 position:CSToastPositionCenter];

                        }
                        else if(auditState == AUDIT_IN_AUDIT) { //认证中，通常不会出现，只有在认证审核系统内部出现超时，未在限定时间内返回认证结果时出现。此时提示用户系统处理中，稍后查看认证结果即可。
                            [KEYWINDOW makeToast:@"认证中" duration:1 position:CSToastPositionCenter];


                        }
                        else if(auditState == AUDIT_NOT) { //未认证，用户取消
                            [KEYWINDOW makeToast:@"未认证，用户取消" duration:1 position:CSToastPositionCenter];
                        }
                        else if(auditState == AUDIT_EXCEPTION) { //系统异常
                            [KEYWINDOW makeToast:@"系统异常" duration:1 position:CSToastPositionCenter];
                        }
                    }withVC:self.navigationController];
                    
                    
//                     说明
//                     verifyToken参数由接入方的服务端调用实人认证服务的GetVerifyToken接口获得。
//                     认证的结果由回调的方式返回，并携带状态。
                    
                    
                }else{
                    [KEYWINDOW makeToast:responseObject[@"msg"] duration:1 position:CSToastPositionCenter];
                }
            } failure:^(NSError *error) {

                [GMBProgressShower hideHUDForView:self.view animated:NO];
            }];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:okAction];           // A
        [alertController addAction:cancelAction];       // B
        [cancelAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
        [okAction setValue:MainColor forKey:@"titleTextColor"];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


*/

-(void)commitdata:(UIButton *)btn{
    NSLog(@"提交数据");
    NSLog(@"%@",_merchantsModel);
    if (_merchantsModel.contact.length<1) {
        [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写您的姓名" During:1.0f];
        return;
    }
    
    if (_merchantsModel.sex.length<1 ) {
        [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确选择您的性别" During:1.0f];
        return;
    }
    if (_merchantsModel.Idcard.length<1) {
        [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写您的身份证号码" During:1.0f];
        return;
    }
    
    if ([[YJLTools Sharemanager]IsChinese:_merchantsModel.Idcard]) {
        [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写您的身份证号码" During:1.0f];
        return;
    }
    
    if (_merchantsModel.bank.length<1) {
        [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写您的银行卡号" During:1.0f];
        return;
    }
    if (_merchantsModel.phone.length<1) {
        
        [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写手机号码" During:1.0f];
        return;
    }
    if (_merchantsModel.codenum.length<1) {
        
        [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请正确填写验证码" During:1.0f];
        return;
    }
    
    if (!_merchantsModel.renlian) {
        [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请先完成人脸认证" During:1.0f];
        return;
    }
    
    for (int i =0; i<_merchantsModel.images.count; i++) {
        if ([_merchantsModel.images[i] isEqual:[NSNull null]]) {
            [GMBHud showTextInCustomImgofPng:KEYWINDOW Text:@"请按要求上传必要照片" During:1.0f];
            return;
        }
    }
    
    
//    [self upload];
}



/*

#pragma mark 上传信息
-(void)upload{
    
    NSLog(@"%@",_merchantsModel);
    __weak typeof(self) weakself = self;
    
    [GMBProgressShower showLoadData:self.view Text:@"信息上传中..."];
    AFHTTPSessionManager *manager   = [AFHTTPSessionManager manager];
    manager.requestSerializer       = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer      = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    NSDictionary *headerFieldValueDictionary;
    
//    if ([[HDLoginModel shareLoginModelManager] hasToken]) {
//        headerFieldValueDictionary = @{@"Role":@"IOS",@"token":[[HDLoginModel shareLoginModelManager] isToken]};
//    }else{
//        headerFieldValueDictionary = @{@"Role":@"IOS"};
//    }
    
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@",HttpBaseUrl,Url_selice_api_person_authentication] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
        NSLog(@"%@",HttpBaseUrl);
        
        for(NSInteger i = 0; i < self.merchantsModel.images.count; i++){
            
            //            NSData *imageData = UIImageJPEGRepresentation(self.merchantsModel.images[i], 0.5);
            //            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            //            // 要解决此问题，
            //            // 可以在上传时使用当前的系统事件作为文件名
            //            CGFloat count = 100;
            //            NSLog(@"图片大小%ld",imageData.length);
            //            while (imageData.length > 1024000) {
            //                count     = count - 10;
            //                imageData =  UIImageJPEGRepresentation(self.merchantsModel.images[i], count / 100);
            //                NSLog(@"变化图片大小%ld,%f",imageData.length,count / 100);
            //            }
            
            //进行图像的画面质量压缩
            NSData *imageData=UIImageJPEGRepresentation(self.merchantsModel.images[i], 1.0);
            NSLog(@"%ld",imageData.length);
            if (imageData.length>100*1024) {
                if (imageData.length>1024*1024) {//1M以及以上
                    
                    imageData=UIImageJPEGRepresentation(self.merchantsModel.images[i], 0.1);
                }else if (imageData.length>512*1024) {//0.5M-1M
                    
                    imageData=UIImageJPEGRepresentation(self.merchantsModel.images[i], 0.2);
                }else if (imageData.length>200*1024) {
                    
                    //0.25M-0.5M
                    imageData=UIImageJPEGRepresentation(self.merchantsModel.images[i], 0.6);
                }
            }
            
            //            NSData *imageData = [GMNTools zipNSDataWithImage:self.merchantsModel.images[i]];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@%ld.jpg", dateString,i];
            NSLog(@"图片名字：%@",fileName);
            
//            该方法的参数
//             1. appendPartWithFileData：要上传的照片[二进制流]
//             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//             3. fileName：要保存在服务器上的文件名
//             4. mimeType：上传的文件的类型
            NSArray *name = @[@"card_img_front",@"card_img_back"];
            
            [formData appendPartWithFileData:imageData name:name[i] fileName:fileName mimeType:@"image/jpeg"];
            NSLog(@"上传照片image%ld",i);
            
            [formData appendPartWithFormData:[weakself.merchantsModel.renlian?@"2":@"1" dataUsingEncoding:NSUTF8StringEncoding]  name:@"status"];
            
            [formData appendPartWithFormData:[weakself.merchantsModel.contact dataUsingEncoding:NSUTF8StringEncoding] name:@"real_name"];
            
            [formData appendPartWithFormData:[[weakself.merchantsModel.sex isEqualToString:@"男"]?@"1":@"2" dataUsingEncoding:NSUTF8StringEncoding] name:@"true_sex"];
            
            [formData appendPartWithFormData:[weakself.merchantsModel.Idcard dataUsingEncoding:NSUTF8StringEncoding] name:@"card_number"];
            
            [formData appendPartWithFormData:[weakself.merchantsModel.bank dataUsingEncoding:NSUTF8StringEncoding] name:@"bank_account"];
            
            [formData appendPartWithFormData:[weakself.merchantsModel.phone dataUsingEncoding:NSUTF8StringEncoding] name:@"mobile"];
            [formData appendPartWithFormData:[weakself.TXLtext dataUsingEncoding:NSUTF8StringEncoding] name:@"user_mail"];
            [formData appendPartWithFormData:[weakself.merchantsModel.codenum dataUsingEncoding:NSUTF8StringEncoding] name:@"code"];
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@ %@",[YJLTools_sub deviceVersion],[[UIDevice currentDevice]systemVersion]] dataUsingEncoding:NSUTF8StringEncoding] name:@"mobile_model"];
            
        }
        
    }progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSLog(@"请求成功=%@",responseObject);
              NSDictionary* responesData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              responesData  = [NSDictionary changeType:responesData];
              NSLog(@"%@",responesData);
              [KEYWINDOW makeToast:responesData[@"msg"] duration:1 position:CSToastPositionCenter];
              [GMBProgressShower hideHUDForView:self.view animated:NO];
              if ([responesData[@"code"] intValue]==200) {
                  
//                  [HDUserinfoBaseModel shareUserInfoModelManager].userModel.is_activation = @"1";
//                  USERMODELCOMMIT;
                  [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
              }else{
                  
              }
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"请求失败=%@",error);
              [GMBProgressShower hideHUDForView:self.view animated:NO];
              [GMBProgressShower showTextInError:self.view Text:@"网络请求请求出错,请检查网络!" During:1 ];
              
          }];
}

 */


-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)textFieldChanged_1:(UITextField *)textfield{
    self.merchantsModel.contact = textfield.text;
    
}

-(void)textFieldChanged_2:(UITextField *)textfield{
    
    self.merchantsModel.Idcard = textfield.text;
}

-(void)textFieldChanged_3:(UITextField *)textfield{
    self.merchantsModel.bank = textfield.text;
    
}

-(void)textFieldChanged_4:(UITextField *)textfield{
    self.merchantsModel.codenum = textfield.text;
    
}



#pragma mark  选择街道
-(void)choosestreet{
    
    if (self.merchantsModel.city.length<0) {
        [KEYWINDOW makeToast:@"请先选择好城市所在地" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    [[YJLTools Sharemanager]CCLoadingViewShow];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray * textArray      = [NSMutableArray array];
        NSMutableArray * AlltextArray   = [NSMutableArray array];
        for (int i=0; i<self.JsonArray.count; i++) {
            GAreaModel *model = self.JsonArray[i];
            NSLog(@"pid==%@  %@",model.pid,self.merchantsModel.areaid);
            if ([model.pid integerValue] == [self.merchantsModel.areaid integerValue]) {
                [textArray addObject:model.name];
                [AlltextArray addObject:model];
                
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            [[YJLTools Sharemanager]CCLoadingViewDismiss];
            [CGXPickerView showStringPickerWithTitle:@"选择街道" DataSource:textArray DefaultSelValue:@"" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@-%@",selectValue,selectRow);
                GCityModel *citymodel = AlltextArray[[selectRow integerValue]];
                
                self.merchantsModel.streetid   = citymodel.c_id;
                self.merchantsModel.street     = citymodel.name;
                NSLog(@"id==%@ name== %@",self.merchantsModel.streetid,self.merchantsModel.street);
                
                [self getJWD];
                [UIView performWithoutAnimation:^{
                    
                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:4 inSection:0];
                    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                }];
            }];
            
            
        });
    });
    
}


#pragma mark 选择城市
-(void)choosecity{
    
    self.pickerView.pickerMode  = APPickerModeArea;
    [self.pickerView show];
    
}

#pragma mark AddressPickerViewDelegate
-(void)cancelBtnClick{
    
}

-(void)sureBtnClickReturnProvince:(GAreaModel *)province City:(GCityModel *)city Area:(GCountyModel *)area{
    NSLog(@"%@-%@-%@",province.name,city.name,area.name);
    NSLog(@"%@-%@-%@",province.c_id,city.c_id,area.c_id);
    
    NSString  *oldaddress = self.merchantsModel.address;
    
    self.merchantsModel.provinceid  = province.c_id;
    self.merchantsModel.cityid      = city.c_id;
    self.merchantsModel.areaid      = area.c_id;
    self.merchantsModel.address     = [NSString stringWithFormat:@"%@%@%@",province.name,city.name,area.name];
    
    if (![oldaddress isEqualToString:self.merchantsModel.address]) {
        self.merchantsModel.street = @"";
        [UIView performWithoutAnimation:^{
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:3];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    
    //        self.merchantsModel.address=x;
    [self getJWD];
    [UIView performWithoutAnimation:^{
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }];
}


//转换经纬度
-(void)getJWD{
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = [NSString stringWithFormat:@"%@%@",self.merchantsModel.address,self.merchantsModel.addressnum];
    [self.search AMapGeocodeSearch:geo];
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        return;
    }
    
    AMapGeocode *geo = response.geocodes[0];
    NSLog(@"%f--%f",geo.location.latitude,geo.location.longitude);
    self.merchantsModel.latitude =[NSString stringWithFormat:@"%f",geo.location.latitude];
    self.merchantsModel.longitude =[NSString stringWithFormat:@"%f",geo.location.longitude];
    //解析response获取地理信息，具体解析见 Demo
}


@end
