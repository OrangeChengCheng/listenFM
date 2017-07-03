//
//  HomeViewCellFourth.m
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeViewCellFourth.h"
#import "UIImageView+WebCache.h"

@implementation HomeViewCellFourth
- (void)getModelForHomeViewCellFourth:(H_cell_M *)cellM {
    [self.homeCellFourthImage sd_setImageWithURL:[NSURL URLWithString:cellM.image_url] placeholderImage:nil];
    self.homeCellFourthTtile.text = cellM.title;
    self.homeCellFourthSub_Title.text = cellM.sub_title;
}
@end
