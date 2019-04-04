//
//  GAreaModel.h
//  GOUDIWANG
//
//  Created by 曾国锐 on 2017/11/7.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol GCityModel;
@protocol GCountyModel;

@interface GCountyModel : JSONModel
@property (nonatomic, strong)NSString *c_id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *pid;
@end


@interface GCityModel : JSONModel
@property (nonatomic, strong)NSString *c_id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *pid;
@property (nonatomic, strong)NSMutableArray <GCityModel> *children;

@end

@interface GAreaModel : JSONModel
@property (nonatomic, strong)NSString *c_id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *pid;
@property (nonatomic, strong)NSMutableArray <GCityModel> *children;

@end
