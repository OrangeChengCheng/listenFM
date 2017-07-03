//
//  MainCollectionVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/22.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "MainCollectionVC.h"
#import "AppDelegate.h"
#import "Header.pch"
#import "MainCollectionCell.h"

@interface MainCollectionVC ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSManagedObjectContext *managerObjeceContext;

@end

@implementation MainCollectionVC
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.managerObjeceContext = delegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CoreDataModel"];
    NSArray *arr = [self.managerObjeceContext executeFetchRequest:request error:nil];
    [self.dataSource addObjectsFromArray:arr];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellForMainCollection" forIndexPath:indexPath];
    
    CoreDataModel *model = self.dataSource[indexPath.row];
    cell.indexLable.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.titleLable.text = model.title;
    // Configure the cell...
    
    return cell;
}

#pragma mark - 删除收藏
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        CoreDataModel *model = self.dataSource[indexPath.row];
        [self.managerObjeceContext deleteObject:model];
        [self.managerObjeceContext save:nil];
        [self.dataSource removeObject:model];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
