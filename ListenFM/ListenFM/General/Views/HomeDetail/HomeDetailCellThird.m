//
//  HomeDetailCellThird.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeDetailCellThird.h"
#import "UIImageView+WebCache.h"

@implementation HomeDetailCellThird
- (void)getModelForHomeDetailCellThird:(H_More_RMBK_M *)moreRMBKM {
    [self.homeDetailCellThirdImage sd_setImageWithURL:[NSURL URLWithString:moreRMBKM.image_url] placeholderImage:nil];
    NSString *str = moreRMBKM.play_num;
    NSInteger num = str.integerValue;
    self.homeDetailCellThirdTitle.text = moreRMBKM.title;
    self.homeDetailCellThirdDescribe.text = moreRMBKM.describe;
    self.homeDetailCellThirdPlay_Num.text = [NSString stringWithFormat:@"%ld万次播放", num / 10000];
}
@end
