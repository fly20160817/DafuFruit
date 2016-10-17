//
//  TabViewController.m
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/14.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationController *HomeNC = [[UINavigationController alloc]initWithRootViewController:[[UIStoryboard storyboardWithName:@"FDL" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"Home"] ];
    HomeNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"滴滴鲜" image:[UIImage imageNamed:@"apple"] tag:0];
    self.viewControllers = @[HomeNC];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
