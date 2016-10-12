//
//  RegironViewController.m
//  DafuFruit
//
//  Created by admin on 16/10/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RegironViewController.h"

@interface RegironViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RegironViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
