//
//  HomeTableViewController.m
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/12.
//  Copyright © 2016 年 admin. All rights reserved.
//

#import "HomeTableViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface HomeTableViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;//定位器
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self locationConfiguration];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//处理CoreLocation相关操作
- (void)locationConfiguration {
    //初始化CLLocation这个框架（sdk）的基本类——位置管理器
    _locationManager = [CLLocationManager new];
    //签协议
    _locationManager.delegate = self;
    //设置每移动多少距离可以被识别(kCLDistanceFilterNone表示0，意思是只要移动就能被识别，施展卫星的最大能力去识别)
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置把地球分割的精度，分割为边长是多少的小方块(kCLLocationAccuracyBest表示最佳精度，也就是卫星能分割到的最小方块)
    _locationManager.desiredAccuracy =kCLLocationAccuracyBest;
    //一下代码表示设置提醒用户是否启用定位
    //判断用户有没有决定过要不要使用定位，如果没决定过才执行提醒打开定位的功能
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) {
        //判断当前运行该工程的设备的系统版本号是否为iOS8.0或以上
#ifdef __IPHONE_8_0
        //询问用户是否需要打开定位功能（requestWhenInUseAuthorization表示只有当APP运行过程中才可以使用定位能力；requestAlwaysAuthorization表示只要安装着这款APP那么这个APP在任何情况下都可以使用定位能力）
        [_locationManager requestWhenInUseAuthorization];
        //[locMgr requestAlwaysAuthorization];
#endif
    }
    //将定位器开关打开
    [_locationManager startUpdatingLocation];
}


//当设备获取位置失败时调用该方法
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    //当出现定位方面的错误异常时，一定要对每一种可能的异常情况进行完整的逻辑操作（不能只考虑正常情况下所需要的逻辑）
    if (error) {
        //判断错误码对应的错误原因
        [self checkError:error];
    }
}

//当设备的位置发生变化时执行该方法（刚打开定位时也会执行一次）（如果距离识别的精度属性设置为最佳精度0时，该方法也会每秒执行一次）
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    //当新老位置不同时，我们需要持续更新坐标以拿到更精准的设备位置
    if (newLocation.coordinate.latitude!=oldLocation.coordinate.latitude ||newLocation.coordinate.longitude != oldLocation.coordinate.longitude) {
        NSLog(@"CLLocation纬度%f",newLocation.coordinate.latitude);
        NSLog(@"CLLocation纬度%f",newLocation.coordinate.longitude);
        
    }else {
        //将定位器的开关关闭
        //[_locMgr stopUpdatingLocation];
        //过一段时间再将定位器关闭（隔一段时间再执行某方法）
        //[_locMgr performSelector:@selector(stopUpdatingLocation) withObject:nil afterDelay:3.f];
        //创建一个表示时间间隔的dispatch_time_t对象，第一个参数表示从什么时候开始（DISPATCH_TIME_NOW就表示从现在开始）第二个参数表示隔多少时间，（NSEC_PER_SEC表示秒数）
        dispatch_time_t time =dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC);
        //经过上述时间间隔后去执行某些操作
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [_locationManager stopUpdatingLocation];
            [self getCoordinateDescription:newLocation];
        });
    }
}

//将提取错误的方法专门提取出来
-(void)checkError:(NSError *)error
{
    //
    
    switch (error.code) {
        case kCLErrorNetwork:
            NSLog(@"没网");
            break;
        case kCLErrorDenied:
            NSLog(@"没开定位");
            break;
        case kCLErrorLocationUnknown:
            NSLog(@"荒山野岭定位不到");
            break;
        default:
            NSLog(@"其他");
            break;
    }
}


    //专门处理逆地理编码相关操作（这里是BLOCK对声明方式——创建Block甲方的方式）（看看看）
- (void)getCoordinateDescription:(CLLocation *)location{
    //初始化一个地理编码器
    CLGeocoder *geoCoder = [CLGeocoder new];
    //依靠地理编码器执行逆地理编码方法（反向地理编码：根据经纬度坐标获取该坐标对应的地址相关的文字信息）
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //检查有没有错误
        if (error) {
            NSLog(@"拿不到坐标对应的地址，原因%@",error.description);
        }else {
            //获取逆地理编码成功或得到的信息中与地址有关的字典
            NSDictionary *info = [placemarks.firstObject addressDictionary];
            NSLog(@"%@",info);
        }
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
