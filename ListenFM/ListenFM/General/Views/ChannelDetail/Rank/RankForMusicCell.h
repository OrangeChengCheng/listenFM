//
//  RankForMusicCell.h
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class C_Listen_M;
@interface RankForMusicCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *rank_Music_TopNum;
@property (strong, nonatomic) IBOutlet UILabel *rank_Music_Title;
@property (strong, nonatomic) IBOutlet UILabel *rank_Music_Singer;
@property (strong, nonatomic) IBOutlet UIImageView *rank_Music_SingerImage;
@property (assign, nonatomic) BOOL isCell; // 判断是不是同一个cell

- (void)getModelForRankForMusicCell:(C_Listen_M *)listenM withIndexPath:(NSIndexPath *)indexPath;
@end
