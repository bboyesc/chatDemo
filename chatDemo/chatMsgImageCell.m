//
//  chatMsgImageCell.m
//  chatDemo
//
//  Created by 陆永亨 on 15/12/6.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import "chatMsgImageCell.h"

@implementation chatMsgImageCell

-(void)setCellWithMapper:(NSDictionary*)mapper
{
    _HeadImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_HeadImageBtn setImage:[UIImage imageNamed:@"headImage"] forState:UIControlStateNormal];
    _HeadImageBtn.size = CGSizeMake(40, 40);
    
    [self.contentView addSubview:_HeadImageBtn];
    
    
    _paopaoView = [[UIImageView alloc]initWithSize:CGSizeMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2)];
    
    
    [self.contentView addSubview:_paopaoView];
    
   // _msgImageView = [[UIImageView alloc]initWithSize:CGSizeMake(SCREEN_WIDTH/2-20, SCREEN_WIDTH/2)];
    
    
    //[_paopaoView addSubview:_msgImageView];
    
}

-(void)setMsgCellWithMsgMM:(msgModel*)msgMM
{
    
   
 
    NSURL * url = [NSURL URLWithString:msgMM.msgText];
    [_paopaoView setImageWithURL:url placeholder:nil options:YYWebImageOptionProgressiveBlur |YYWebImageOptionSetImageWithFadeAnimation progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //progress = (float)receivedSize / expectedSize;
        
    } transform:^UIImage *(UIImage *image, NSURL *url) {
        image = [image imageByResizeToSize:CGSizeMake(SCREEN_WIDTH/2, SCREEN_WIDTH/2) contentMode:UIViewContentModeCenter];
        return [image imageByRoundCornerRadius:2];
        
    } completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
        
        if (from == YYWebImageFromDiskCache) {
            NSLog(@"load from disk cache");
        }
    }];
    
    if (msgMM.sendtype==meSend) {
        [_HeadImageBtn setPosition:CGPointMake(10, 10) atAnchorPoint:CGPointMake(0, 0)];
        
        [_paopaoView setPosition:CGPointMake(_HeadImageBtn.x+_HeadImageBtn.width+10, 20) atAnchorPoint:CGPointMake(0, 0)];
      
    }
    else
    {
        [_HeadImageBtn setPosition:CGPointMake(SCREEN_WIDTH-10, 10) atAnchorPoint:CGPointMake(1, 0)];
        
        [_paopaoView setPosition:CGPointMake(_HeadImageBtn.x-10, 20) atAnchorPoint:CGPointMake(1, 0)];
     
    }
    
    
    
}

@end
