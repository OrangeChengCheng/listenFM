//
//  HomeDetailCellFirst.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeDetailCellFirst.h"
#import "UIImageView+WebCache.h"

@implementation HomeDetailCellFirst
- (void)getModelForHomeDetailCellFirst:(H_More_MAX_M *)moreMaxM {
    [self.homeDetailCellFirstImage sd_setImageWithURL:[NSURL URLWithString:moreMaxM.image_url] placeholderImage:nil];
    self.homeDetailCellFirstTitle.text = moreMaxM.title;
    if (moreMaxM.sub_title != nil) {;
        self.homeDetailCellFirstSub_Title.text = moreMaxM.sub_title;
    }else {
        self.homeDetailCellFirstSub_Title.text = moreMaxM.describe;
    }
}
@end
