//
//  HomeViewCellSecond.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeViewCellSecond.h"
#import "UIImageView+WebCache.h"

@implementation HomeViewCellSecond
- (void)getModelForHomeViewCellSecond:(H_cell_M *)cellM {
    [self.homeSecondCellImage sd_setImageWithURL:[NSURL URLWithString:cellM.image_url] placeholderImage:nil];
    self.homeSecondCellTitle.text = cellM.title;
    self.homeSecondCellSub_Title.text = cellM.sub_title;
}
@end
