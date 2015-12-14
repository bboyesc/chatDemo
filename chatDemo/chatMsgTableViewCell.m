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
    
    
    _paopaoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    
    [self.contentView addSubview:_paopaoView];
    
    _msgTextView = [YYLabel new];
    
    //_parser = [[YYTextSimpleEmoticonParser alloc]init];
   // _parser.emoticonMapper = mapper;
    
    _msgTextView.font = [UIFont systemFontOfSize:14];
    _msgTextView.textColor = BLACK_COLOR;
   // _msgTextView.textParser = _parser;
    //_msgTextView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    _msgTextView.numberOfLines =0;
    _msgTextView.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _msgTextView.displaysAsynchronously = YES;
    _msgTextView.ignoreCommonProperties = YES;
    _msgTextView.fadeOnHighlight = NO;
    _msgTextView.fadeOnAsynchronouslyDisplay = NO;
    
 //   _msgTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    

    [_paopaoView addSubview:_msgTextView];

}

-(void)setMsgCellWithMsgMM:(msgModel*)msgMM
{
    
    UIImage * normal;
    if (msgMM.sendtype == otherSend) {
    
        
       normal = [UIImage imageNamed:@"chatto_bg_normal"];
       // normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 10, 30)];
        UIEdgeInsets edge=UIEdgeInsetsMake(35, 10, 10,22);

        normal= [normal resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
        //[_paopaoView setLayerWithImage:[UIImage imageNamed:@"chatto_bg_normal"]];
        _paopaoView.image = normal;
    }
    else{

        normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
       // normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(20, 10, 10, 30)];
        UIEdgeInsets edge=UIEdgeInsetsMake(35, 22, 10,10);
    
           normal= [normal resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
        _paopaoView.image = normal;
        //[_paopaoView setLayerWithImage:[UIImage imageNamed:@"chatfrom_bg_normal"]];
    }
//    
    
   
   
    //_msgTextView.text = msgMM.msgText;
    _msgTextView.textLayout = msgMM.textLayout;
    _msgTextView.size = CGSizeMake(_msgTextView.textLayout.textBoundingSize.width, _msgTextView.textLayout.textBoundingSize.height);

    _paopaoView.size = CGSizeMake(_msgTextView.textLayout.textBoundingSize.width+20, _msgTextView.textLayout.textBoundingSize.height+5);
    if (msgMM.sendtype==meSend) {
        [_HeadImageBtn setPosition:CGPointMake(10, 10) atAnchorPoint:CGPointMake(0, 0)];
        
        [_paopaoView setPosition:CGPointMake(_HeadImageBtn.x+_HeadImageBtn.width, 20) atAnchorPoint:CGPointMake(0, 0)];
        [_msgTextView setPosition:CGPointMake(15, 0) atAnchorPoint:CGPointMake(0, 0)];
    }
    else
    {
        [_HeadImageBtn setPosition:CGPointMake(SCREEN_WIDTH-10, 10) atAnchorPoint:CGPointMake(1, 0)];
        
        [_paopaoView setPosition:CGPointMake(_HeadImageBtn.x, 20) atAnchorPoint:CGPointMake(1, 0)];
        [_msgTextView setPosition:CGPointMake(5, 0) atAnchorPoint:CGPointMake(0, 0)];
    }

    
    
}

@end
