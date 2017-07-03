//
//  ChannelDetailNewAddCell.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailNewAddCell.h"
#import "UIImageView+WebCache.h"


@implementation ChannelDetailNewAddCell
- (void)getMedolForChannelDetailNewAddCell:(C_NewAdd_M *)newAddM {
    [self.channelDetailNewAddCellImage sd_setImageWithURL:[NSURL URLWithString:newAddM.image_url] placeholderImage:nil];
    self.channelDetailNewAddCellTitle.text = newAddM.title;
    self.channelDetailNewAddCellCreated.text = [NSString stringWithFormat:@"上架时间：%@", newAddM.created];
}
@end
