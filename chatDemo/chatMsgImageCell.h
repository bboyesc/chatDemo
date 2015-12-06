//
//  chatMsgImageCell.h
//  chatDemo
//
//  Created by 陆永亨 on 15/12/6.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"
#import "YYKit.h"
#import "chatModel.h"

@interface chatMsgImageCell : UITableViewCell

@property (nonatomic, strong)YYLabel *labelTime;
@property (nonatomic, strong)YYLabel *labelNum;
@property (nonatomic, strong)UIButton *HeadImageBtn;
@property (nonatomic, strong)UIImageView *msgImageView;
@property (nonatomic,strong)chatModel * msgMM;
@property (nonatomic,strong)UIImageView   * paopaoView;
@property(strong,nonatomic)YYTextSimpleEmoticonParser *parser;  //解析器


-(void)setMsgCellWithMsgMM:(msgModel*)chatMM;


-(void)setCellWithMapper:(NSDictionary*)mapper;
@end
