//
//  CALayer+ff.m
//  聊天
//
//  Created by admin1 on 16/8/25.
//  Copyright © 2016年 admin1. All rights reserved.
//

#import "CALayer+ff.h"
#import <UIKit/UIKit.h>
@implementation CALayer (ff)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
