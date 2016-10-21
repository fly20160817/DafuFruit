//
//  LonginViewController.m
//  DafuFruit
//
//  Created by admin on 16/10/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LonginViewController.h"
#import "PersonTableViewController.h"
#import "RegironViewController.h"
@interface LonginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *psd;


- (IBAction)longIn:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)forgotPsd:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation LonginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userName.delegate = self;
    _psd.delegate = self;
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 25, 50, 50)];
    [but setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *zhuce =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 35, 50, 30)];
    [zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1] forState:UIControlStateNormal];
    zhuce.font=[UIFont systemFontOfSize:20];
    [zhuce addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
    
    
    UILabel *lanel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30)/2, 35, 50, 30)];
    lanel.text=@"登录";
    lanel.textColor=[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    lanel.font=[UIFont systemFontOfSize:21];
    [self.view addSubview:lanel];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)clickaddBtn:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)zhuce
{
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Wjt" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"region"] animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 隐藏导航栏方法
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.tabBarController.tabBar.hidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //让键盘收回去
    [textField resignFirstResponder];
    return YES;
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_psd resignFirstResponder];
    [_userName resignFirstResponder];
}


- (IBAction)longIn:(UIButton *)sender forEvent:(UIEvent *)event {
    [AVUser logInWithMobilePhoneNumberInBackground:_userName.text password:_psd.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            //[self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"FDL" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"Person"] animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"%@",error);
        }
        [Utilities setUserDefaults:@"userName"content:user.objectId];
    }];

}

- (IBAction)forgotPsd:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
