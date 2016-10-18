//
//  OrderLoginAfterwardViewController.m
//  DafuFruit
//
//  Created by admin on 16/10/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "OrderLoginAfterwardViewController.h"
#import "OrderLoginAfterwardsTableViewCell.h"

@interface OrderLoginAfterwardViewController ()


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OrderLoginAfterwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"果单";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65/255.0 green:227/255.0 blue:65/255.0 alpha:1];
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


//行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


//处理每个细胞显示的具体内容
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderLoginAfterwardsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Order" forIndexPath:indexPath];
    
    return cell;
    
}

@end
