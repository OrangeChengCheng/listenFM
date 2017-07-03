//
//  RankForNetCell.h
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C_Listen_M;
@interface RankForNetCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *rank_Net_TopNum;
@property (strong, nonatomic) IBOutlet UILabel *rank_Net_Title;
@property (strong, nonatomic) IBOutlet UILabel *rank_Net_Singer;
@property (strong, nonatomic) IBOutlet UIImageView *rank_Net_SingerImage;

@property (assign, nonatomic) BOOL isCell; // 判断是不是同一个cell
- (void)getModelForRankForNetCell:(C_Listen_M *)listenM withIndexPath:(NSIndexPath *)indexPath;
@end
