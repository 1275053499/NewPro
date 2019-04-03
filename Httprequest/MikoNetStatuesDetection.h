//
//  MikoNetStatuesDetection.h
//  FanZuKe
//
//  Created by yanjinlin on 2018/8/16.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MikoNetStatuesDetection : NSObject
+(MikoNetStatuesDetection *)MikoNetShareManager;
-(BOOL)MikohasNet;
-(void)MikoDetectionNetStatuesChange;
@end
