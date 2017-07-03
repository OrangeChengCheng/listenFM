//
//  RankForNetVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "RankForNetVC.h"
#import "NetManager.h"
#import "Header.pch"

@interface RankForNetVC ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (copy, nonatomic) NSString *imagrUrl;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation RankForNetVC
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkForRankNet:0];
    
    self.collection_Net.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"CK_bg1"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 网络请求
- (void)startNetWorkForRankNet:(NSInteger)page {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak RankForNetVC *mySelf = self;
    [manager getRequstWithURL:URL_Rank_Net(page) withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForRankNet:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForRankNet:(NSMutableDictionary *)successBlock {
    self.imagrUrl = successBlock[@"img"];
    NSMutableArray *arr = successBlock[@"songs"];
    for (NSMutableDictionary *dic in arr) {
        C_Listen_M *listenM = [[C_Listen_M alloc] init];//
        listenM.title = dic[@"title"];
        listenM.singer = dic[@"singer"];
        listenM.singerIcon = dic[@"singerIcon"];
        listenM.singerImg = dic[@"singerImg"];
        listenM.audio_64_url = [NSString stringWithFormat:@"%@&ua=Iphone_Sst&version=4.243&netType=1&toneFlag=1", dic[@"url"]];
        [self.dataSource addObject:listenM];
    }
    [self.collection_Net reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 返回分区和cell的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
#pragma mark - Cell的样式代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SecondCellWidth, SecondCellWidth * 0.22);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Space10;
}
#pragma mark - Cell的代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RankForNetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellForRankNet" forIndexPath:indexPath];
    C_Listen_M *listenM = self.dataSource[indexPath.row];
    if (indexPath.row < 3) {
        listenM.isValue = YES;
    }
    [cell getModelForRankForNetCell:listenM withIndexPath:indexPath];
    [self.HUD hide:YES];
    if (cell.isCell == NO) {
        cell.rank_Net_TopNum.backgroundColor = [UIColor lightGrayColor];
        cell.rank_Net_TopNum.font = [UIFont systemFontOfSize:13];
    }
    return cell;
}
#pragma mark - 区头的样式代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, ScreenWidth / 3 + 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(Space10, 0, Space10, 0);
}
#pragma mark - Header的代理方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        RankForNetHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerForRankNet" forIndexPath:indexPath];
        [header getModelForRankForNetHeader:self.imagrUrl];
        return header;
    }
    return nil;
}
#pragma mark - 点击跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayerViewController *playerVC = [PlayerViewController shareWithPlayMusicViewController];
    [playerVC playerMusicWithModelArr:self.dataSource withIndex:indexPath.row];
    [self presentViewController:playerVC animated:YES completion:nil];
}
@end
