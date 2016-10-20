//
//  OrderLoginAfterwardTableViewCell.h
//  DafuFruit
//
//  Created by admin on 16/10/18.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderLoginAfterwardTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Image;

@property (weak, nonatomic) IBOutlet UILabel *fruitName;

@property (weak, nonatomic) IBOutlet UILabel *OrderDetails;

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;


- (IBAction)judgeBtn:(UIButton *)sender forEvent:(UIEvent *)event;

@end
