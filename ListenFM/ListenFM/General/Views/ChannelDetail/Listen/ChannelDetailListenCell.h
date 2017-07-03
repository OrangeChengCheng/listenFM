//
//  ChannelDetailListenCell.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C_Listen_M;

@interface ChannelDetailListenCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *channelDetailListenCellUser_Image;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailListenCellUser_Name;
@property (strong, nonatomic) IBOutlet UIImageView *channelDetailListenCellImage;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailListenCellContent_Title;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailListenCellTitle;
- (void)getModelForChannelDetailListenCell:(C_Listen_M *)listenM;
@end
