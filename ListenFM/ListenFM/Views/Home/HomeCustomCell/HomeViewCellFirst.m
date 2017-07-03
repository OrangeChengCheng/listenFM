//
//  HomeViewCellFirst.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeViewCellFirst.h"
#import "UIImageView+WebCache.h"

@implementation HomeViewCellFirst

- (void)getModelForHomeViewCellFirst:(H_cell_M *)cellM {
    [self.homeFirstCellImage sd_setImageWithURL:[NSURL URLWithString:cellM.image_url] placeholderImage:nil];
    self.homeFirstCellTitle.text = cellM.title;
    self.homeFirstCellSub_Title.text = cellM.sub_title;
}
@end
