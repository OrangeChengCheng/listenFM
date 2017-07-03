//
//  HomeDetailCellThird.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_More_RMBK_M;

@interface HomeDetailCellThird : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeDetailCellThirdImage;
@property (strong, nonatomic) IBOutlet UILabel *homeDetailCellThirdTitle;
@property (strong, nonatomic) IBOutlet UILabel *homeDetailCellThirdDescribe;
@property (strong, nonatomic) IBOutlet UILabel *homeDetailCellThirdPlay_Num;
- (void)getModelForHomeDetailCellThird:(H_More_RMBK_M *)moreRMBKM;
@end
