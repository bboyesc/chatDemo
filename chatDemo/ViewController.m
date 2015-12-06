//
//  ViewController.m
//  chatDemo
//
//  Created by 陆永亨 on 15/12/4.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import "ViewController.h"
#import "YYKit.h"
#import "chatModel.h"
#import "chatMsgTableViewCell.h"
#import "chatMsgImageCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)UITableView * tableview;
@property(strong,nonatomic)chatModel * chatMM;

@property (nonatomic, strong) NSDictionary *emojiDic;   //emoji表情
@property (strong,nonatomic)NSMutableDictionary *mapper; //emoji表情解析
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup after loading the view, typically from a nib.
  }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"聊天排版";
      self.view.backgroundColor = WHITE_COLOR;
    [self.view addSubview:self.tableview];
    
   // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    
        NSString *emojiFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"emotionImage.plist"];
        _emojiDic = [[NSDictionary alloc] initWithContentsOfFile:emojiFilePath];
        _mapper = [NSMutableDictionary new];
    self.chatMM = [[chatModel alloc]initWithEmotiomDic:_emojiDic];
        for(NSString * key in _emojiDic.allKeys)
        {
            NSString * values = _emojiDic[key];
            
            _mapper[key] = [self imageWithName:values];
        }
        
        
        //dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableview reloadData];
        //});
        
    //});
    

    
}
- (UIImage *)imageWithName:(NSString *)name {
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    YYImage *image = [YYImage imageWithData:data scale:[UIScreen mainScreen].scale];
    image.preloadAllAnimatedImageFrames = YES;
    return image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate & datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatMM.msgMutableAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    msgModel * msgMM = self.chatMM.msgMutableAry[indexPath.row];
    
  
    
    switch (msgMM.type) {
        case text:
        {
            chatMsgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
            if (cell == nil) {
                cell = [[chatMsgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
                [cell setCellWithMapper:_mapper];
            }
            [cell setMsgCellWithMsgMM:msgMM];
            return cell;
        }
            break;
        case image:
        {
            chatMsgImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID1"];
            if (cell == nil) {
                cell = [[chatMsgImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID1"];
                [cell setCellWithMapper:_mapper];
            }
            [cell setMsgCellWithMsgMM:msgMM];
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
     msgModel * msgMM = self.chatMM.msgMutableAry[indexPath.row];
    
    switch (msgMM.type) {
        case text:
            return msgMM.msgTextSize.height+60;
            break;
        case image:
            return SCREEN_WIDTH/2+40;
        default:
            return 60;
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}


-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = 0;
    }
    
    return _tableview;
}
@end
