//
//  HomeDetailViewController.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "Header.pch"
#import "NetManager.h"

@interface HomeDetailViewController ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation HomeDetailViewController
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
    return CGSizeMake(FirstCellWidth, FirstCellWidth + Space10 * RateHeight + Space40 * RateHeight);
}
#pragma mark - cell展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailCellFirst *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell111" forIndexPath:indexPath];
    H_More_MAX_M *moreMAXM = self.dataSource[indexPath.row];
    [cell getModelForHomeDetailCellFirst:moreMAXM];
    
    [self.HUD hide:YES];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.headerM.title isEqualToString:@"热门推荐"]) {
        H_More_MAX_M *moreMAXM = self.dataSource[indexPath.row];
        TempPlayerTVC *tempTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TempPlayerTVC"];
        tempTVC.cellM.item_value = moreMAXM.item_value;
        tempTVC.item = moreMAXM.item_value;
        [self.navigationController pushViewController:tempTVC animated:YES];
    }

}
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.headerM.title isEqualToString:@"热门推荐"]) {
        [self startNetWorkForHomeDSVCWithID:self.headerM.ID];
    }
    if ([self.headerM.title isEqualToString:@"音乐调频"]) {
        [self startNetWorkForHomeDSVCWithID];
    }
    if (![self.headerM.title isEqualToString:@"热门推荐"] && ![self.headerM.title isEqualToString:@"音乐调频"]) {
        [self startNetWorkForHomeDetailMaxWithID:self.headerM.redirect_value];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 网络请求(热门)
- (void)startNetWorkForHomeDSVCWithID:(NSInteger)ID {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];

    NetManager *manager = [NetManager shareInstance];
    __weak HomeDetailViewController *mySelf = self;
    [manager getRequstWithURL:URL_Home_ZTmore(ID) withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForHomeDFVC:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForHomeDFVC:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableArray *arrF = dicF[@"data_list"];
    for (NSMutableDictionary *dicS in arrF) {
        H_More_MAX_M *moreMAXM = [[H_More_MAX_M alloc] init];
        [moreMAXM setValuesForKeysWithDictionary:dicS];
        [self.dataSource addObject:moreMAXM];
    }
    [self.collectionView reloadData];
}
#pragma mark - 网络请求(音乐调频)
- (void)startNetWorkForHomeDSVCWithID {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak HomeDetailViewController *mySelf = self;
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
        H_More_MAX_M *moreMAXM = [[H_More_MAX_M alloc] init];
        [moreMAXM setValuesForKeysWithDictionary:dicT];
        [self.dataSource addObject:moreMAXM];
    }
    [self.collectionView reloadData];
}
#pragma mark - 网络请求(相声剧场、热门小说、亲子教育、段子来了、历史人文、心情电台、财经调频)
- (void)startNetWorkForHomeDetailMaxWithID:(NSString *)ID {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak HomeDetailViewController *mySelf = self;
    [manager getRequstWithURL:URL_Home_XSJCmore(ID) withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForHomeDetailMax:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForHomeDetailMax:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableArray *arrF = dicF[@"data_list"];
    for (NSMutableDictionary *dicS in arrF) {
        H_More_MAX_M *moreMAXM = [[H_More_MAX_M alloc] init];
        [moreMAXM setValuesForKeysWithDictionary:dicS];
        [self.dataSource addObject:moreMAXM];
    }
    [self.collectionView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"homeDVCFToSD"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        H_More_MAX_M *moreMAXM = self.dataSource[indexPath.row];
        ShowDownloadVC *showDVC = [segue destinationViewController];
        showDVC.moreRMBKM = moreMAXM;
    }
}




@end
