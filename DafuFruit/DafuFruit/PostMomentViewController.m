//
//  PostMomentViewController.m
//  MyFirstApp
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "PostMomentViewController.h"

@interface PostMomentViewController ()

@property (nonatomic, strong) UITextView * inputView;

@end

@implementation PostMomentViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setSingleLineTitle:@"评价"];
    

    [self setLeftNavigationButtonWithTitle:@"取消" target:self action:@selector(cancel)];
    
    [self setRightNavigationButtonWithTitle:@"确认" target:self action:@selector(saveMoment)];
    
    
    self.inputView = [[UITextView alloc] initWithFrame:CGRectMake(0, 84, [UIScreen mainScreen].bounds.size.width, 300)];
    
    self.inputView.delegate = self;
    
 
    self.inputView.editable = YES;
    
    [self.view addSubview:self.inputView];
    
  
    [self.inputView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cancel
{
   
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)saveMoment
{
    //如果没写任何内容，不让存储，且不需要给用户提示
    if ( self.inputView.text.length == 0 )
    {
        return;
    }
    
    //如果写的内容，文字超过了2000字，就告诉用户，超过了存储范围
    if ( self.inputView.text.length > 2000 )
    {
        //告知用户(弹窗)
        [self showAlertWithTitle:@"文字内容超过2000字无法存储" message:nil buttonText:@"知道了"];
        
        return;
    }
    
    
    [self showModalLoading];
    

    NSString * content = self.inputView.text;
    
   
    NSNumber * timestamp = [self timestamp];
    
  //  NSDictionary * dictionary = @{ @"content" : content, @"timestamp" : timestamp };
    

    
  
    [self hideModalLoading];
    
  
        
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        
    
    NSNotification * notification = [NSNotification notificationWithName:@"newMomentSaved" object:nil];
        
        //发通知
    [center postNotification:notification];
    
       
    [self dismissViewControllerAnimated:YES completion:nil];
        
    return;
    
    

    
}

- (NSNumber *) timestamp
{
    NSDate * now = [NSDate date];
    
    //时间戳，现在的时间到1970年的时间转换成秒（精确到毫秒）
    NSTimeInterval timestampValue = [now timeIntervalSince1970];
    
    NSNumber * timestamp = [NSNumber numberWithLongLong:timestampValue];
    
    return timestamp;
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
