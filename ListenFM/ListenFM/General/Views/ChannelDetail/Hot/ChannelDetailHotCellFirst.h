//
//  ChannelDetailHotCellFirst.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C_HotTwo_M;

@interface ChannelDetailHotCellFirst : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *channelDetailCellFirstImage;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailCellFirstTitle;
@property (strong, nonatomic) IBOutlet UILabel *channelDetailCellFirstContent_Num;
- (void)getModelForChannelDetailHotCellFirst:(C_HotTwo_M *)hotTwoM;
@end
