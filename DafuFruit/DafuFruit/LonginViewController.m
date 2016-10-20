//
//  LonginViewController.m
//  DafuFruit
//
//  Created by admin on 16/10/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "LonginViewController.h"

@interface LonginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *psd;

- (IBAction)regionOne:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)longIn:(UIButton *)sender forEvent:(UIEvent *)event;

- (IBAction)forgotPsd:(UIButton *)sender forEvent:(UIEvent *)event;

@end

@implementation LonginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)regionOne:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)longIn:(UIButton *)sender forEvent:(UIEvent *)event {
}

- (IBAction)forgotPsd:(UIButton *)sender forEvent:(UIEvent *)event {
}
@end
