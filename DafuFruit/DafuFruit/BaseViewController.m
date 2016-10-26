//
//  BaseViewController.m
//  MyFirstApp
//
//  Created by admin on 16/8/4.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"
#import "Utility.h"
#import "UIButton+fly.h"

@interface BaseViewController ()

@property (strong, nonatomic) UIActivityIndicatorView * loading;//加载视图

@property (strong, nonatomic) UIView * modal;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //自定义背景颜色
    UIColor * gray = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.view.backgroundColor = gray;
    
    //自定义导航栏背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65.0/255.0 green:277.0/255.0 blue:65.0/255.0 alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//告诉系统我的导航栏颜色深
    
    //导航栏按钮颜色设置为白色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //隐藏系统自带的返回按钮（隐藏后自己写按钮）
    [self.navigationItem setHidesBackButton:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;//不让系统自动调整滚动视图的位置
}


- (void) setSingleLineTitle: (NSString *)title
{
    //自定义导航栏标题
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];//字体  17号粗体
    titleLabel.textAlignment = NSTextAlignmentCenter;//文字对其方式  居中
    titleLabel.backgroundColor = [UIColor clearColor];//背景颜色  透明
    self.navigationItem.titleView = titleLabel;//方法1
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//弹窗
- (void) showAlertWithTitle:(NSString *)title message:(NSString *)message buttonText:(NSString *)buttonText
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:buttonText style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//如果页面有返回就让它返回
- (void) navigationBack
{
    if ( self.navigationController != nil )
    {
        //返回上一页
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//返回按钮
- (void) setBackButton
{
    UIButton * button = [UIButton  navigationBackButtonWithTitle:@"返回" target:self action:@selector(navigationBack)];
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //创建一个按钮，设置它的宽度为负的，让取消按钮离左侧更近
    UIBarButtonItem * offeset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGFloat buttonOffset;
    
    if ( [Utility screenWidth] >= 414 )
    {
        //iphone 6+以上的设备
        buttonOffset = -12;
    }
    else
    {
        //其它设备
        buttonOffset = -8;
    }
    
    offeset.width = buttonOffset;
    
    //把两个按钮放进导航栏（用数组方式）
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:offeset, barButton, nil];
}

//导航栏左侧按钮 (Title：按钮上要写的文字  target：谁来调用 action：调用什么方法)
- (void) setLeftNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton  navigationButtonWithTitle:title target:target action:action];
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //创建一个按钮，设置它的宽度为负的，让取消按钮离左侧更近
    UIBarButtonItem * offeset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGFloat buttonOffset;
    
    if ( [Utility screenWidth] >= 414 )
    {
        //iphone 6+以上的设备
        buttonOffset = -12;
    }
    else
    {
        //其它设备
        buttonOffset = -8;
    }
    
    offeset.width = buttonOffset;
    
    //把两个按钮放进导航栏（用数组方式）
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:offeset, barButton, nil];

}

//导航栏右侧按钮
- (void) setRightNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton  navigationButtonWithTitle:title target:target action:action];
    
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //创建一个按钮，设置它的宽度为负的，让取消按钮离左侧更近
    UIBarButtonItem * offeset = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    CGFloat buttonOffset;
    
    if ( [Utility screenWidth] >= 414 )
    {
        //iphone 6+以上的设备
        buttonOffset = -12;
    }
    else
    {
        //其它设备
        buttonOffset = -8;
    }
    
    offeset.width = buttonOffset;
    
    //把两个按钮放进导航栏（用数组方式）
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:offeset, barButton, nil];
}


//加载动画（菊花）
- (void) showLoading
{
    //初始化一次就好了，不用每次使用的初始化（没初始化过就初始化，初始化过就不执行了）
    if ( _loading == nil )
    {
        _loading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake( ( [Utility screenWidth] - 20) / 2, ( [Utility screenHeiht] - 20) / 2, 20, 20)];
        
        //菊花的风格样式
        _loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    
    //开始旋转
    [_loading startAnimating];
    
    [self.view addSubview:_loading];
}

//隐藏加载动画（隐藏菊花）
- (void) hideLoading
{
    //停止旋转
    [_loading stopAnimating];
    
    //释放动画
    [_loading removeFromSuperview];
}


//阻塞加载 （锁住用户，加了一层半透明的膜）
- (void)showModalLoading
{
    //黑色遮罩
    if ( _modal == nil )
    {
        _modal = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [Utility screenWidth], [Utility screenHeiht])];
        _modal.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    
    
    //圆角矩形
    UIView * black = [[UIView alloc] initWithFrame:CGRectMake( ([Utility screenWidth] - 80) / 2, ([Utility screenHeiht] - 80) / 2, 80, 80)];
    
    black.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    black.layer.cornerRadius = 12;//圆角半斤
    black.layer.masksToBounds = YES;//裁减
    [_modal addSubview:black];
    
    
    //白色加载动画（菊花）
    UIActivityIndicatorView * modalLoading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(([Utility screenWidth] - 80) / 2, ([Utility screenHeiht] - 80) / 2, 80, 80)];
    
    //风格样式
    modalLoading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    //旋转
    [modalLoading startAnimating];
    
    [_modal addSubview:modalLoading];
    
    
    //把阻塞加载呈现给用户 (要遮住导航栏所以要加在窗口上（.windows[0]是一个数组，它会把我们app应用的所有的窗口都拿出来，我们取出第一个）)
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    
    [window addSubview:_modal];
}


//隐藏阻塞加载
- (void)hideModalLoading
{
    [_modal removeFromSuperview];
}


//手势识别是否启动
- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //如果导航控制器只有一个页面就不需要手势识别 (viewControllers是一个数组，里面包含了导航控制器下的所有页面)
    if ( self.navigationController.viewControllers.count == 1 )
    {
        return NO;
    }
    
    //其他情况都需要
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
