//
//  HomeViewCellSecond.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@class H_cell_M;

@interface HomeViewCellSecond : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeSecondCellImage;
@property (strong, nonatomic) IBOutlet UILabel *homeSecondCellTitle;
@property (strong, nonatomic) IBOutlet UILabel *homeSecondCellSub_Title;

- (void)getModelForHomeViewCellSecond:(H_cell_M *)cellM;

@end
