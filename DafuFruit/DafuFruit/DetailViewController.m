//
//  DetailViewController.m
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "DetailViewController.h"
#import "FunctionTableViewCell.h"
@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate>
//@property (nonatomic,strong ) __block NSString *number;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.detailTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //将头像按钮设置为圆形
    _avanterImg.layer.cornerRadius = self.view.frame.size.width/6 ;
    //给头像按钮添加一圈黑边
    _avanterImg.layer.borderWidth = 1;//边框宽度1
    //将多余部分剪裁掉
    _avanterImg.clipsToBounds = YES;
    _detailTableView.dataSource = self;
    _detailTableView.delegate = self;
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    __block NSString *number;
    [query getObjectInBackgroundWithId:[Utilities getUserDefaults:@"userName"] block:^(AVObject *object, NSError *error) {
        number =object[@"mobilePhoneNumber"];
        NSString *nickName = object[@"username"];
        _nickNameLbl.text = nickName;
        NSData *data = object[@"head"];
        UIImage *image =[[UIImage alloc]initWithData:data];
        _avanterImg.image = image;
    }];
    NSLog(@"%@",number);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FunctionTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CellFunction" forIndexPath:indexPath];
    if (indexPath.section == 0) {
    if (indexPath.row == 0) {
        cell.functionLbl.text = @"手机";
        AVQuery *query = [AVQuery queryWithClassName:@"_User"];
        [query getObjectInBackgroundWithId:[Utilities getUserDefaults:@"userName"] block:^(AVObject *object, NSError *error) {
        cell.subtitleLbl.text =object[@"mobilePhoneNumber"];
        }];
    }else if (indexPath.row == 1) {
        cell.functionLbl.text = @"QQ";
        
    }else if (indexPath.row == 2) {
        cell.functionLbl.text = @"微信";
    }else if (indexPath.row == 3) {
        cell.functionLbl.text = @"微博";
    }
}else if (indexPath.section == 1)
    cell.functionLbl.text = @"退出登录";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];//让灰不会灰
    //退出登录
    if (indexPath.section == 1) {
        [Utilities removeUserDefaults:@"userName"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
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
