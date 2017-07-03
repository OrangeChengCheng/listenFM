//
//  RankForNetHeader.m
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "RankForNetHeader.h"
#import "UIImageView+WebCache.h"

@implementation RankForNetHeader
- (void)getModelForRankForNetHeader:(NSString *)imageUrl {
    [self.rank_Net_Image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
}
@end
