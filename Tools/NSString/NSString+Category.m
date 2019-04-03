//
//  NSString+Category.m
//  FanZuKe
//
//  Created by yanjinlin on 2018/9/6.
//  Copyright © 2018年 yanjinlin. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
//字符串是否为空
-(BOOL)isBlank
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
}

//字符串为空或nil
-(BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]) ? NO :YES;
}

//在字符串中删除空格
- (NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

//字符串中包含单词数
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    
    return count;
}

// 字符串中是否包含子字符串
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// 字符串从给定的字符串开始
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}

// 字符串以给定的字符串结束
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}

// 用新字符替换字符串中的特定字符
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// 从特定的位置获取子字符串，以使其正确
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// 将子字符串添加到主字符串
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

// 从字符串中删除指定字符串
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}



// 字符串只包含字母
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// 字符串只包含数字
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// 字符串中包含数字和字母
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// 字符串包含在数组中
- (BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// 数组转换为字符串
+ (NSString *)getStringFromArray:(NSArray *)array
{
    return [array componentsJoinedByString:@" "];
}

// 字符串转换为数组
- (NSArray *)getArray
{
    return [self componentsSeparatedByString:@" "];
}

// 获取应用程序版本
+ (NSString *)getMyApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleVersion"];
    return version;
}

// 获取应用程序名称
+ (NSString *)getMyApplicationName
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [info objectForKey:@"CFBundleDisplayName"];
    return name;
}

// 字符串转换为NSData
- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// NSData转换为字符串
+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
}

// 是否为邮件格式
- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// 是否为电话格式
- (BOOL)isVAlidPhoneNumber
{
    NSString *regex = @"[235689][0-9]{6}([0-9]{3})?";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

// 是否为URL格式
- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}
@end
