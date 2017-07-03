//
//  TempPlayerTVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/24.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "TempPlayerTVC.h"
#import "TempPlayerCell.h"
#import "Header.pch"
#import "NetManager.h"

@interface TempPlayerTVC ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation TempPlayerTVC
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.cellM.item_value != nil) {
        [self stratNetWorkForTempPlayerVC:self.cellM.item_value];
    }else {
        [self stratNetWorkForTempPlayerVC:self.item];
    }
    
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
    TempPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellForTemp" forIndexPath:indexPath];
    C_Listen_M *listenM = self.dataSource[indexPath.row];
    cell.contentTitleLable.text = listenM.title;
    cell.num_TopLable.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    [self.HUD hide:YES];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerViewController *playerVC = [PlayerViewController shareWithPlayMusicViewController];
    [playerVC playerMusicWithModelArr:self.dataSource withIndex:indexPath.row];
    [self presentViewController:playerVC animated:YES completion:nil];
    
}

- (void)stratNetWorkForTempPlayerVC:(NSString *)ID {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.tableView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak TempPlayerTVC *mySelf = self;
    [manager getRequstWithURL:URL_TempPlay(ID) withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForTempPlayerVC:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}

- (void)parseJSONDataForTempPlayerVC:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableArray *arrF = dicF[@"data_list"];
    for (NSDictionary *dicS in arrF) {
        C_Listen_M *listenM = [[C_Listen_M alloc] init];
        listenM.title = dicS[@"title"];
        listenM.audio_64_url = dicS[@"audio_64_url"];
        listenM.album_id = dicS[@"album_id"];
        [self.dataSource addObject:listenM];
    }
    [self.tableView reloadData];
}




@end
