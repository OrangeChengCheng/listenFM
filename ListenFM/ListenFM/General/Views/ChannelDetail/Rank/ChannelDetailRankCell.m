//
//  ChannelDetailRankCell.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailRankCell.h"

@implementation ChannelDetailRankCell
- (void)getModelForChannelDetailRankCell:(C_Rank_M *)rankM withIndexPath:(NSIndexPath *)indexPath {
    self.isCell = rankM.isValue;
    
    self.channelDetailRankCellTitle.text = rankM.title;
    self.channelDetailRankCellPlay_Num.text = rankM.play_num;
    self.channelDetailRankTop_Num.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    if (self.isCell == YES) {
        if ([self.channelDetailRankTop_Num.text isEqualToString:@"1"]) {
            self.channelDetailRankTop_Num.backgroundColor = [UIColor colorWithRed:233 / 255.0 green:108 / 255.0 blue:106 / 255.0 alpha:1.0];
            self.channelDetailRankTop_Num.font = [UIFont systemFontOfSize:24];
        }
        if ([self.channelDetailRankTop_Num.text isEqualToString:@"2"]) {
            self.channelDetailRankTop_Num.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:166 / 255.0 blue:100 / 255.0 alpha:1.0];
            self.channelDetailRankTop_Num.font = [UIFont systemFontOfSize:24];
        }
        if ([self.channelDetailRankTop_Num.text isEqualToString:@"3"]) {
            self.channelDetailRankTop_Num.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:201 / 255.0 blue:104 / 255.0 alpha:1.0];
            self.channelDetailRankTop_Num.font = [UIFont systemFontOfSize:24];
        }
    }
}
@end
