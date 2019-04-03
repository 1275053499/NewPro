//
//  YJLTools.m
//  GM_UNPRECEDENT
//
//  Created by yanjinlin on 2018/11/27.
//  Copyright © 2018 yanjinlin. All rights reserved.
//

#import "YJLTools.h"
//#import "CCHudShowView.h"

@interface YJLTools()

//@property(nonatomic,strong)CCHudShowView *showVC;

@end

@implementation YJLTools


+(YJLTools*)Sharemanager
{
    static YJLTools *_gPublicTools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_gPublicTools == nil) {
            _gPublicTools = [super alloc];
        }
    });
    
    return _gPublicTools;
}


//-(void)CCLoadingViewShow
//{
//
//    _showVC = [[[NSBundle mainBundle] loadNibNamed:@"CCHudShowView" owner:nil options:nil] lastObject];
//    _showVC.backgroundColor = [UIColor clearColor];
//    [_showVC show];
//
//}

//-(void)CCLoadingViewDismiss
//{
//
//    [_showVC hide];
//
//}


-(BOOL)IsChinese:(NSString *)str {
    
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    } return NO;
}

-(void)GotoLogin:(BOOL)needbackoriginal{
    
    NewProLoginVC*vc = [[NewProLoginVC alloc] init];
    RTRootNavigationController *navLogin = [[RTRootNavigationController alloc]initWithRootViewController:vc];
    [[YJLTools_sub getCurrentVC] presentViewController:navLogin animated: YES completion:nil];
}

//-(void)GotoLogin{
//
//    LoginVC *vc = [[LoginVC alloc] init];
//    RTRootNavigationController *navLogin = [[RTRootNavigationController alloc]initWithRootViewController:vc];
//    [[GMNTools getCurrentVC] presentViewController:navLogin animated: YES completion:nil];
//
//}


#pragma mark  获取假UUID
- (NSString *)cc_GetDeviceIdfa
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleID = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *idfaStr  = [NSString stringWithFormat:@"%@.heidingPartylivesex",bundleID];
    NSString*strUUID = (NSString*)[self cc_Load:idfaStr];
    
    //首次执行该方法时，uuid为空
    if(![self YYVerifyStrIsEmpty:strUUID])
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
        //将该uuid保存到keychain
        NSMutableString *str = [[NSMutableString alloc] initWithString:strUUID];
        
        for (int i = 0; i < str.length; i ++) {
            
            NSString *character = [str substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:@"-"])
                [str deleteCharactersInRange:NSMakeRange(i, 1)];
        }
        
        [self cc_Save:idfaStr data:str];
    }
    return strUUID;
}

#pragma mark - =================== keychain 相关 =============================
- (NSMutableDictionary*)cc_GetKeychainQuery:(NSString*)service {
    return[NSMutableDictionary dictionaryWithObjectsAndKeys:
           (id)kSecClassGenericPassword,(id)kSecClass,
           service,(id)kSecAttrService,
           service,(id)kSecAttrAccount,
           (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
           nil];
}

- (id)cc_Load:(NSString*)service {
    id ret =nil;
    NSMutableDictionary*keychainQuery = [self cc_GetKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we areexpecting only a single attribute to be returned (the password) wecan set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData =NULL;
    if(SecItemCopyMatching((CFDictionaryRef)keychainQuery,(CFTypeRef*)&keyData) ==noErr){
        @try{
            ret =[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)keyData];
        }@catch(NSException *e) {
            NSLog(@"Unarchiveof %@ failed: %@",service, e);
        }@finally{
        }
    }
    if(keyData)
        CFRelease(keyData);
    return ret;
}

- (void)cc_Save:(NSString*)service data:(id)data{
    //Get search dictionary
    NSMutableDictionary*keychainQuery = [self cc_GetKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to searchdictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]forKey:(id)kSecValueData];
    //Add item to keychain with the searchdictionary
    SecItemAdd((CFDictionaryRef)keychainQuery,NULL);
}


- (NSString *)YYVerifyStrIsEmpty:(NSString *) str
{
    if ([str isEqualToString:@""] || str == nil || !str || [str isEqualToString:@"null"] || str == NULL){
        
        return nil;
    }else{
        return str;
    }
}

#pragma mark  获取假UUID


//获取当前VC
- (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


#pragma mark 自定义Label
-(UILabel *)labelWithTitle:(NSString *)text Font:(NSInteger)font textColor:(UIColor *)color
{
    UILabel *label=[UILabel new];
    label.text=text;
    label.font=[UIFont systemFontOfSize:font];
    label.textColor=color;
    label.textAlignment=NSTextAlignmentCenter;
    return label;
}

#pragma mark 自定义button
-(UIButton *)buttonWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color Selector:(SEL)btnSelect Target:(UIViewController *)vc
{
    UIButton *btn=[UIButton new];
    btn.titleLabel.font=[UIFont systemFontOfSize:font];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:vc action:btnSelect forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark 自定义View层上button
- (UIButton *)buttonFromViewWithTitle:(NSString *)title font:(NSInteger)font titleColor:(UIColor *)color Selector:(SEL)btnSelect Target:(UIView *)vc
{
    UIButton *btn=[UIButton new];
    btn.titleLabel.font=[UIFont systemFontOfSize:font];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn addTarget:vc action:btnSelect forControlEvents:UIControlEventTouchUpInside];
    [vc addSubview:btn];
    return btn;
}

#pragma mark 获取文字宽度
-(CGFloat)rectTextWidthWithString:(NSString *)string Font:(NSInteger)font TextHeight:(CGFloat)textHeight
{
    NSDictionary *attributes=@{NSFontAttributeName:[UIFont systemFontOfSize:font]};
    CGSize size=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, textHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    return size.width;
}

@end
