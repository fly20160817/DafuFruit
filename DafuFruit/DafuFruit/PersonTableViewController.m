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
#import "DetailViewController.h"
@interface PersonTableViewController ()


@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"尝鲜人";
    //去除多余的线
    self.tableView.tableFooterView = [[UIView alloc] init];
    //设置导航条背景色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65/255.0 green:227/255.0 blue:65/255.0 alpha:1];
    //取消导航栏毛玻璃特效
    self.navigationController.navigationBar.translucent = NO;
    
    //隐藏导航栏下面的线
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
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

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }else
        return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.view.frame.size.height / 5;
    }else
        return 45;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PeopleTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CellPeople" forIndexPath:indexPath];
        if([Utilities getUserDefaults:@"userName"]){
            
        
        AVQuery *query = [AVQuery queryWithClassName:@"_User"];
        [query getObjectInBackgroundWithId:@"5805d43b570c35006b7aa0a0" block:^(AVObject *object, NSError *error) {
            NSString *number = object[@"mobilePhoneNumber"];
            cell.mblLbl.text = number;
            NSString *nickName = object[@"username"];
            cell.nickNameLbl.text = nickName;
            NSNumber *score = object[@"score"];
            NSString *str = [NSString stringWithFormat:@"积分：%@",score ] ;
            cell.integralLbl.text = str;
            NSData *data = object[@"head"];
            UIImage *image =[[UIImage alloc]initWithData:data];
            cell.avanterImageView.image = image;
            // object 就是 id 为 558e20cbe4b060308e3eb36c 的 Todo 对象实例
            }];
        }
        //将头像按钮设置为圆形
        cell.avanterImageView.layer.cornerRadius = self.view.frame.size.height / 10 - 20;
        //给头像按钮添加一圈黑边
        cell.avanterImageView.layer.borderWidth = 1;//边框宽度1
        //将多余部分剪裁掉
        cell.avanterImageView.clipsToBounds = YES;
        return cell;
    }else{
        FunctionTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CellFunction" forIndexPath:indexPath];
        if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.functionImgView.image =[UIImage imageNamed:@"address"];
                cell.functionLbl.text = @"尝鲜人的地址";
                break;
            case 1:
                cell.functionImgView.image =[UIImage imageNamed:@"favorite"];
                cell.functionLbl.text = @"尝鲜人的收藏";
                break;
            case 2:
                cell.functionImgView.image =[UIImage imageNamed:@"评价"];
                cell.functionLbl.text = @"尝鲜人的评价";
                break;
                
            default:
                break;
            }
        }else if(indexPath.section == 2){
            switch (indexPath.row) {
                case 0:
                    cell.functionImgView.image =[UIImage imageNamed:@"提篮"];
                    cell.functionLbl.text = @"提篮换箩筐";
                    cell.subtitleLbl.text = @"鲜果0元购";
                    break;
                    
                default:
                    break;
            }

        }else
            switch (indexPath.row) {
                case 0:
                    cell.functionImgView.image =[UIImage imageNamed:@"常见问题"];
                    cell.functionLbl.text = @"常见问题";
                    break;
                case 1:
                    cell.functionImgView.image =[UIImage imageNamed:@"联系客服"];
                    cell.functionLbl.text = @"联系我们";
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
    //用户详细信息
    if (indexPath.section == 0){
        if([Utilities getUserDefaults:@"userName"]){
        DetailViewController *DVC = [[UIStoryboard storyboardWithName:@"FDL" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"Detail"];
            [self.navigationController pushViewController:DVC animated:YES];
        }else{
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Wjt" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"Longin"] animated:YES];
            
        }
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }else if (indexPath.section == 3){
        //联系我们
        if (indexPath.row == 1) {
            //该地址字符串将实现询问是否拨打某电话后再根据用户的选择去跳转到“电话”APP去直接拨打，或者用户取消拨打
            NSString *dialStr = [NSString stringWithFormat:@"telprompt://18861876277"];
            //将NSString转换成NSURL数据类型
            NSURL *dialUrl = [NSURL URLWithString:dialStr];
            //用openURL方法去执行上述链接的调用（在这里是通话功能的调用）
            [[UIApplication sharedApplication] openURL:dialUrl];
        }
    }
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
