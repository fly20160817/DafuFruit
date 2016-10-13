//
//  HomeTableViewController.m
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HomeTableViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface HomeTableViewController ()<CLLocationManagerDelegate>{
    CLLocation *location;
    NSInteger locVisit;
    NSInteger page;
    NSInteger perPage;
    NSInteger totalPage;
    BOOL loading;

}
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //获取用户系统版本号
    [self getUserLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationConfiguration {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (void)getUserLocation {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
#ifdef __IPHONE_8_0
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager performSelector:@selector(requestWhenInUseAuthorization)];
        }
#endif
    }
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"error = %@", [error description]);
    if (error) {
        [self checkError:error];
    }
}

- (void)checkError:(NSError *)error {
    switch([error code]) {
        case kCLErrorNetwork:
            [Utilities popUpAlertViewWithMsg:NSLocalizedString(@"NetworkError", nil) andTitle:nil onView:self];
            break;
        case kCLErrorDenied:
            [Utilities popUpAlertViewWithMsg:NSLocalizedString(@"GPSDisabled", nil) andTitle:nil onView:self];
            break;
        case kCLErrorLocationUnknown:
            [Utilities popUpAlertViewWithMsg:NSLocalizedString(@"LocationUnkonw", nil) andTitle:nil onView:self];
            break;
        default:
            [Utilities popUpAlertViewWithMsg:NSLocalizedString(@"SystemError", nil) andTitle:nil onView:self];
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    location = newLocation;
    if (locVisit == 0) {
        [self searchReGeocodeWithCoordinate];
        locVisit ++;
    }
}

- (void)searchReGeocodeWithCoordinate {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [Utilities setUserDefaults:@"UserLatitude" content:[NSString stringWithFormat:@"%f", location.coordinate.latitude]];
        [Utilities setUserDefaults:@"UserLongitude" content:[NSString stringWithFormat:@"%f", location.coordinate.longitude]];
        
        CLGeocoder *revGeo = [[CLGeocoder alloc] init];
        [revGeo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
            if (!error && placemarks.count > 0) {
                NSDictionary *info = [[placemarks objectAtIndex:0] addressDictionary];
                NSLog(@"info = %@", info);
                NSString *cityStr = info[@"City"];
                cityStr = [cityStr substringToIndex:(cityStr.length - 1)];
                [Utilities setUserDefaults:@"UserCity" content:cityStr];
                //[self networkRequest];
            } else {
                NSLog(@"error = %@", [error description]);
            }
        }];
        [_locationManager stopUpdatingLocation];
    });
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
