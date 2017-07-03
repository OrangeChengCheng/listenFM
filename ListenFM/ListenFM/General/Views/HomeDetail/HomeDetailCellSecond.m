//
//  HomeDetailCellSecond.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeDetailCellSecond.h"
#import "UIImageView+WebCache.h"

@implementation HomeDetailCellSecond
- (void)getModelForHomeDetailCellSecond:(H_More_ZT_M *)moreZTM {
    [self.homeDetailCellSecondImage sd_setImageWithURL:[NSURL URLWithString:moreZTM.image_url] placeholderImage:nil];
    self.homeDetailCellSecondTitle.text = moreZTM.title;
    self.homeDetailCellSecondSub_Title.text = moreZTM.sub_title;
}
@end
