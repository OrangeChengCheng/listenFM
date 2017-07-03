//
//  ShowDownloadCell.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ShowDownloadCell.h"

@implementation ShowDownloadCell
- (void)getModelForShowDownloadCell:(D_show_M *)showM {
    self.showDownloadCellTitle.text = showM.title;
    self.showDownloadCellPlay_Num.text = showM.play_num;
    self.showDownloadCellDuration.text = showM.duration;
}
@end
