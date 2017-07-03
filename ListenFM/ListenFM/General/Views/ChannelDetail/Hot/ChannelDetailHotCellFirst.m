//
//  ChannelDetailHotCellFirst.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailHotCellFirst.h"
#import "UIImageView+WebCache.h"

@implementation ChannelDetailHotCellFirst
- (void)getModelForChannelDetailHotCellFirst:(C_HotTwo_M *)hotTwoM {
    [self.channelDetailCellFirstImage sd_setImageWithURL:[NSURL URLWithString:hotTwoM.image_url] placeholderImage:nil];
    self.channelDetailCellFirstTitle.text = hotTwoM.title;
    self.channelDetailCellFirstContent_Num.text = hotTwoM.content_num;
}
@end
