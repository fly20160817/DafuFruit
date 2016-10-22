//
//  UIButton+fly.m
//  MyFirstApp
//
//  Created by admin on 16/9/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIButton+fly.h"
#import "UIImage+fly.h"
#import "Utility.h"

@implementation UIButton (fly)

//contentButtonWithTitle：按钮上要写的文字  target：谁来调用 action：调用什么方法
+ (UIButton *) contentButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    //自定义类型按钮（UIButtonTypeCustom）
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //按钮在普通状态(未点击)下的文字（普通状态：UIControlStateNormal）
    [button setTitle:title forState:UIControlStateNormal];
    //按钮在普通状态下的颜色
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    //字体
    UIFont * buttonFont = [UIFont systemFontOfSize:17];
    button.titleLabel.font = buttonFont;
    
    //圆角半径
    button.layer.cornerRadius = 5;
    //描边宽度
    button.layer.borderWidth = 1;
    //描边颜色 (.CGColor是转换成CGColor)
    button.layer.borderColor = [UIColor grayColor].CGColor;
    //剪掉圆角之外的东西
    button.layer.masksToBounds = YES;
    
    //给一个高度和宽度，宽度无限大，和屏幕一样宽
    CGSize buttonSize = CGSizeMake( [Utility screenWidth], 29);
    
    //字体给字典
    NSDictionary * buttonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font, NSFontAttributeName, nil];
    
    //文字宽度
    CGRect buttonRect = [title boundingRectWithSize:buttonSize options:kNilOptions attributes:buttonAttributes context:nil];
    
    //按钮暂定宽度 (文字宽度加上左右各留白8的宽度)
    CGFloat plannedButtonWidth = buttonRect.size.width + 16;
    
    //如果按钮的宽度小于55，就让它赋值为55，（如果文字宽度太小，按钮也就会太小，不好看，所以设置最小宽度）
    if ( plannedButtonWidth < 55 )
    {
        plannedButtonWidth = 55;
    }
    
    [button setFrame:CGRectMake( 0, 0, plannedButtonWidth, 29)];
    
    
    UIImage * activeImage = [UIImage imageWithColor:[UIColor grayColor] andSize:button.frame.size];
    
    //按钮点击之后的样式
    [button setBackgroundImage:activeImage forState:UIControlStateHighlighted];
    
    //按钮上文字点击之后的样式
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    //为按钮添加事件 (UIControlEventTouchUpInside是点击时触发)
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}



//普通按钮
+ (UIButton *) navigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    //自定义类型按钮（UIButtonTypeCustom）
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //按钮在普通状态(未点击)下的文字（普通状态：UIControlStateNormal）
    [button setTitle:title forState:UIControlStateNormal];
    //按钮在普通状态下的颜色
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //字体
    UIFont * buttonFont = [UIFont systemFontOfSize:14];
    button.titleLabel.font = buttonFont;

    
    //拉伸 （左边15的距离不能拉伸，右边8的距离不能拉伸，只能拉中间（矢量图））
    UIEdgeInsets stretch = UIEdgeInsetsMake(0, 8, 0, 8);
    
    //正常状态下的图片
    UIImage * normalImage = [UIImage imageNamed:@"common_button_navigation_normal"];
    
    //图片拉伸 （第一个参数是拉伸的数值是多少，第二个参数是拉伸的方式）
    normalImage = [normalImage resizableImageWithCapInsets:stretch resizingMode:UIImageResizingModeStretch];
    
    //按钮样式改用图片  forState:为什么状态设定(普通状态)
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    
    
    //被按下状态下的图片
    UIImage * activeImage = [UIImage imageNamed:@"common_button_navigation_active"];
    
    //图片拉伸 （第一个参数是拉伸的数值是多少，第二个参数是拉伸的方式）
    activeImage = [activeImage resizableImageWithCapInsets:stretch resizingMode:UIImageResizingModeStretch];
    
    //按钮样式改用图片  forState:为什么状态设定（高亮状态）
    [button setBackgroundImage:activeImage forState:UIControlStateHighlighted];
    
    
    //给一个高度和宽度，宽度无限大，和屏幕一样宽
    CGSize buttonSize = CGSizeMake( [Utility screenWidth], 29);
    
    //字体给字典
    NSDictionary * buttonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font, NSFontAttributeName, nil];
    
    //文字宽度
    CGRect buttonRect = [title boundingRectWithSize:buttonSize options:kNilOptions attributes:buttonAttributes context:nil];
    
    //按钮暂定宽度 (文字宽度加上左右各留白8的宽度)
    CGFloat plannedButtonWidth = buttonRect.size.width + 16;
    
    //如果按钮的宽度小于55，就让它赋值为55，（如果文字宽度太小，按钮也就会太小，不好看，所以设置最小宽度）
    if ( plannedButtonWidth < 55 )
    {
        plannedButtonWidth = 55;
    }
    
    [button setFrame:CGRectMake( 0, 0, plannedButtonWidth, 29)];
    
    //为按钮添加事件 (UIControlEventTouchUpInside是点击时触发)
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


//箭头按钮(返回按钮)
+ (UIButton *) navigationBackButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    //自定义类型按钮（UIButtonTypeCustom）
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //按钮在普通状态(未点击)下的文字（普通状态：UIControlStateNormal）
    [button setTitle:title forState:UIControlStateNormal];
    //按钮在普通状态下的颜色
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    //字体
    UIFont * buttonFont = [UIFont systemFontOfSize:14];
    button.titleLabel.font = buttonFont;
    
    //文字左侧多留白（上左下右逆时针的顺序）
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 7, 0, 0);
    button.contentEdgeInsets = padding;
    
    
    //拉伸 （左边15的距离不能拉伸，右边8的距离不能拉伸，只能拉中间（矢量图））
    UIEdgeInsets stretch = UIEdgeInsetsMake(0, 15, 0, 8);
    
    //正常状态下的图片
    UIImage * normalImage = [UIImage imageNamed:@"common_button_back_normal"];

    //图片拉伸 （第一个参数是拉伸的数值是多少，第二个参数是拉伸的方式）
    normalImage = [normalImage resizableImageWithCapInsets:stretch resizingMode:UIImageResizingModeStretch];
    
    //按钮样式改用图片  forState:为什么状态设定(普通状态)
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    
    
    //被按下状态下的图片
    UIImage * activeImage = [UIImage imageNamed:@"common_button_back_active"];
    
    //图片拉伸 （第一个参数是拉伸的数值是多少，第二个参数是拉伸的方式）
    activeImage = [activeImage resizableImageWithCapInsets:stretch resizingMode:UIImageResizingModeStretch];
    
    //按钮样式改用图片  forState:为什么状态设定（高亮状态）
    [button setBackgroundImage:activeImage forState:UIControlStateHighlighted];
    
    
    //给一个高度和宽度，宽度无限大，和屏幕一样宽
    CGSize buttonSize = CGSizeMake( [Utility screenWidth], 29);
    
    //字体给字典
    NSDictionary * buttonAttributes = [NSDictionary dictionaryWithObjectsAndKeys:button.titleLabel.font, NSFontAttributeName, nil];
    
    //文字宽度
    CGRect buttonRect = [title boundingRectWithSize:buttonSize options:kNilOptions attributes:buttonAttributes context:nil];
    
    //按钮暂定宽度 (文字宽度加上左右各留白8的宽度)
    CGFloat plannedButtonWidth = buttonRect.size.width + 23;
    
    //如果按钮的宽度小于55，就让它赋值为55，（如果文字宽度太小，按钮也就会太小，不好看，所以设置最小宽度）
    if ( plannedButtonWidth < 55 )
    {
        plannedButtonWidth = 55;
    }
    
    [button setFrame:CGRectMake( 0, 0, plannedButtonWidth, 29)];
    
    //为按钮添加事件 (UIControlEventTouchUpInside是点击时触发)
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
