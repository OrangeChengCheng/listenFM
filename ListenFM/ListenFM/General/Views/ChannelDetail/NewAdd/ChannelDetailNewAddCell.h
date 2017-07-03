//
//  ChannelDetailNewAddCell.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C_NewAdd_M;

@interface ChannelDetailNewAddCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *channelDetailNewAddCellImage;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailNewAddCellTitle;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailNewAddCellCreated;
- (void)getMedolForChannelDetailNewAddCell:(C_NewAdd_M *)newAddM;
@end
