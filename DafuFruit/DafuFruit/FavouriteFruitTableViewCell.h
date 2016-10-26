//
//  FavouriteFruitTableViewCell.h
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

//第一步声明协议
@protocol FavouriteTableViewCellDelegate <NSObject>

@required

- (void) favorit:(NSIndexPath *)indexPath;

@end


@interface FavouriteFruitTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fruitImg;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *fruitNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UILabel *quantifierLbl;
- (IBAction)favouriteBtn:(UIButton *)sender forEvent:(UIEvent *)event;

//申明一个属性去表示当前实例化的细胞的组号与行号
@property (strong, nonatomic) NSIndexPath * indexPath;

//第二步：实例化ActivityTableViewCellDelegate协议
@property(weak, nonatomic) id<FavouriteTableViewCellDelegate> delegate;
@end
