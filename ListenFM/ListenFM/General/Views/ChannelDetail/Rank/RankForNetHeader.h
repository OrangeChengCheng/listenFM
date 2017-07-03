//
//  RankForNetHeader.h
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankForNetHeader : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UIImageView *rank_Net_Image;
- (void)getModelForRankForNetHeader:(NSString *)imageUrl;
@end
