//
//  HomeDetailCellSecond.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_More_ZT_M;

@interface HomeDetailCellSecond : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeDetailCellSecondImage;
@property (strong, nonatomic) IBOutlet UILabel *homeDetailCellSecondSub_Title;
@property (strong, nonatomic) IBOutlet UILabel *homeDetailCellSecondTitle;
- (void)getModelForHomeDetailCellSecond:(H_More_ZT_M *)moreZTM;
@end
