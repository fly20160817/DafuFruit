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


@end

@implementation RegironViewController
{
    DGTimerButton *bu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    [bu setFrame:CGRectMake(292, 275, 76, 31)];
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

-(void)beginTimer{
    [bu beginTimers];
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

- (IBAction)remain:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
