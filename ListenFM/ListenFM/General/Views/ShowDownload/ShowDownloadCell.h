//
//  ShowDownloadCell.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class D_show_M;

@interface ShowDownloadCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *showDownloadCellPlay_Num;
@property (strong, nonatomic) IBOutlet UILabel *showDownloadCellTitle;
@property (strong, nonatomic) IBOutlet UILabel *showDownloadCellDuration;
- (void)getModelForShowDownloadCell:(D_show_M *)showM;

@end
