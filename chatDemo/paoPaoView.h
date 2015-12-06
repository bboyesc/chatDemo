//
//  paoPaoView.h
//  chatDemo
//
//  Created by 陆永亨 on 15/12/6.
//  Copyright © 2015年 qixin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface paoPaoView : UIImageView
{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
-(void)setLayerWithImage:(UIImage*)image;
@end
