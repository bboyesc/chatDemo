//
//  NSString+Category.m
//  test
//
//  Created by Icbmken on 15-1-21.
//  Copyright (c) 2015年 cjs. All rights reserved.
//

#import "NSString+Category.h"
#import <sys/utsname.h>
@implementation NSString (Category)

/**
 *  获取字符串实际的size值
 *
 *  @param text 输入字符串
 *  @param size 指定的size标准（当width无限大的时候，返回的是字符串实际的值，当width为指定值时，例如30，当字符串超过30时，返回的width就是30，height也是）
 *  @param font 指定输入字符串计算实际size值所采用的字体大小
 *
 *  @return 字符串实际的大小
 */
+(CGSize)getSizeWith:(NSString *)text  andFont:(CGFloat) font
{
    UIFont *myfont = [UIFont systemFontOfSize:font];
    

   
    return  [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, 8000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : myfont} context:nil].size;
    
}
+(CGSize)getSizeWith:(NSString *)text  andFont:(CGFloat) font withMaxSize:(CGSize)size
{
    UIFont *myfont = [UIFont systemFontOfSize:font];
    
    
    
    return  [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : myfont} context:nil].size;
    
}

+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}
+ (NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString; 
    
    
}
//16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self MD5withString:srcString];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}
/**
 *  根据XML文本返回指定节点的值
 *
 *  @param tagStartName 开始标签
 *  @param tagEndName   结束标签
 *  @param xml          整个XML文本
 *
 *  @return 返回指定标签的值
 */
+(NSString *)valueWithXMLTagName:(NSString *)tagStartName tagEndName:(NSString *)tagEndName XML:(NSString *)xml
{
    
    NSString *endTargetStr = tagEndName;
    NSString *beginTargetStr = tagStartName;
    
    NSRange r = [xml rangeOfString:endTargetStr];
    if (r.location != NSNotFound) {
        NSString *str = [xml substringToIndex:r.location];
        
        NSRange range = [str rangeOfString:beginTargetStr];
        if(range.length > 0)
        {
            r = [str rangeOfString:beginTargetStr];
            if (r.location != NSNotFound) {
                str = [str substringFromIndex:r.location + r.length];
                return str;
            }
        }
    }
    return @"";
}

/**
 *  字符编码转换
 */
+(NSString *)uncodechace:(NSString *)codestring
{
    NSString *tempstr = [codestring stringByReplacingOccurrencesOfString:@"&nbsp;"withString:@" "];
    NSString *tempStr1 = [tempstr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [ returnStr stringByReplacingOccurrencesOfString:@"\\r\\t"withString:@""];
}

/**
 *  字符编码转换
 */
+(NSString *)uncodechacehuanhangfu:(NSString *)codestring
{
    NSString *tempstr = [codestring stringByReplacingOccurrencesOfString:@"\\n"withString:@""];
    NSString *tempStr1 = [tempstr stringByReplacingOccurrencesOfString:@"\\t"withString:@""];
    NSData *tempData = [tempStr1 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [ returnStr stringByReplacingOccurrencesOfString:@"\\n\\t"withString:@""];
}
+(NSString *)uncodechacekongge:(NSString *)codestring
{
    NSString *tempstr = [codestring stringByReplacingOccurrencesOfString:@" "withString:@""];
  
    NSData *tempData = [tempstr dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [ returnStr stringByReplacingOccurrencesOfString:@"\\n\\t"withString:@""];
}


+(NSString *)SingleQuotationMarksToEscapeWithString:(NSString*)str
{
    
    NSRange range = [str rangeOfString:@"'"];//匹配得到的下标
    if (range.length>0) {
       str =[str stringByReplacingOccurrencesOfString:@"'" withString:@"`"];
    }
    return str;
}

/**
 *  时间戳转换
 */

+(NSString *)timeconversion:(NSString *)timestamp
{
    NSTimeInterval time=[timestamp doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];  //HH:mm:ss
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSFontAttributeName] = font;
    
    CGSize maxSize = CGSizeMake(maxW, 60);
    
   return  [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}

-(CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:60];
}

+(NSString*)getDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])
        
    {
        
        platform =
        @"iPhone";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPhone1,2"])
        
    {
        
        platform =
        @"iPhone 3G";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPhone2,1"])
        
    {
        
        platform =
        @"iPhone 3GS";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPhone3,1"]||[platform
                                             isEqualToString:@"iPhone3,2"]||[platform
                                                                             isEqualToString:@"iPhone3,3"])
        
    {
        
        platform =
        @"iPhone 4";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPhone4,1"])
        
    {
        
        platform =
        @"iPhone 4S";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPhone5,1"]||[platform
                                             isEqualToString:@"iPhone5,2"])
        
    {
        
        platform =
        @"iPhone 5";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPhone5,3"]||[platform
                                             isEqualToString:@"iPhone5,4"])
        
    {
        
        platform =
        @"iPhone 5C";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPhone6,2"]||[platform
                                             isEqualToString:@"iPhone6,1"])
        
    {
        
        platform =
        @"iPhone 5S";
        
    }
    
    else if([platform
             isEqualToString:@"iPhone7,1"])
        
    {
        
        platform =
        @"iPhone 6s";
        
    }
    else if([platform
             isEqualToString:@"iPhone7,2"])
        
    {
        
        platform =
        @"iPhone 6";
        
    }
    else if([platform
             isEqualToString:@"iPod4,1"])
        
    {
        
        platform =
        @"iPod touch 4";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPod5,1"])
        
    {
        
        platform =
        @"iPod touch 5";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPod3,1"])
        
    {
        
        platform =
        @"iPod touch 3";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPod2,1"])
        
    {
        
        platform =
        @"iPod touch 2";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPod1,1"])
        
    {
        
        platform =
        @"iPod touch";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPad3,2"]||[platform
                                           isEqualToString:@"iPad3,1"])
        
    {
        
        platform =
        @"iPad 3";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPad2,2"]||[platform
                                           isEqualToString:@"iPad2,1"]||[platform
                                                                         isEqualToString:@"iPad2,3"]||[platform
                                                                                                       isEqualToString:@"iPad2,4"])
        
    {
        
        platform =
        @"iPad 2";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPad1,1"])
        
    {
        
        platform =
        @"iPad 1";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPad2,5"]||[platform
                                           isEqualToString:@"iPad2,6"]||[platform
                                                                         isEqualToString:@"iPad2,7"])
        
    {
        
        platform =
        @"ipad mini";
        
    }
    
    
    else if([platform
             isEqualToString:@"iPad3,3"]||[platform
                                           isEqualToString:@"iPad3,4"]||[platform
                                                                         isEqualToString:@"iPad3,5"]||[platform
                                                                                                       isEqualToString:@"iPad3,6"])
        
    {
        
        platform =
        @"ipad 3";
        
    }
    return platform;
}

@end
