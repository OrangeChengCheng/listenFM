//
//  RankForMusicHeader.h
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankForMusicHeader : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UIImageView *rank_Music_Image;
- (void)getModelForRankForMusicHeader:(NSString *)imageUrl;
@end
