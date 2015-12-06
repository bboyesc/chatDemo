//
//  chatMsgTableViewCell.m
//  chatDemo
//
//  Created by 陆永亨 on 15/12/4.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import "chatMsgTableViewCell.h"

@implementation chatMsgTableViewCell

-(void)setCellWithMapper:(NSDictionary*)mapper
{
    _HeadImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_HeadImageBtn setImage:[UIImage imageNamed:@"headImage"] forState:UIControlStateNormal];
    _HeadImageBtn.size = CGSizeMake(40, 40);
    
    [self.contentView addSubview:_HeadImageBtn];
    
    
    _paopaoView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:_paopaoView];
    
    _msgTextView = [YYTextView new];
    
    _parser = [[YYTextSimpleEmoticonParser alloc]init];
    _parser.emoticonMapper = mapper;
    
    _msgTextView.font = [UIFont systemFontOfSize:14];
    _msgTextView.textColor = BLACK_COLOR;
    _msgTextView.textParser = _parser;
    _msgTextView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    
  
    
    _msgTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (IS_IOS_7) {
        _msgTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    
    _msgTextView.scrollEnabled = NO;
    _msgTextView.editable = NO;

    [_paopaoView addSubview:_msgTextView];

}

-(void)setMsgCellWithMsgMM:(msgModel*)msgMM
{
    
    UIImage *normal;
    if (msgMM.sendtype == otherSend) {
    
        
       normal = [UIImage imageNamed:@"chatto_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 10, 30)];
    }
    else{

        normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 10, 30)];
    }
//    
    _paopaoView.image = normal;
    _paopaoView.size = CGSizeMake(msgMM.msgTextSize.width+30, msgMM.msgTextSize.height+20);
  
    _msgTextView.text = msgMM.msgText;
    _msgTextView.size = CGSizeMake(msgMM.msgTextSize.width, msgMM.msgTextSize.height+10);
    _msgTextView.contentSize = msgMM.msgTextSize;
    
    if (msgMM.sendtype==meSend) {
        [_HeadImageBtn setPosition:CGPointMake(10, 10) atAnchorPoint:CGPointMake(0, 0)];
        
        [_paopaoView setPosition:CGPointMake(_HeadImageBtn.x+_HeadImageBtn.width, 20) atAnchorPoint:CGPointMake(0, 0)];
        [_msgTextView setPosition:CGPointMake(20, 10) atAnchorPoint:CGPointMake(0, 0)];
    }
    else
    {
        [_HeadImageBtn setPosition:CGPointMake(SCREEN_WIDTH-10, 10) atAnchorPoint:CGPointMake(1, 0)];
        
        [_paopaoView setPosition:CGPointMake(_HeadImageBtn.x, 20) atAnchorPoint:CGPointMake(1, 0)];
        [_msgTextView setPosition:CGPointMake(10, 10) atAnchorPoint:CGPointMake(0, 0)];
    }
 
    
    
}

@end
