//
//  GAreaModel.m
//  GOUDIWANG
//
//  Created by 曾国锐 on 2017/11/7.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "GAreaModel.h"

@implementation GCountyModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"c_id":@"id"}];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation GCityModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"c_id":@"id"}];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation GAreaModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"c_id":@"id"}];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
