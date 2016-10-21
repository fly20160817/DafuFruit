//
//  RegironViewController.m
//  DafuFruit
//
//  Created by admin on 16/10/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RegironViewController.h"
#import "DGTimerButton.h"
@interface RegironViewController ()<UITableViewDataSource,UITableViewDelegate>
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


- (IBAction)carry:(UIButton *)sender forEvent:(UIEvent *)event {
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:_userPhone.text smsCode:_VerificationCode.text block:^(AVUser *user, NSError *error) {
        if ([_psWord.text isEqualToString:_confirm.text]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            NSLog(@"密码错误");
        }
        NSLog(@"%@",error);
    }];
    
}
@end
