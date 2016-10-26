//
//  UIImage+fly.m
//  MyFirstApp
//
//  Created by admin on 16/10/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIImage+fly.h"

@implementation UIImage (fly)

//根据参数穿进来的颜色和尺寸生成一张图片
+ (UIImage *) imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [color set];
    
    UIRectFill(CGRectMake(0, 0, size.width * [UIScreen mainScreen].scale, size.height * [UIScreen mainScreen].scale));
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


@end
