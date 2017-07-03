//
//  ChannelDetailListenVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailListenVC.h"
#import "Header.pch"
#import "NetManager.h"

@interface ChannelDetailListenVC ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation ChannelDetailListenVC
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
    return CGSizeMake(ScreenWidth, SecondCellWidth * 0.35);
}
#pragma mark - cell展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChannelDetailListenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelDetailListenCell" forIndexPath:indexPath];
    C_Listen_M *listenM = self.dataSource[indexPath.row];
    
    [cell getModelForChannelDetailListenCell:listenM];
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
    [self startNetWorkForChannelListen];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 网络请求
- (void)startNetWorkForChannelListen {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak ChannelDetailListenVC *mySelf = self;
    [manager getRequstWithURL:URL_ChannelListen withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForChannelListen:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForChannelListen:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableArray *arrF = dicF[@"data_list"];
    for (NSMutableDictionary *dicS in arrF) {
        C_Listen_M *listenM = [[C_Listen_M alloc] init];
        NSMutableDictionary *dicTF = dicS[@"album"];
        listenM.ID = [dicTF[@"id"] integerValue];
        listenM.title = dicTF[@"title"];
        listenM.image_url = dicTF[@"image_url"];
        NSMutableDictionary *dicTS = dicS[@"content"];
        listenM.contentTitle = dicTS[@"title"];
        listenM.audio_64_url = dicTS[@"audio_64_url"];
        NSMutableDictionary *dicTT = dicS[@"user"];
        listenM.user_name = dicTT[@"real_name"];
        listenM.user_image_url = dicTT[@"image_url"];
        [self.dataSource addObject:listenM];
    }
    [self.collectionView reloadData];
}

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
 }



@end
