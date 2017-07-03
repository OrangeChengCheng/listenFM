//
//  ChannelDetailHotCell.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C_HotOne_M;

@interface ChannelDetailHotCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *channelDetailHotCellImage;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailHotCellTitle;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailHotCellDescribe;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailHotCellComment_Num;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailHotCellConcern_Num;
- (void)getModelForChannelDetailHotCell:(C_HotOne_M *)hotOneM;
@end
