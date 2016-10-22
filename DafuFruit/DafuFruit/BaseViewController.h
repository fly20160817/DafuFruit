//
//  BaseViewController.h
//  MyFirstApp
//
//  Created by admin on 16/8/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


//设置页面的背景颜色和导航栏及导航栏标题等，让其他页面去继承它，省的每个页面都去设置背景颜色和导航栏

@interface BaseViewController : UIViewController < UIGestureRecognizerDelegate >

- (void) setSingleLineTitle: (NSString *)title;//设置标题

//弹窗
- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText;


//返回按钮
- (void) setBackButton;

//导航栏左侧按钮 (Title：按钮上要写的文字  target：谁来调用 action：调用什么方法)
- (void) setLeftNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

//导航栏右侧按钮
- (void) setRightNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;



//加载动画（菊花）
- (void) showLoading;

//隐藏加载动画（隐藏菊花）
- (void) hideLoading;

//阻塞加载 （锁住用户，加了一层半透明的膜）
- (void)showModalLoading;

//隐藏阻塞加载
- (void)hideModalLoading;


@end
