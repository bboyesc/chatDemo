//
//  paoPaoView.m
//  chatDemo
//
//  Created by 陆永亨 on 15/12/6.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import "paoPaoView.h"

@implementation paoPaoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _maskLayer = [CAShapeLayer layer];
     _contentLayer = [CALayer layer];
  

       [self.layer addSublayer:_contentLayer];
}

-(void)setLayerWithImage:(UIImage*)image
{
    _contentLayer.mask = _maskLayer;
    
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.5, 0.5, 0.1, 0.1);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
    _maskLayer.contents = (id)image.CGImage;
    
    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    _contentLayer.frame = self.bounds;
    

}

- (void)setImage:(UIImage *)image
{
    _contentLayer.contents = (id)image.CGImage;
}

@end
