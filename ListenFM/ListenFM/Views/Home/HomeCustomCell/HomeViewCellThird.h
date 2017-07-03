//
//  HomeViewCellThird.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_cell_M;

@interface HomeViewCellThird : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeThirdCellImage;
@property (strong, nonatomic) IBOutlet UILabel *homeThirdCellTitle;
@property (strong, nonatomic) IBOutlet UILabel *homeThirdCellSub_Title;

- (void)getModelForHomeViewCellThird:(H_cell_M *)cellM;
@end
