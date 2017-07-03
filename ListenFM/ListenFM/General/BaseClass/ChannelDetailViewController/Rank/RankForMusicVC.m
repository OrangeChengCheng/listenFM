//
//  RankForMusicVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "RankForMusicVC.h"
#import "Header.pch"
#import "NetManager.h"


@interface RankForMusicVC ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (copy, nonatomic) NSString *imagrUrl;
@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation RankForMusicVC
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.navigationController);
    [self startNetWorkForRankMusic:0];
    self.title = @"音乐排行榜";
    self.collection_Music.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ZS_BJ2"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 网络请求
- (void)startNetWorkForRankMusic:(NSInteger)page {
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak RankForMusicVC *mySelf = self;
    [manager getRequstWithURL:URL_Rank_Music(page) withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForRankMusic:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForRankMusic:(NSMutableDictionary *)successBlock {
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
    [self.collection_Music reloadData];
}



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

#pragma mark - Cell的代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RankForMusicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellForRankMusic" forIndexPath:indexPath];
    C_Listen_M *listenM = self.dataSource[indexPath.row];
    if (indexPath.row < 3) {
        listenM.isValue = YES;
    }
    [cell getModelForRankForMusicCell:listenM withIndexPath:indexPath];
    [self.HUD hide:YES];
    if (cell.isCell == NO) {
        cell.rank_Music_TopNum.backgroundColor = [UIColor lightGrayColor];
        cell.rank_Music_TopNum.font = [UIFont systemFontOfSize:13];
    }
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return Space10;
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
        RankForMusicHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerForRankMusic" forIndexPath:indexPath];
        [header getModelForRankForMusicHeader:self.imagrUrl];
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
