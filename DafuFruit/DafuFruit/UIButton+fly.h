//
//  UIButton+fly.h
//  MyFirstApp
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (fly)


//contentButtonWithTitle：按钮上要写的文字  target：谁来调用 action：调用什么方法
+ (UIButton *) contentButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//普通按钮
+ (UIButton *) navigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//箭头按钮(返回按钮)
+ (UIButton *) navigationBackButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
