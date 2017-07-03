//
//  HomeDetailCellFirst.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_More_MAX_M;

@interface HomeDetailCellFirst : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *homeDetailCellFirstImage;
@property (strong, nonatomic) IBOutlet UILabel *homeDetailCellFirstSub_Title;
@property (strong, nonatomic) IBOutlet UILabel *homeDetailCellFirstTitle;
- (void)getModelForHomeDetailCellFirst:(H_More_MAX_M *)moreMaxM;
@end
