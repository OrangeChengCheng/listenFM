//
//  RankForMusicHeader.m
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "RankForMusicHeader.h"
#import "UIImageView+WebCache.h"

@implementation RankForMusicHeader
- (void)getModelForRankForMusicHeader:(NSString *)imageUrl {
    [self.rank_Music_Image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}
@end
