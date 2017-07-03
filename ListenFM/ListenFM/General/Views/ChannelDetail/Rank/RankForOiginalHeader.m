//
//  RankForOiginalHeader.m
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "RankForOiginalHeader.h"
#import "UIImageView+WebCache.h"

@implementation RankForOiginalHeader
- (void)getModelForRankForOiginalHeader:(NSString *)imageUrl {
    [self.rank_Oiginal_Image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}
@end
