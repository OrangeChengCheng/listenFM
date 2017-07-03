//
//  ChannelDetailHotVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailHotVC.h"
#import "Header.pch"
#import "NetManager.h"

@interface ChannelDetailHotVC ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation ChannelDetailHotVC
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
    return CGSizeMake(ScreenWidth, SecondCellWidth * 0.78);
}
#pragma mark - cell展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChannelDetailHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellChannelHot11" forIndexPath:indexPath];
    C_HotOne_M *hotOneM = self.dataSource[indexPath.row];
    
    [cell getModelForChannelDetailHotCell:hotOneM];
    [self.HUD hide:YES];
    return cell;
}
#pragma mark - 点击cell的方法
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    C_HotOne_M *hotOneM = self.dataSource[indexPath.row];
    if ([hotOneM.album_id isEqualToString:@"0"]) {
        return YES;
    }
    return NO;
}
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkChannelHot];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 网络请求
- (void)startNetWorkChannelHot {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak ChannelDetailHotVC *mySelf = self;
    [manager getRequstWithURL:URL_ChannelHot withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForChannelHotF:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForChannelHotF:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicD = successBlock[@"data"];
    NSMutableArray *arr = dicD[@"data_list"];
    for (NSMutableDictionary *dic in arr) {
        NSMutableDictionary *dicT = dic[@"topic"];
        C_HotOne_M *hotOneM = [[C_HotOne_M alloc] init];
        [hotOneM setValuesForKeysWithDictionary:dicT];
        [self.dataSource addObject:hotOneM];
    }
    [self.collectionView reloadData];
}
 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqual:@"toChannelDHotVCF"]) {
         ChannelDetailHotVCFirst *CDHotVCF = [segue destinationViewController];
         NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
         C_HotOne_M *hotOneM = self.dataSource[indexPath.row];
         CDHotVCF.ID = hotOneM.ID;
     }
 }

@end
