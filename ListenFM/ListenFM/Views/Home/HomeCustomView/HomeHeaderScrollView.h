//
//  HomeHeaderScrollView.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface HomeHeaderScrollView : UICollectionReusableView
@property (strong, nonatomic) SDCycleScrollView *scrollView;

- (void)getHeaderImages:(NSMutableArray *)images;

@end
