//
//  TempPlayerTVC.h
//  ListenFM
//
//  Created by lanouhn on 16/3/24.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_cell_M;

@interface TempPlayerTVC : UITableViewController
@property (strong, nonatomic) H_cell_M *cellM;
@property (copy, nonatomic) NSString *item;

@end
