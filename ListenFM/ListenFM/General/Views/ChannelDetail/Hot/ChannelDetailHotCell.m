//
//  ChannelDetailHotCell.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailHotCell.h"
#import "UIImageView+WebCache.h"

@implementation ChannelDetailHotCell
- (void)getModelForChannelDetailHotCell:(C_HotOne_M *)hotOneM {
    [self.channelDetailHotCellImage sd_setImageWithURL:[NSURL URLWithString:hotOneM.image_url] placeholderImage:nil];
    self.channelDetailHotCellTitle.text = hotOneM.title;
    self.channelDetailHotCellDescribe.text = hotOneM.describe;
    self.channelDetailHotCellComment_Num.text = hotOneM.comment_num;
    self.channelDetailHotCellConcern_Num.text = hotOneM.concern_num;
}

@end





