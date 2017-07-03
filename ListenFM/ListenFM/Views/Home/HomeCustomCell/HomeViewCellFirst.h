//
//  HomeViewCellFirst.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_cell_M;

@interface HomeViewCellFirst : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeFirstCellImage;

@property (strong, nonatomic) IBOutlet UILabel *homeFirstCellTitle;

@property (strong, nonatomic) IBOutlet UILabel *homeFirstCellSub_Title;

- (void)getModelForHomeViewCellFirst:(H_cell_M *)cellM;

@end
