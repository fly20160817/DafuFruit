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
@property (strong, nonatomic) UIView * modal;

@end

@implementation OrderLoginAfterwardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"果单";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65/255.0 green:227/255.0 blue:65/255.0 alpha:1];
    
    
    [self showModalLoading];
    
    [self performSelector:@selector(hideModalLoading) withObject:nil afterDelay:2];
    
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//让灰不灰
}



- (void)showModalLoading
{
    if ( _modal == nil )
    {
        _modal = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _modal.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    
    
    UIView * black = [[UIView alloc] initWithFrame:CGRectMake( ([UIScreen mainScreen].bounds.size.width - 80) / 2, ([UIScreen mainScreen].bounds.size.height - 80) / 2, 80, 80)];
    
    black.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    black.layer.cornerRadius = 12;
    black.layer.masksToBounds = YES;
    [_modal addSubview:black];
    
    
    UIActivityIndicatorView * modalLoading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 80) / 2, ([UIScreen mainScreen].bounds.size.height - 80) / 2, 80, 80)];
    
    modalLoading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    [modalLoading startAnimating];
    
    [_modal addSubview:modalLoading];
    
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    
    [window addSubview:_modal];
}



- (void)hideModalLoading
{
    [_modal removeFromSuperview];
}


@end
