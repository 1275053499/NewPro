//
//  YJLTools_sub.m
//  KOO
//
//  Created by yanjinlin on 2019/3/25.
//  Copyright © 2019 yanjinlin. All rights reserved.
//

#import "YJLTools_sub.h"
#import <Accelerate/Accelerate.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

//#import "NetErrorView.h"
#import "sys/utsname.h"

@interface YJLTools_sub()

//@property(nonatomic,strong)CCHudShowView *showVc;

@end

@implementation YJLTools_sub

#pragma mark - 获取当前控制器
+ (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        RTRootNavigationController * nav = (RTRootNavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}

//设置毛玻璃效果
+(void)blurEffect:(UIView *)view{
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectVIew = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectVIew.frame = view.bounds;
    [view addSubview:effectVIew];
}

+(void)turnToVC:(UIViewController *)viewController Observer:(UIViewController *)observer TurnType:(TurnType)turnType Animated:(BOOL)animated HidesBottomBarWhenPushed:(BOOL)hideBottomBar{
    [viewController setHidesBottomBarWhenPushed:hideBottomBar];
    switch (turnType) {
        case TurnTypeOfPush:
            if (observer) {
                [observer.navigationController pushViewController:viewController animated:animated];
            }else{
                [[YJLTools_sub getCurrentVC].navigationController pushViewController:viewController animated:animated];
            }
            break;
        case TurnTypeOfPresent:
            if (observer) {
                [observer presentViewController:viewController animated:animated completion:nil];
            }else{
                [[YJLTools_sub getCurrentVC] presentViewController:viewController animated:animated completion:nil];
            }
            break;
        default:
            break;
    }
}


+ (NSString *)getCalculateCache{
    //计算检查缓存大小
    float tmpSize    = [[SDImageCache sharedImageCache] getSize]/1000/1000;
    return  [NSString stringWithFormat:@"%.2f MB",tmpSize];
}

+ (void)clearTmpPics{
    //清除SD图片缓存
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
        [[SDImageCache sharedImageCache] clearMemory];
    });
}


+(NSString *)gettimeWithData:(NSString *)longstr{
    
    
    NSString * timeStampString = longstr;
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    
    NSLog(@"%@", [objDateformat stringFromDate: date]);
    
    return [objDateformat stringFromDate: date];
}

+(NSString *)getsixtimeWithData:(NSString *)longstr{
    
    
    NSString * timeStampString = longstr;
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSLog(@"%@", [objDateformat stringFromDate: date]);
    
    return [objDateformat stringFromDate: date];
}


+ (NSString *)getTimestampWithDate:(NSDate *)timeDate{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:timeDate];
    
    NSDate *localeDate = [timeDate  dateByAddingTimeInterval: interval];
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    
    return timeSp;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    //    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //    UIGraphicsBeginImageContext(rect.size);
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextSetFillColorWithColor(context, [color CGColor]);
    //    CGContextFillRect(context, rect);
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return image;
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
        outBuffer.data = pixelBuffer;
        outBuffer.width = CGImageGetWidth(img);
        outBuffer.height = CGImageGetHeight(img);
        outBuffer.rowBytes = CGImageGetBytesPerRow(img);
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        if (error) {
            NSLog(@"error from convolution %ld", error);
        }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}
+ (void)setGradientLayer:(UIView *)view StarColor:(UIColor *)starColor EndColor:(UIColor *)endColor{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)starColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.locations = @[@0.1, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = view.frame;
    [view.layer addSublayer:gradientLayer];
}

+ (NSString *)removeSpace:(NSString *)string{
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}


#pragma mark 号码加****
+(NSString*)changeTelephone:(NSString*)teleStr{
    
    NSLog(@"原来号码:%@",teleStr);
    NSString *string;
    if (teleStr.length>8) {
        string =[teleStr stringByReplacingOccurrencesOfString:[teleStr substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    }
    
    return string;
}


#pragma mark 姓名加****
+(NSString *)nameaddxx:(NSString *)name{
    
    NSString *Sname = name;
    
    //    NSLog(@"%@",Sname);
    
    if (Sname.length>=3) {
        
        NSString *name1 = [Sname substringToIndex:1];
        NSString *name2 = [Sname substringWithRange:NSMakeRange(Sname.length-1, 1)];
        Sname = [NSString stringWithFormat:@"%@*%@",name1,name2];
        
        //            NSLog(@"11--%@",Sname);
    }else{
        
        if (Sname.length==2) {
            //           NSLog(@"22--%@",Sname);
            Sname =[Sname stringByReplacingOccurrencesOfString:[Sname substringWithRange:NSMakeRange(1,1)]withString:@"*"];
        }else{
            
        }
    }
    return Sname;
}


#pragma mark 判断号码是否为国家可用的
+(BOOL)ismobileNum:(NSString *)mobileNum{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[5,6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[05678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//验证身份证号码
+(BOOL)checkIdentityCardNo:(NSString*)IDNumber
{
    if (IDNumber.length<18) {
        return NO;
    }
    NSMutableArray *IDArray = [NSMutableArray array];
    // 遍历身份证字符串,存入数组中
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    // 每一位身份证号码和对应系数相乘之后相加所得的和
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    // 这个和除以11的余数对应的数
    NSString * str = remainderArray[(sum % 11)];//0 1 2 3 4 5 6 7 8 9 10
    // 身份证号码最后一位
    NSString *string = [IDNumber substringFromIndex:17];//1 0 X 9 8 7 6 5 4 3 2
    // 如果这个数字和身份证最后一位相同,则符合国家标准,返回YES
    NSLog(@"%@--%@",string,str);
    if ([str isEqualToString:string]) {
        
        NSString *birthdayYer = [IDNumber substringWithRange:NSMakeRange(6, 4)];
        NSString *birthdayMan = [IDNumber substringWithRange:NSMakeRange(10, 2)];
        NSString *birthdayDay = [IDNumber substringWithRange:NSMakeRange(12, 2)];
        if ([birthdayYer intValue]<1900||[birthdayMan intValue]==0||[birthdayMan intValue]>12||[birthdayDay intValue]==1||[birthdayDay intValue]>31) {
            return NO;
        }
        
        
        return YES;
        
    } else {
        return NO;
    }
}


+ (BOOL)isPureNumandCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

+ (BOOL)openLocationServiceWithBlock:(BOOL)autopupview{
    BOOL isOPen = NO;
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized)) {
        isOPen = YES;
        //定位功能可用
        
    }else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        //定位不能用
        isOPen = NO;
        if (autopupview) {
            UIAlertController *alertVc = [UIAlertController  alertControllerWithTitle:@"请求打开定位权限" message:@"折淘网app需要使用您的位置来为您提供服务" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *setAction = [UIAlertAction  actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if (IOS10) {
                    [[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
                        
                    }];
                }else{
                    if([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
            }];
            UIAlertAction *cancelAction = [UIAlertAction  actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertVc  addAction:setAction];
            [alertVc  addAction:cancelAction];
            [[UIApplication  sharedApplication].keyWindow.rootViewController  presentViewController:alertVc animated:YES completion:nil];
        }
        
    }
    
    return isOPen;
}

+ (BOOL)openMessageNotificationService{
    BOOL isOpen = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isOpen = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    } else { // iOS版本 <8.0 处理逻辑
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isOpen = (UIRemoteNotificationTypeNone == type) ? NO : YES;
    }
    
    if (!isOpen) {
        
        UIAlertController *alertVc = [UIAlertController  alertControllerWithTitle:@"请求打开通知权限" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *setAction = [UIAlertAction  actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIApplication *application = [UIApplication sharedApplication];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([application canOpenURL:url]) {
                if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:url options:@{} completionHandler:nil];
                } else {
                    [application openURL:url];
                }
            }
        }];
        UIAlertAction *cancelAction = [UIAlertAction  actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertVc  addAction:setAction];
        [alertVc  addAction:cancelAction];
        [[UIApplication  sharedApplication].keyWindow.rootViewController  presentViewController:alertVc animated:YES completion:nil];
    }
    return isOpen;
}


//+(void)showNetLinkerErrorViewFromCurrentView:(UIView *)currentView reloadClick:(void(^)(NSInteger index))clickBlock
//{
//    
//    
//    NetErrorView *noneView = [[[NSBundle mainBundle] loadNibNamed:@"NetErrorView" owner:nil options:nil] lastObject];
//    [currentView addSubview:noneView];
//    noneView.block = ^(NSInteger Tag) {
//        clickBlock(Tag);
//    };
//}


+(NSString *)numChangetoStr:(NSInteger )Number{
    
    NSString *str = [NSString stringWithFormat:@"%ld",Number];
    return str;
}

+(NSInteger)StrChangetoNum:(NSString* )Str{
    
    NSInteger  Num = Str.integerValue;
    return Num;
}

+(NSString *)timeChangeStr:(NSString *)servertime{
    //    2011-01-26 17:40:50
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone        = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate * date               = [formatter dateFromString:servertime]; //------------将字符串按formatter转成nsdate
    //    NSString *timestamp         = [NSString stringWithFormat:@"%lld", (long long)[date timeIntervalSince1970]];
    //    NSLog(@"服务器给的时间戳:%@",timestamp); //时间戳的值
    
    NSDate *datenow             = [NSDate date];//现在时间,你可以输出来看下是什么格式
    //    NSString *timeSp            = [NSString stringWithFormat:@"%lld", (long long)[datenow timeIntervalSince1970]];
    //    NSLog(@"现在的时间戳:%@",timeSp); //时间戳的值
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    //    NSLog(@"现在时间:%@",currentTimeString);
    //    NSLog(@"服务器时间:%@",servertime);
    NSDate *dat                 = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowTimestamp = [dat timeIntervalSince1970] ;
    NSTimeInterval serverstamp  = [date timeIntervalSince1970] ;
    
    long long int timeDifference = nowTimestamp - serverstamp;
    long long int secondTime = timeDifference;//100s
    long long int minuteTime = secondTime/60;//1m 40s
    long long int hoursTime  = minuteTime/60;
    long long int dayTime    = hoursTime/24;
    long long int monthTime  = dayTime/30;
    
    if(1 <= monthTime) {
        
        NSString * currentTimeString_time  = [currentTimeString substringWithRange:NSMakeRange(0, 4)];
        NSString * servertime_time         = [servertime substringWithRange:NSMakeRange(0, 4)];
        if ([currentTimeString_time integerValue]>[servertime_time integerValue]) {
            return [NSString stringWithFormat:@"%@",[servertime substringWithRange:NSMakeRange(0, 15)]];
        }else{
            return [NSString stringWithFormat:@"%@",[servertime substringWithRange:NSMakeRange(5, 11)]];
        }
    }
    else if(1 < dayTime) {
        return [NSString stringWithFormat:@"%lld天前发布",dayTime];
    }else if(1 == dayTime) {
        
        return @"昨天发布";
    }
    else if(1 <= hoursTime) {
        return [NSString stringWithFormat:@"%lld小时前发布",hoursTime];
    }
    else if(1 <= minuteTime) {
        return [NSString stringWithFormat:@"%lld分钟前发布",minuteTime];
    }
    else if(1 <= secondTime) {
        return [NSString stringWithFormat:@"1分钟前发布"];
    }
    else {
        return @"刚刚";
    }
}


+(float)LogstrTwo:(NSString *)log2 LatstrTwo:(NSString *)lat2 LogstrOne:(NSString *)log1 LatstrOne:(NSString *)lat1{
    
    //第一个坐标
    CLLocation *current=[[CLLocation alloc] initWithLatitude:lat2.floatValue longitude:log2.floatValue];
    //第二个坐标
    CLLocation *before=[[CLLocation alloc] initWithLatitude:lat1.floatValue longitude:log1.floatValue];
    //计算两个点之间的直线距离 单位是米
    CLLocationDistance meters =[current distanceFromLocation:before];
    NSLog(@"%f",meters);
    return meters/1000;
}


+(NSString *)Emojicoding:(NSString *)Text{
    //    Text =   [Text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    Text =   [Text stringByRemovingPercentEncoding:NSUTF8StringEncoding];
    //    NSLog(@"---表情编码--->[%@]",Text);
    
    Text = [Text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return Text;
}


+(NSString *)Emojidecoding:(NSString *)Text{
    //   Text = [Text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //     NSLog(@"---表情解码--->[%@]",Text);
    Text = [Text stringByRemovingPercentEncoding];
    return Text;
}


+(NSString *)clearSpacestr:(NSString *)text{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return text;
}

+(NSString *)filter:(NSString *)text{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：()；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    text = [text stringByTrimmingCharactersInSet:set];
    return text;
}


+(NSString *)HasFrontStrOrBackStr:(NSString *)text{
    if ([text hasPrefix:@"http"]) {
        return @"这个是网址";
    }else if ([text hasSuffix:@"png"]) {
        return @"这个是图片";
    }else{
        return @"未知";
    }
}

+(BOOL)HasSpecified:(NSString *)text{
    if ([text containsString:@"1111"]) {
        return YES;
    }else{
        return NO;
    }
    
}


+(CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    NSString * spec_value = [NSString stringWithFormat:@"  %@  ",text];
    CGRect rect = [spec_value boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                           context:nil];
    return rect.size.width;
}


+ (void)CCSaveDataFromModel:(id)dataModel   WithKey:(NSString *)key
{
    NSUserDefaults *saveDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataModel];
    [saveDefault setValue:data forKey:key];
    [saveDefault synchronize];
}
+ (id)CCGetDataFromModelWithKey:(NSString *)key
{
    NSData *keyData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id data = [NSKeyedUnarchiver unarchiveObjectWithData:keyData];
    return data;
}


+(NSMutableAttributedString*)YYchangeLabelColorWithText:(NSString*)needText totalStr:(NSString *)total color:(UIColor *)color
{
    if (!needText || !total) {
        return nil;
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:total];
    NSRange rangeSite = [total  rangeOfString:needText];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:rangeSite];
    
    return attrString;
}


/**
 *  设备版本
 * 模拟器不行 ！！！！x86_64
 *  @return e.g. iPhone 5S
 */



+ (NSString*)deviceVersion
{
    // 需要
    struct utsname systemInfo;
    uname(&systemInfo);
    //型号标识符
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    NSLog(@"宽：%f-高：%f",width,height);
    //    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    //    if (width>1280||height>1280) {
    //        if (width>height) {
    //            CGFloat scale = height/width;
    //            width = 1280;
    //            height = width*scale;
    //        }else{
    //            CGFloat scale = width/height;
    //            height = 1280;
    //            width = height*scale;
    //        }
    //        //2.宽大于1280高小于1280
    //    }else if(width>1280||height<1280){
    //        CGFloat scale = height/width;
    //        width = 1280;
    //        height = width*scale;
    //        //3.宽小于1280高大于1280
    //    }else if(width<1280||height>1280){
    //        CGFloat scale = width/height;
    //        height = 1280;
    //        width = height*scale;
    //        //4.宽高都小于1280
    //    }else{
    //
    //    }
    
    //    UIGraphicsBeginImageContext(CGSizeMake(375/2, height));
    //    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    NSLog(@"%ld",data.length);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            
            data=UIImageJPEGRepresentation(newImage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            
            data=UIImageJPEGRepresentation(newImage, 0.2);
        }else if (data.length>200*1024) {
            
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.6);
        }
    }
    return data;
}

@end

