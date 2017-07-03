//
//  HomeDetailCVCThird.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeDetailCVCThird.h"
#import "Header.pch"
#import "NetManager.h"

@interface HomeDetailCVCThird ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation HomeDetailCVCThird
#pragma mark - 懒加载
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth, ScreenWidth * 0.35);
}
#pragma mark - cell展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailCellThird *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell333" forIndexPath:indexPath];
    H_More_RMBK_M *moreRMBKM = self.dataSource[indexPath.row];
    
    [cell getModelForHomeDetailCellThird:moreRMBKM];
    [self.HUD hide:YES];
    return cell;
}
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkForHomeDSVCWithID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 网络请求
- (void)startNetWorkForHomeDSVCWithID {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak HomeDetailCVCThird *mySelf = self;
    [manager getRequstWithURL:URL_Home_RMBKmore withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForHomeDTVC:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForHomeDTVC:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableDictionary *dicS = dicF[@"hot_albums"];
    NSMutableArray *arrF = dicS[@"data_list"];
    for (NSMutableDictionary *dicT in arrF) {
        H_More_RMBK_M *moreRMBKM = [[H_More_RMBK_M alloc] init];
        [moreRMBKM setValuesForKeysWithDictionary:dicT];
        [self.dataSource addObject:moreRMBKM];
    }
    [self.collectionView reloadData];
}


 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"HomeDVCToDownVC"]) {
         NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
         H_More_RMBK_M *moreRMBKM = self.dataSource[indexPath.row];
         ShowDownloadVC *showDVC = [segue destinationViewController];
         showDVC.moreRMBKM = moreRMBKM;
     }
 }


@end
