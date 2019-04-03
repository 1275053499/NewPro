//
//  NSDictionary+SetNullWithStr.h
//  HDLiveParty
//
//  Created by selice on 2018/6/11.
//  Copyright © 2018年 goudiwangCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SetNullWithStr)

/*
 *把服务器返回的 替换为“”
 *json表示获取到的带有NULL对象的json数据
 *NSDictionary *newDict = [NSDictionary changeType:json];
 */
+(id)changeType:(id)myObj;
@end
