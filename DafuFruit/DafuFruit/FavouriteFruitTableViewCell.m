//
//  FavouriteFruitTableViewCell.m
//  DafuFruit
//
//  Created by 方冬雷 on 16/10/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "FavouriteFruitTableViewCell.h"

@implementation FavouriteFruitTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)favouriteBtn:(UIButton *)sender forEvent:(UIEvent *)event {
    if (_delegate && [_delegate respondsToSelector:@selector(favorit:)] && _indexPath) {
        [_delegate favorit:_indexPath];
    }
}
@end
