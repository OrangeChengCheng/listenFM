//
//  ChannelDetailRankCell.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C_Rank_M;

@interface ChannelDetailRankCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *channelDetailRankCellTitle;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailRankCellPlay_Num;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailRankTop_Num;

@property (assign, nonatomic) BOOL isCell; // 判断是不是同一个cell

- (void)getModelForChannelDetailRankCell:(C_Rank_M *)rankM withIndexPath:(NSIndexPath *)indexPath;
@end
