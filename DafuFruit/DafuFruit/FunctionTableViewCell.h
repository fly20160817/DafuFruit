//
//  FunctionTableViewCell.h
//  user
//
//  Created by 方冬雷 on 16/9/11.
//  Copyright © 2016年 fangdonglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *functionImgView;
@property (weak, nonatomic) IBOutlet UILabel *functionLbl;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLbl;

@end
