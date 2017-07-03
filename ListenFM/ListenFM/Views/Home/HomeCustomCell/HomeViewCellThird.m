//
//  HomeViewCellThird.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeViewCellThird.h"
#import "UIImageView+WebCache.h"

@implementation HomeViewCellThird
- (void)getModelForHomeViewCellThird:(H_cell_M *)cellM {
    [self.homeThirdCellImage sd_setImageWithURL:[NSURL URLWithString:cellM.image_url] placeholderImage:nil];
    self.homeThirdCellTitle.text = cellM.title;
    self.homeThirdCellSub_Title.text = cellM.sub_title;
}
@end
