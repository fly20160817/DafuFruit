//
//  ViewController.m
//  DafuFruit
//
//  Created by admin on 16/10/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVObject *testObject = [AVObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"bar" forKey:@"foo"];
    [testObject save];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
