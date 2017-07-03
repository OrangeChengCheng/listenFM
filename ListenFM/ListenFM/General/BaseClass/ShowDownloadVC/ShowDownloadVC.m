//
//  ShowDownloadVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ShowDownloadVC.h"
#import "Header.pch"
#import "NetManager.h"

@interface ShowDownloadVC ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation ShowDownloadVC
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
    return CGSizeMake(ScreenWidth, 80 * RateHeight);
}
#pragma mark - cell展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShowDownloadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellForShowDownload" forIndexPath:indexPath];
    D_show_M *showM = self.dataSource[indexPath.row];
    [cell getModelForShowDownloadCell:showM];
    [self.HUD hide:YES];
    return cell;
}
#pragma mark - 跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayerViewController *playerVC = [PlayerViewController shareWithPlayMusicViewController];

    [playerVC playerMusicWithModelArr:self.dataSource withIndex:indexPath.row];
    [self presentViewController:playerVC animated:YES completion:nil];
}

#pragma mark - ViewDidLoad
- (void)viewDidLoad {

    [super viewDidLoad];
    if (self.cellM != nil) {
        [self startNetWorkForHomeDSVCWithID:[self.cellM.item_value integerValue]];
    }
    if (self.moreZTM !=nil) {
        [self startNetWorkForHomeDSVCWithID:[self.moreZTM.item_value integerValue]];
    }
    if (self.moreRMBKM != nil) {
        [self startNetWorkForHomeDSVCWithID:self.moreRMBKM.ID];
    }
    if (self.hotTwoM != nil) {
        [self startNetWorkForHomeDSVCWithID:self.hotTwoM.ID];
    }
    if (self.AddM != nil) {
        [self startNetWorkForHomeDSVCWithID:self.AddM.ID];
    }
    if (self.maxM != nil) {
        [self startNetWorkForHomeDSVCWithID:self.maxM.ID];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 网络请求
- (void)startNetWorkForHomeDSVCWithID:(NSInteger)ID {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak ShowDownloadVC *mySelf = self;
    [manager getRequstWithURL:URL_Download(ID) withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForHomeDFVC:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForHomeDFVC:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableDictionary *dicS = dicF[@"content_list"];
    NSMutableArray *arrF = dicS[@"data_list"];
    for (NSMutableDictionary *dicT in arrF) {
        D_show_M *showM = [[D_show_M alloc] init];
        showM.ID = [dicT[@"id"] integerValue];
        showM.title = dicT[@"title"];
        showM.album_id = dicT[@"album_id"];
        showM.audio_64_url = dicT[@"audio_64_url"];
        showM.play_num = dicT[@"play_num"];
        showM.duration = dicT[@"duration"];
        showM.image_url = @"";
        [self.dataSource addObject:showM];
    }
    [self.collectionView reloadData];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
