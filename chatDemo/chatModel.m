//
//  chatModel.m
//  chatDemo
//
//  Created by 陆永亨 on 15/12/4.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import "chatModel.h"
#import "RegexKitLite.h"
@implementation chatModel

-(instancetype)initWithEmotiomDic:(NSDictionary*)emotionDic
{
    self = [super init];
    
    if (self) {
        
      
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
        _msgAry  = [[NSArray alloc] initWithContentsOfFile:plistPath];
        [self loadMsgModelWithEmotionDic:emotionDic];
        
    }
    return self;
}

-(void)loadMsgModelWithEmotionDic:(NSDictionary*)dic
{
    
    for (int i =0; i<_msgAry.count;i++) {
        NSDictionary * dicT =_msgAry[i];
        
        msgModel * msgMM = [[msgModel alloc]initWithMsgText:dicT[@"text"] withEmotionDic:dic];
        if (i/2==0) {
            msgMM.sendtype=1;
        }
        NSNumber * type = dicT[@"type"];
        msgMM.type = [type integerValue];
        [self.msgMutableAry addObject:msgMM];
    }
    
}

-(NSMutableArray *)msgMutableAry
{
    if (!_msgMutableAry) {
        _msgMutableAry = [NSMutableArray array];
        
    }
    return _msgMutableAry;
}

@end





@implementation msgModel

-(instancetype)initWithMsgText:(NSString*)str withEmotionDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        _EmotionDic = dic;
        self.msgText =str;
        
    }
    
    return self;
}


-(void)setMsgText:(NSString *)msgText
{
    
   
    CGSize msgSize = [NSString getSizeWith:msgText andFont:14 withMaxSize:CGSizeMake(SCREEN_WIDTH-40-10-20, 1000)];
    _msgText =msgText;
    _msgTextSize = msgSize;
    [self setMsgTextLayoutWith:msgText];
}


-(void)setMsgTextLayoutWith:(NSString*)msgText
{
    _textHeight = 0;
    _textLayout = nil;
    NSMutableAttributedString *text = [self _textWithStatus:msgText
                                                   fontSize:kWBCellMSGTextFontSize
                                                  textColor:kWBCellMSGTextColor];
    if (text.length == 0) return;
    NSLog(@"%@",text);
    MSGTextLinePositionModifier *modifier = [MSGTextLinePositionModifier new];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:kWBCellMSGTextFontSize];
    modifier.paddingTop = kWBCellPaddingText;
    modifier.paddingBottom = kWBCellPaddingText;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(kWBCellContentWidth, HUGE);
    container.linePositionModifier = modifier;
    
    _textLayout = [YYTextLayout layoutWithContainer:container text:text];
    if (!_textLayout) return;
    
    _textHeight = [modifier heightForLineCount:_textLayout.lines.count];
}


- (NSMutableAttributedString *)_textWithStatus:(NSString *)msgText
                                      fontSize:(CGFloat)fontSize
                                     textColor:(UIColor *)textColor {
    if (!msgText) return nil;
    
    NSMutableString *string = msgText.mutableCopy;
    if (string.length == 0) return nil;
    
    // 字体
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = kWBCellTextHighlightBackgroundColor;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = textColor;
    
    // 匹配 [表情]
    NSArray *emoticonResults = [[self regexEmoticon] matchesInString:text.string options:kNilOptions range:text.rangeOfAll];
    NSUInteger emoClipLength = 0;
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= emoClipLength;
        if ([text attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([text attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [text.string substringWithRange:range];
        NSString *imagePath = _EmotionDic[emoString];
        YYImage *image = [YYImage imageNamed:imagePath];
        if (!image) continue;
        
        NSAttributedString *emoText = [NSAttributedString attachmentStringWithEmojiImage:image fontSize:fontSize];
        [text replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length - 1;
    }
    
    return text;
}

-(NSRegularExpression *)regexEmoticon {
    NSRegularExpression *regex;
   
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
   
    return regex;
}

- (NSArray *)transformString:(NSString *)originalStr
{
    //匹配表情，将表情转化为html格式
    NSString *text = originalStr;
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSArray *array_emoji = [text componentsMatchedByRegex:regex_emoji];
       //返回转义后的字符串
    return array_emoji;
}

//-(NSDictionary *)emoticonDic {
//    
//    NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"emotionImage.plist"];
//   NSDictionary* dic = [[NSDictionary alloc] initWithContentsOfFile:emojiFilePath];
//    
//    return dic;
//}

//+ (NSMutableDictionary *)_emoticonDicFromPath:(NSString *)path {
//    NSMutableDictionary *dic = [NSMutableDictionary new];
//    WBEmoticonGroup *group = nil;
//    NSString *jsonPath = [path stringByAppendingPathComponent:@"info.json"];
//    NSData *json = [NSData dataWithContentsOfFile:jsonPath];
//    if (json.length) {
//        group = [WBEmoticonGroup modelWithJSON:json];
//    }
//    if (!group) {
//        NSString *plistPath = [path stringByAppendingPathComponent:@"info.plist"];
//        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
//        if (plist.count) {
//            group = [WBEmoticonGroup modelWithJSON:plist];
//        }
//    }
//    for (WBEmoticon *emoticon in group.emoticons) {
//        if (emoticon.png.length == 0) continue;
//        NSString *pngPath = [path stringByAppendingPathComponent:emoticon.png];
//        if (emoticon.chs) dic[emoticon.chs] = pngPath;
//        if (emoticon.cht) dic[emoticon.cht] = pngPath;
//    }
//    
//    NSArray *folders = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
//    for (NSString *folder in folders) {
//        if (folder.length == 0) continue;
//        NSDictionary *subDic = [self _emoticonDicFromPath:[path stringByAppendingPathComponent:folder]];
//        if (subDic) {
//            [dic addEntriesFromDictionary:subDic];
//        }
//    }
//    return dic;
//}

-(UIImage *)imageWithPath:(NSString *)path {
    if (!path) return nil;
    UIImage *image = [[self imageCache] objectForKey:path];
    if (image) return image;
    if (path.pathScale == 1) {
        // 查找 @2x @3x 的图片
        NSArray *scales = [NSBundle preferredScales];
        for (NSNumber *scale in scales) {
            image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathScale:scale.floatValue]];
            if (image) break;
        }
    } else {
        image = [UIImage imageWithContentsOfFile:path];
    }
    if (image) {
        image = [image imageByDecoded];
        [[self imageCache] setObject:image forKey:path];
    }
    return image;
}

-(YYMemoryCache *)imageCache {
        YYMemoryCache *cache;
        cache = [YYMemoryCache new];
        cache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        cache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
        cache.name = @"WeiboImageCache";
   
    return cache;
}
@end

@implementation MSGTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    
    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    //CGFloat ascent = _font.ascender;
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    MSGTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    //    CGFloat ascent = _font.ascender;
    //    CGFloat descent = -_font.descender;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}

@end
