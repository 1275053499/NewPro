//
//  HttpsRequest.m
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/14.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import "HttpsRequest.h"
#import "NSDictionary+SetNullWithStr.h"
@implementation HttpsRequest


+(void)SeliceGET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSLog(@"%@",URLString);
    NSString *urlStr                = [NSString stringWithFormat:@"%@%@",HttpBaseUrl,URLString];
    NSLog(@"%@",urlStr);

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
//
//    if ([HDLoginModel shareLoginModelManager].hasToken) {
//        NSDictionary *headerFieldValueDictionary;
//        headerFieldValueDictionary = @{@"token":[HDLoginModel shareLoginModelManager].isToken,@"Role":@"IOS"};
//        if (headerFieldValueDictionary != nil) {
//            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
//                NSString *value = headerFieldValueDictionary[httpHeaderField];
//                [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//            }
//        }
//    }

//    NSLog(@"token = %@\n%@",[[SeliceLoginModel shareLoginModelManager] isToken],parameters);
    [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"返回数据jsonStr:%@",jsonStr);
        
        NSDictionary* responesData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        responesData  = [NSDictionary changeType:responesData];
        success(responesData);
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            [GMBHud  showTextInError:KEYWINDOW Text:@"网络请求出错,请检查网络!" During:1.0];
        }else{
            [GMBHud  showTextInError:KEYWINDOW Text:@"网络有点卡顿,请检查网络环境!" During:1.0];
        }
        failure(error);
        [GMBHud hideHUDForView:KEYWINDOW animated:YES];
    }];
}

+(void)SelicePOST:(NSString *)URLString
    parameters:(id)parameters
       success:(void (^)( id responseObject))success
       failure:(void (^)( NSError *error))failure{
    
    NSString *urlStr                = [NSString stringWithFormat:@"%@%@",HttpBaseUrl,URLString];
    NSLog(@"%@",urlStr);
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
    
//    if ([HDLoginModel shareLoginModelManager].hasToken) {
//        NSDictionary *headerFieldValueDictionary;
//
//        headerFieldValueDictionary = @{@"token":[HDLoginModel shareLoginModelManager].isToken,@"Role":@"IOS"};
//        if (headerFieldValueDictionary != nil) {
//            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
//                NSString *value = headerFieldValueDictionary[httpHeaderField];
//                [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//            }
//        }
//    }
    
//    NSLog(@"token = %@\n%@",[[SeliceLoginModel shareLoginModelManager] isToken],parameters);
    [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"返回数据jsonStr:%@",jsonStr);
        NSDictionary* responesData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        responesData  = [NSDictionary changeType:responesData];
        success(responesData);
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error.code == -1009) {
            [GMBHud  showTextInError:KEYWINDOW Text:@"网络请求出错,请检查网络!" During:1.0];
        }else{
            [GMBHud  showTextInError:KEYWINDOW Text:@"网络有点卡顿,请检查网络环境!" During:1.0];
        }
        failure(error);
        [GMBHud hideHUDForView:KEYWINDOW animated:YES];
    }];
}

//上传头像(使用中)
+(void)SeliceRequestimgs:(NSString *)URLString
           parameters:(id)parameters
               images:(NSArray *)imagesArr
            imagefile:(NSString *)imagefilename
              success:(void (^)( id responseObject))success
              failure:(void (^)( NSError *error))failure{
    
    NSString *urlStr                = [NSString stringWithFormat:@"%@%@",HttpBaseUrl,URLString];
    NSLog(@"%@",urlStr);
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
    
//    if ([HDLoginModel shareLoginModelManager].hasToken) {
//        NSDictionary *headerFieldValueDictionary;
//        headerFieldValueDictionary = @{@"token":[HDLoginModel shareLoginModelManager].isToken,@"Role":@"IOS"};
//        if (headerFieldValueDictionary != nil) {
//            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
//                NSString *value = headerFieldValueDictionary[httpHeaderField];
//                [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//            }
//        }
//    }
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imagesArr.count; i++) {
            
            NSData *imageData = UIImageJPEGRepresentation(imagesArr[i], 0.5);
            CGFloat count = 100;
            NSLog(@"图片大小%ld",imageData.length);
            while (imageData.length > 1024000) {
                count = count-10;
                imageData =  UIImageJPEGRepresentation(imagesArr[i], count / 100);
                NSLog(@"变化图片大小%ld,%f",imageData.length,count / 100);
            }
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat    = @"yyyyMMddHHmmss";
            NSString *str           = [formatter stringFromDate:[NSDate date]];
            NSString *fileName      = [NSString stringWithFormat:@"%@.jpg", str];
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData
                                        name:imagefilename
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* responesData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        responesData  = [NSDictionary changeType:responesData];
        success(responesData);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            [GMBHud  showTextInError:KEYWINDOW Text:@"网络请求出错,请检查网络!" During:1.0];
        }else{
            [GMBHud  showTextInError:KEYWINDOW Text:@"网络有点卡顿,请检查网络环境!" During:1.0];
        }
        failure(error);
        [GMBHud hideHUDForView:KEYWINDOW animated:YES];
    }];
}


//图片+文字上传
+(void)SeliceRequestIMG:(NSString *)URLString parameters:(id)parameters images:(NSArray *)imagesArr imageNames:(NSArray *)imagesName success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSString *urlStr                = [NSString stringWithFormat:@"%@%@",HttpBaseUrl,URLString];
    NSLog(@"%@",urlStr);
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
    
//    if ([HDLoginModel shareLoginModelManager].hasToken) {
//        NSDictionary *headerFieldValueDictionary;
//        headerFieldValueDictionary = @{@"token":[HDLoginModel shareLoginModelManager].isToken,@"Role":@"IOS"};
//        if (headerFieldValueDictionary != nil) {
//            for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
//                NSString *value = headerFieldValueDictionary[httpHeaderField];
//                [manager.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
//            }
//        }
//    }
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    
        for (int i=0; i<imagesArr.count; i++) {
            
            NSData *imageData = UIImageJPEGRepresentation(imagesArr[i], 0.5);
            CGFloat count = 100;
            NSLog(@"图片大小%ld",imageData.length);
            
            
            while (imageData.length > 102400) {
               count = count-10;
                imageData =  UIImageJPEGRepresentation(imagesArr[i], count / 100);
                NSLog(@"变化图片大小%ld,%f",imageData.length,count / 100);
            }
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData
                                        name:imagesName[i]
                                    fileName:fileName
                                    mimeType:@"image/jpeg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* responesData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        responesData  = [NSDictionary changeType:responesData];
        success(responesData);
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code == -1009) {
            [GMBHud  showTextInError:KEYWINDOW Text:@"网络请求出错,请检查网络!" During:1.0];
        }else{
            [GMBHud  showTextInError:KEYWINDOW Text:@"网络有点卡顿,请检查网络环境!" During:1.0];
        }
        failure(error);
        [GMBHud hideHUDForView:KEYWINDOW animated:YES];
    }];
}

//网络有点卡顿,请检查网络环境!


//图片处理，图片压缩 使用
//    NSData *imgData = UIImagePNGRepresentation(image);//亚索体积
//    if (imgData.length > 1024000) {//图片不大于1M
//        CGSize imgSize = CGSizeMake(image.size.width / 4, image.size.height / 4);
//        image = [self OriginImage:image scaleToSize:imgSize];//亚索图片尺寸
//    }

////图片处理，图片压缩
//- (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
//    UIGraphicsBeginImageContext(size);  //你所需要的图片尺寸
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return scaledImage;   //返回已变图片
//}
@end
