//
//  ActivityTableViewCell.h
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/23.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *changyikouImg;
@property (weak, nonatomic) IBOutlet UILabel *changyikouLbl;
@property (weak, nonatomic) IBOutlet UILabel *xianshicuxiaoLbl;
@property (weak, nonatomic) IBOutlet UILabel *jingpintuijianLbl;
@property (weak, nonatomic) IBOutlet UILabel *huitoukeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *jingpintuijianImg;
@property (weak, nonatomic) IBOutlet UIImageView *xianshicuxiaoImg;
@property (weak, nonatomic) IBOutlet UIImageView *huitoukeImg;

@end
