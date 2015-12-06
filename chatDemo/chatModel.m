//
//  chatModel.m
//  chatDemo
//
//  Created by 陆永亨 on 15/12/4.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import "chatModel.h"

@implementation chatModel

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        
      
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
        _msgAry  = [[NSArray alloc] initWithContentsOfFile:plistPath];
        [self loadMsgModel];
        
    }
    return self;
}

-(void)loadMsgModel
{
    
    for (int i =0; i<_msgAry.count;i++) {
        NSString * str =_msgAry[i];
        msgModel * msgMM = [[msgModel alloc]initWithMsgText:str];
        if (i/2==0) {
            msgMM.sendtype=1;
        }
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

-(instancetype)initWithMsgText:(NSString*)str
{
    self = [super init];
    if (self) {
        
        self.msgText =str;
        
    }
    
    return self;
}


-(void)setMsgText:(NSString *)msgText
{
    CGSize msgSize = [NSString getSizeWith:msgText andFont:14 withMaxSize:CGSizeMake(SCREEN_WIDTH-40-10-20, 1000)];
    _msgText =msgText;
    _msgTextSize = msgSize;
}


@end
