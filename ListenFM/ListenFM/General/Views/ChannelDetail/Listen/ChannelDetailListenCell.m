//
//  ChannelDetailListenCell.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailListenCell.h"
#import "UIImageView+WebCache.h"

@implementation ChannelDetailListenCell
- (void)getModelForChannelDetailListenCell:(C_Listen_M *)listenM {
    [self.channelDetailListenCellImage sd_setImageWithURL:[NSURL URLWithString:listenM.image_url] placeholderImage:nil];
    [self.channelDetailListenCellUser_Image sd_setImageWithURL:[NSURL URLWithString:listenM.user_image_url] placeholderImage:nil];
    self.channelDetailListenCellUser_Name.text = listenM.user_name;
    self.channelDetailListenCellTitle.text = listenM.title;
    self.channelDetailListenCellContent_Title.text = listenM.contentTitle;
}
@end
