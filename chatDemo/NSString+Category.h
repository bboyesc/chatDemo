//
//  NSString+Category.h
//  test
//
//  Created by Icbmken on 15-1-21.
//  Copyright (c) 2015年 cjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
+(CGSize)getSizeWith:(NSString *)text andFont:(CGFloat) font;
+(NSString *)MD5withString:(NSString *)text;
+(NSString *)valueWithXMLTagName:(NSString *)tagStartName tagEndName:(NSString *)tagEndName XML:(NSString *)xml;
+(NSString *)uncodechace:(NSString *)codestring;
+(NSString *)timeconversion:(NSString *)timestamp;
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
+(NSString *)uncodechacehuanhangfu:(NSString *)codestring;
+(CGSize)getSizeWith:(NSString *)text  andFont:(CGFloat) font withMaxSize:(CGSize)size;
+(NSString *)uncodechacekongge:(NSString *)codestring;
+(NSString*)sha1:(NSString*)input;
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString;
+ (NSString *)hexStringFromString:(NSString *)string;
+ (NSString *)stringFromHexString:(NSString *)hexString;
+(NSString*)getDeviceModel;
+(NSString *)SingleQuotationMarksToEscapeWithString:(NSString*)str;
@end
