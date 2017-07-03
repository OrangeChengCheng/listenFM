//
//  RankForOiginalHeader.h
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankForOiginalHeader : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UIImageView *rank_Oiginal_Image;
- (void)getModelForRankForOiginalHeader:(NSString *)imageUrl;
@end
