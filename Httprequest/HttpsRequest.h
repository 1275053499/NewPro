//
//  HttpsRequest.h
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/14.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpsRequest : NSObject

#pragma mark 获取资源
+(void)SeliceGET:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)( id responseObject))success
      failure:(void (^)( NSError *error))failure;

#pragma mark 添加资源
+(void)SelicePOST:(NSString *)URLString
    parameters:(id)parameters
       success:(void (^)( id responseObject))success
       failure:(void (^)( NSError *error))failure;



#pragma mark 上传图片(数组图片+后台单个数组字段接收)
+(void)SeliceRequestimgs:(NSString *)URLString
           parameters:(id)parameters
               images:(NSArray *)imagesArr
            imagefile:(NSString *)imagefilename
              success:(void (^)( id responseObject))success
              failure:(void (^)( NSError *error))failure;


#pragma mark //图片+文字上传(数组图片+后台多个数组字段接收)
+(void)SeliceRequestIMG:(NSString *)URLString parameters:(id)parameters images:(NSArray *)imagesArr imageNames:(NSArray *)imagesName success:(void (^)(id))success failure:(void (^)(NSError *))failure;



@end

