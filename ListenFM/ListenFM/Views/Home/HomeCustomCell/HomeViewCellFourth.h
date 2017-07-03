//
//  HomeViewCellFourth.h
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_cell_M;
@interface HomeViewCellFourth : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeCellFourthImage;
@property (strong, nonatomic) IBOutlet UILabel *homeCellFourthSub_Title;
@property (strong, nonatomic) IBOutlet UILabel *homeCellFourthTtile;
- (void)getModelForHomeViewCellFourth:(H_cell_M *)cellM;
@end
