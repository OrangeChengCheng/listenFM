//
//  ShowDownloadVC.h
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_cell_M;
@class H_More_ZT_M;
@class H_More_RMBK_M;
@class C_HotTwo_M;
@class C_NewAdd_M;
@class H_More_MAX_M;

@interface ShowDownloadVC : UICollectionViewController
@property (strong, nonatomic) H_cell_M *cellM;
@property (strong, nonatomic) H_More_ZT_M *moreZTM;
@property (strong, nonatomic) H_More_RMBK_M *moreRMBKM;
@property (strong, nonatomic) C_HotTwo_M *hotTwoM;
@property (strong, nonatomic) C_NewAdd_M *AddM;
@property (strong, nonatomic) H_More_MAX_M *maxM;

@end
