//
//  HomeViewController.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ShowViewController.h"

@interface HomeViewController : ShowViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *homeCollectionView;

@end
