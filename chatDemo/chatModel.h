//
//  chatModel.h
//  chatDemo
//
//  Created by 陆永亨 on 15/12/4.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, msgType) {
    text     = 0 ,
    sound    = 2 ,
    image    = 1
};

typedef NS_ENUM(NSInteger, sendType) {
    meSend     = 0 ,
    otherSend    = 1 ,
};

@interface msgModel : NSObject
@property(strong,nonatomic,nullable)NSString *msgText;
@property(assign,nonatomic)msgType type;
@property(assign,nonatomic)CGSize msgTextSize;
@property(assign,nonatomic)sendType sendtype;

-(instancetype)initWithMsgText:( NSString* _Nullable)str;

@end

@interface chatModel : NSObject
@property(strong,nonatomic,nullable)NSArray * msgAry;
@property(strong,nonatomic,nullable)msgModel * msgMM;
@property(strong,nonatomic,nullable)NSMutableArray * msgMutableAry;
@end
