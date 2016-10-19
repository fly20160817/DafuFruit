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
    self.tabBar.tintColor = [UIColor colorWithRed:65/255.0 green:227/255.0 blue:65/255.0 alpha:1];
    UINavigationController *HomeNC = [[UINavigationController alloc]initWithRootViewController:[[UIStoryboard storyboardWithName:@"FDL" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"Home"] ];
    HomeNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"滴滴鲜" image:[UIImage imageNamed:@"lemon"] tag:0];
    UINavigationController *PersonNC = [[UINavigationController alloc]initWithRootViewController:[[UIStoryboard storyboardWithName:@"FDL" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"Person"] ];
    PersonNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"尝鲜人" image:[UIImage imageNamed:@"person"] tag:0];
    
    UINavigationController *OBLNC = [[UINavigationController alloc]initWithRootViewController:[[UIStoryboard storyboardWithName:@"LFOrderLoginAfterward" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"LFOrderLoginAfter"] ];
    OBLNC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"果单" image:[UIImage imageNamed:@"订单Bar"] tag:0];

    self.viewControllers = @[HomeNC, OBLNC, PersonNC];

    //test
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
