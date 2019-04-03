//
//  MikoNetStatuesDetection.m
//  FanZuKe
//
//  Created by yanjinlin on 2018/8/16.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import "MikoNetStatuesDetection.h"
#import <CommonCrypto/CommonHMAC.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <arpa/inet.h>
@implementation MikoNetStatuesDetection

+(MikoNetStatuesDetection *)MikoNetShareManager{
    static MikoNetStatuesDetection *_MikoManager = nil;
     static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         _MikoManager = [[MikoNetStatuesDetection alloc]init];
    });
    return _MikoManager;
}

-(BOOL)MikohasNet{
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

-(void)MikoDetectionNetStatuesChange{
    
    [[AFNetworkReachabilityManager  sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //        AFNetworkReachabilityStatusUnknown          = -1,
        //        AFNetworkReachabilityStatusNotReachable     = 0,
        //        AFNetworkReachabilityStatusReachableViaWWAN = 1,
        //        AFNetworkReachabilityStatusReachableViaWiFi = 2,
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                UIAlertController *alertVc = [UIAlertController  alertControllerWithTitle:@"亲，您的网络好像掉了" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction  actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertVc  addAction:cancelAction];
                [[UIApplication  sharedApplication].keyWindow.rootViewController  presentViewController:alertVc animated:YES completion:nil];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
//                [GMBHud showTextInSucce:KEYWINDOW Text:@"4G网络连接" During:1];
            }break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
//                [GMBHud showTextInSucce:KEYWINDOW Text:@"WIFI网络连接" During:1];
            }break;
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager  sharedManager] startMonitoring];
}

@end
