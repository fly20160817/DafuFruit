//
//  UIImage+fly.h
//  MyFirstApp
//
//  Created by admin on 16/10/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (fly)

//根据参数穿进来的颜色和尺寸生成一张图片
+ (UIImage *) imageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
