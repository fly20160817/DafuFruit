//
//  PersonTableViewCell.h
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end
