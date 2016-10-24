//
//  RegironViewController.m
//  DafuFruit
//
//  Created by admin on 16/10/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RegironViewController.h"
#import "DGTimerButton.h"
@interface RegironViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userPhone;
@property (weak, nonatomic) IBOutlet UITextField *VerificationCode;
@property (weak, nonatomic) IBOutlet UITextField *psWord;
@property (weak, nonatomic) IBOutlet UITextField *confirm;

- (IBAction)carry:(UIButton *)sender forEvent:(UIEvent *)event;


@end

@implementation RegironViewController
{
    DGTimerButton *bu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _userPhone.delegate = self;
    _VerificationCode.delegate = self;
    _psWord.delegate = self;
    _confirm.delegate = self;
    
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 50, 50)];
    [but setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];

    
    UILabel *lanel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30)/2, 30, 50, 30)];
    lanel.text=@"注册";
    lanel.textColor=[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    lanel.font=[UIFont systemFontOfSize:21];
    [self.view addSubview:lanel];

    // Do any additional setup after loading the view.
    
    bu = [DGTimerButton buttonWithType:UIButtonTypeCustom];
    bu.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [bu setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [bu setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    //[bu setBackgroundColor:[UIColor redColor]];
    [bu.layer setCornerRadius:12.0];
    [bu.layer setBorderWidth:1.0];
    bu.layer.borderColor=[UIColor orangeColor].CGColor;
    [bu addTarget:self action:@selector(beginTimer) forControlEvents:UIControlEventTouchUpInside];
    [bu setFrame:CGRectMake(325, 312, 76, 31)];
    //bu.formatStr=@"还剩%zd秒了";
    [bu setDGTimerButtonWithDuration:60
                         runingColor:[UIColor whiteColor]                                               runingTextColor:[UIColor orangeColor]
                       runingImgName:nil
                           formatStr:@"剩余 %zd 秒"
                            buStatus:^(BUStatus status) {
                                
                                if (status==BUStatusRuning) {
                                    //计时中
                                }else if (status==BUStatusCancel){
                                    //结束了（手动结束了，没有超时）
                                }else if (status==BUStatusFinish){
                                    //计时结束了 超时了
                                }
                                
                            }];
    [self.view addSubview:bu];
    
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

-(void)beginTimer{
    [bu beginTimers];

    [AVOSCloud requestSmsCodeWithPhoneNumber:_userPhone.text callback:^(BOOL succeeded, NSError *error) {
        // 发送失败可以查看 error 里面提供的信息
    }];
}

-(UIColor *)color {
    return [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell= [tableView dequeueReusableCellWithIdentifier:@"one" forIndexPath:indexPath];
            break;
        case 1:
            cell= [tableView dequeueReusableCellWithIdentifier:@"two" forIndexPath:indexPath];
            break;
        case 2:
            cell= [tableView dequeueReusableCellWithIdentifier:@"there" forIndexPath:indexPath];
            break;
        case 3:
            cell= [tableView dequeueReusableCellWithIdentifier:@"four" forIndexPath:indexPath];
            break;
            
        default:
            break;
    }
    
    
    
    // Configure the cell...
    
    return cell;
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
    [_userPhone resignFirstResponder];
    [_psWord resignFirstResponder];
    [_VerificationCode resignFirstResponder];
    [_confirm resignFirstResponder];
}


- (IBAction)carry:(UIButton *)sender forEvent:(UIEvent *)event {
//    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:_userPhone.text smsCode:_VerificationCode.text block:^(AVUser *user, NSError *error) {
//        if ([_psWord.text isEqualToString:_confirm.text]) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }else {
//            NSLog(@"密码错误");
//        }
//        NSLog(@"%@",error);
//    }];
    NSString *userPhone = self.userPhone.text;
    NSString *password = self.psWord.text;
    NSString *vc = self.VerificationCode.text;
    NSString *cf = self.confirm.text;
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:userPhone smsCode:vc block:^(AVUser *user, NSError *error) {
        if (error ==nil) {
            if ([cf isEqualToString:password]) {
                user.password = password;
                user.mobilePhoneNumber = userPhone;
                [user saveInBackground];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [Utilities popUpAlertViewWithMsg:@"两次密码不一致" andTitle:@"注册失败" onView:self];
            }

        }else if (error.code == 200){
            [Utilities popUpAlertViewWithMsg:@"用户名为空" andTitle:@"注册失败" onView:self];
        }else if (error.code == 201){
            [Utilities popUpAlertViewWithMsg:@"密码为空" andTitle:@"注册失败" onView:self];
        }
        else if (error.code == 202){
            [Utilities popUpAlertViewWithMsg:@"用户名已经被占用" andTitle:@"注册失败" onView:self];
        } else if (error.code == 214){
            [Utilities popUpAlertViewWithMsg:@"手机号码已经被注册" andTitle:@"注册失败" onView:self];
        } else if (error.code == 218){
            [Utilities popUpAlertViewWithMsg:@"无效的密码，不允许空白密码" andTitle:@"注册失败" onView:self];
        } else if (error.code == 502){
            [Utilities popUpAlertViewWithMsg:@"服务器维护中" andTitle:@"注册失败" onView:self];
        }else{
            [Utilities popUpAlertViewWithMsg:@"请保持网络通畅" andTitle:@"注册失败" onView:self];
        }
        
    }];
//    if (userPhone && password && vc && cf) {
//        if ([password isEqualToString:cf]) {
//        AVUser *user = [AVUser user];
//        user.username = userPhone;
//        user.password = password;
//        user.mobilePhoneNumber = userPhone;
//        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (succeeded) {
////                [self performSegueWithIdentifier:@"fromSignUpToProducts" sender:nil];
//                [self.navigationController popViewControllerAnimated:YES];
//            } else {
//                NSLog(@"注册失败 %@", error);
//            }
//        }];
//        }else{
//            NSLog(@"两次密码不一致");
//        }
//    }
    
}
@end
