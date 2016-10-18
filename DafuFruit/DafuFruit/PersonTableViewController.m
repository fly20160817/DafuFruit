//
//  PersonTableViewController.m
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "PersonTableViewController.h"
#import "PeopleTableViewCell.h"
#import "FunctionTableViewCell.h"
@interface PersonTableViewController ()


@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"尝鲜人";
    //去除多余的线
    self.tableView.tableFooterView = [[UIView alloc] init];
    //隐藏导航栏下面的线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //设置导航条背景色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65/255.0 green:227/255.0 blue:65/255.0 alpha:1];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.frame.size.height / 5;
    }else
        return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PeopleTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CellPeople" forIndexPath:indexPath];
        return cell;
    }else {
        FunctionTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CellFunction" forIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
                cell.functionImgView.image =[UIImage imageNamed:@"address"];
                cell.functionLbl.text = @"尝鲜人的地址";
                break;
            case 1:
                cell.functionLbl.text = @"尝鲜人的收藏";
                break;
            case 2:
                cell.functionLbl.text = @"尝鲜人的评价";
                break;
                
            default:
                break;
        }
        return cell;
    }

}

//摸了后做的事情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//让灰不会灰
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
