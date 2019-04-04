//
//  GMNmerchantsModel.h
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/19.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMNmerchantsModel : JSONModel
@property(nonatomic,strong)NSString       * entity_shop;//有无实体店
@property(nonatomic,strong)NSString       *   name;//商户名称

@property(nonatomic,strong)NSString       *   contact;//法人
@property(nonatomic,strong)NSString       *   Idcard;//身份证
@property(nonatomic,assign)BOOL               renlian;//人脸识别
@property(nonatomic,strong)NSString       *   phone;//+86手机号码
@property(nonatomic,strong)NSString       *   bank;//银行卡号
@property(nonatomic,strong)NSString       *   sex;//性别
@property(nonatomic,strong)NSString       *   QQ;//QQ


@property(nonatomic,strong)NSString       *   license;//执照号
@property(nonatomic,strong)NSMutableArray *   images;//图片
@property(nonatomic,strong)NSString       *   codenum;//验证码

@property(nonatomic,strong)NSString       *   address;//省市区地址

@property(nonatomic,strong)NSString       *   province;//省
@property(nonatomic,strong)NSString       *   city;//市
@property(nonatomic,strong)NSString       *   area;//区
@property(nonatomic,strong)NSString       *   street;//街道


@property(nonatomic,strong)NSString       *   provinceid;//省id
@property(nonatomic,strong)NSString       *   cityid;//城市id
@property(nonatomic,strong)NSString       *   areaid;//区id
@property(nonatomic,strong)NSString       *   streetid;//街道id

@property(nonatomic,strong)NSString       *   addressnum;//门牌号

@property(nonatomic,strong)NSString       *   latitude;//纬度
@property(nonatomic,strong)NSString       *   longitude;//经度




@end

NS_ASSUME_NONNULL_END
