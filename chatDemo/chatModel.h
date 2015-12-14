//
//  chatModel.h
//  chatDemo
//
//  Created by 陆永亨 on 15/12/4.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYKit.h"
typedef NS_ENUM(NSInteger, msgType) {
    text     = 1 ,
    sound    = 3 ,
    image    = 2
};

typedef NS_ENUM(NSInteger, sendType) {
    meSend     = 0 ,
    otherSend    = 1 ,
};

#define kWBCellMSGTextFontSize 14 // 消息文本字体大小
#define kWBCellMSGTextColor UIColorHex(333333) // 消息文本字体颜色
#define kWBCellPadding 0       // cell 内边距
#define kWBCellPaddingText 10   // cell 文本与其他元素间留白
#define kWBCellContentWidth (SCREEN_WIDTH-40-10-20) // cell 内容宽度
#define kWBCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色

/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface MSGTextLinePositionModifier : NSObject <YYTextLinePositionModifier>
@property (nonatomic, strong,nullable) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;
@end


@interface msgModel : NSObject
@property(strong,nonatomic,nullable)NSString *msgText;
@property(assign,nonatomic)msgType type;             //消息种类
@property(assign,nonatomic)CGSize msgTextSize;       //消息内容
@property(assign,nonatomic)CGFloat textHeight;       //文本高度
@property(strong,nonatomic,nullable)YYTextLayout *textLayout; //文本layout
@property(assign,nonatomic)sendType sendtype;        //发送消息者
@property(strong,nonatomic,nullable)NSDictionary * EmotionDic;
-(instancetype)initWithMsgText:(NSString*)str withEmotionDic:(NSDictionary*)dic;

@end

@interface chatModel : NSObject
@property(strong,nonatomic,nullable)NSArray * msgAry;
@property(strong,nonatomic,nullable)msgModel * msgMM;
@property(strong,nonatomic,nullable)NSMutableArray * msgMutableAry;

-(instancetype)initWithEmotiomDic:(NSDictionary*)emotionDic;
@end
