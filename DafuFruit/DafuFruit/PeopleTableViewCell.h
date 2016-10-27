//
//  PeopleTableViewCell.h
//  user
//
//  Created by 方冬雷 on 16/9/11.
//  Copyright © 2016年 fangdonglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avanterImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *mblLbl;
@property (weak, nonatomic) IBOutlet UILabel *integralLbl;

@end
