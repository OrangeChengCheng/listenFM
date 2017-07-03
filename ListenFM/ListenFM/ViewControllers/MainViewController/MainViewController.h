//
//  MainViewController.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ShowViewController.h"

@interface MainViewController : ShowViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@end
