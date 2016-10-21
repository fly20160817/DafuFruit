//
//  DetailViewController.h
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/19.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *avanterImg;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@end
