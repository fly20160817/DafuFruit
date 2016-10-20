//
//  DetailViewController.m
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "DetailViewController.h"
#import "FunctionTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
//#import <MessageUI/MessageUI.h>
@interface DetailViewController ()<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,strong ) __block NSString *number;
@property (strong, nonatomic)UIImagePickerController *imgPicker;//图片选择器
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //设置触摸次数
    tap.numberOfTapsRequired = 1;
    _avanterImg.userInteractionEnabled = YES;
    [_avanterImg addGestureRecognizer:tap];
    _detailTableView.dataSource = self;
    _detailTableView.delegate = self;
    AVQuery *query = [AVQuery queryWithClassName:@"_User"];
    __weak DetailViewController *weakself = self;
    [query getObjectInBackgroundWithId:[Utilities getUserDefaults:@"userName"] block:^(AVObject *object, NSError *error) {
        _number =object[@"mobilePhoneNumber"];
        NSString *nickName = object[@"username"];
        _nickNameLbl.text = nickName;
        NSData *data = object[@"head"];
        UIImage *image =[[UIImage alloc]initWithData:data];
        _avanterImg.image = image;
        [weakself.detailTableView reloadData];
    }];
    
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
        cell.subtitleLbl.text =_number;
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
        //初始化单例化的通知中心实例
        NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
        //创建一个通知：对所有对象（object:nil）广播发送一个名叫“UpdateProduct”（notificationWithName:@"UpdateProduct"）并且不带任何参数（userInfo:nil）的通知
        NSNotification *note = [NSNotification notificationWithName:@"reloadData" object:nil userInfo:nil];
        //在通知中心（广播台）发送（广播）上述通知
        //[noteCenter postNotification:note];
        //结合线程确保通知触发的操作在主线程上执行完成后再继续此处的下行流程
        [noteCenter performSelectorOnMainThread:@selector(postNotification:) withObject:note waitUntilDone:YES];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    NSLog(@"点");
    //创建从底部滑上来的提示框
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //UIImagePickerControllerSourceTypeCamera类型表示打开“拍照”APP
        [self pickImg:UIImagePickerControllerSourceTypeCamera];
    }];
    
    UIAlertAction *choosePhoto = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //UIImagePickerControllerSourceTypePhotoLibrary类型表示打开“相册”APP
        [self pickImg:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [actionSheet addAction:takePhoto];
    [actionSheet addAction:choosePhoto];
    [actionSheet addAction:cancel];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

//该方法专门处理用对应的方式打开“拍照”或“相册”APP去选择需要的照片
- (void)pickImg:(UIImagePickerControllerSourceType)sourceType {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        //神奇的nil
        _imgPicker = nil;
        //初始化一个图媒体选择控制器对象
        _imgPicker =[UIImagePickerController new];
        //签署协议
        _imgPicker.delegate = self;
        //设置类型（到底是打开“拍照”还是“相册”去让用户选择媒体文件）
        _imgPicker.sourceType = sourceType;
        //设置是否允许选择的媒体文件被编辑(图片是否允许剪裁)
        _imgPicker.allowsEditing = YES;
        //设置可以被选择的媒体文件的类型（只允许选照片）
        _imgPicker.mediaTypes = @[(NSString *)kUTTypeImage];
        [self presentViewController:_imgPicker animated:YES completion:nil];
    }else {
        //如果当前用户选择照片选择器类型不可用，我们需要弹出警告框告诉用户
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:sourceType == UIImagePickerControllerSourceTypeCamera ? @"您当前的设备不支持照相功能":@"您当前的设备无法打开相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * confirm =[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alertView addAction:confirm];
        [self presentViewController:alertView animated:YES completion:nil];
    }
}

//当用户选择完媒体文件后执行该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //根据UIImagePickerControllerEditedImage这个键去拿到用户选中的并且已经编辑（裁剪）过的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image) {
        //将上图设置被按钮的背景图
        _avanterImg.image = image;
    }
    //将媒体选择器手动收回
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
