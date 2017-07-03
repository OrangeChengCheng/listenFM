//
//  RankForOiginalCell.m
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "RankForOiginalCell.h"
#import "UIImageView+WebCache.h"

@implementation RankForOiginalCell
- (void)getModelForRankForOiginalCell:(C_Listen_M *)listenM withIndexPath:(NSIndexPath *)indexPath {
    self.isCell = listenM.isValue;
    [self.rangk_Oiginal_SingerImage sd_setImageWithURL:[NSURL URLWithString:listenM.singerImg] placeholderImage:nil];
    self.rank_Oiginal_Title.text = listenM.title;
    self.rank_Oiginal_Singer.text = listenM.singer;
    self.rank_Oiginal_TopNum.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    if (self.isCell == YES) {
        if ([self.rank_Oiginal_TopNum.text isEqualToString:@"1"]) {
            self.rank_Oiginal_TopNum.backgroundColor = [UIColor colorWithRed:233 / 255.0 green:108 / 255.0 blue:106 / 255.0 alpha:1.0];
            self.rank_Oiginal_TopNum.font = [UIFont systemFontOfSize:45];
        }
        if ([self.rank_Oiginal_TopNum.text isEqualToString:@"2"]) {
            self.rank_Oiginal_TopNum.backgroundColor = [UIColor colorWithRed:238 / 255.0 green:166 / 255.0 blue:100 / 255.0 alpha:1.0];
            self.rank_Oiginal_TopNum.font = [UIFont systemFontOfSize:37];
        }
        if ([self.rank_Oiginal_TopNum.text isEqualToString:@"3"]) {
            self.rank_Oiginal_TopNum.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:201 / 255.0 blue:104 / 255.0 alpha:1.0];
            self.rank_Oiginal_TopNum.font = [UIFont systemFontOfSize:30];
        }
    }
}




@end
