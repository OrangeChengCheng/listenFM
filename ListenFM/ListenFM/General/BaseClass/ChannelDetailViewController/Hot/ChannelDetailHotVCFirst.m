//
//  ChannelDetailHotVCFirst.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailHotVCFirst.h"
#import "Header.pch"
#import "NetManager.h"

@interface ChannelDetailHotVCFirst ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation ChannelDetailHotVCFirst
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
    return CGSizeMake(ScreenWidth, SecondCellWidth * 0.25);
}
#pragma mark - cell展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChannelDetailHotCellFirst *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellChannelHot111" forIndexPath:indexPath];
    C_HotTwo_M *hotTwoM = self.dataSource[indexPath.row];
    
    [cell getModelForChannelDetailHotCellFirst:hotTwoM];
    [self.HUD hide:YES];
    return cell;
}
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkForChannelHotTwo:self.ID];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)startNetWorkForChannelHotTwo:(NSInteger)ID {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager *manager = [NetManager shareInstance];
    __weak ChannelDetailHotVCFirst *mySelf = self;
    [manager getRequstWithURL:URL_ChannelHot_Second(ID) withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForChannelHotTwo:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForChannelHotTwo:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableArray *arrF = dicF[@"data_list"];
    for (NSMutableDictionary *dicS in arrF) {
        C_HotTwo_M *hotTwoM = [[C_HotTwo_M alloc] init];
        [hotTwoM setValuesForKeysWithDictionary:dicS];
        [self.dataSource addObject:hotTwoM];
    }
    [self.collectionView reloadData];
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ChannelDHotVCFToDownVC"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        C_HotTwo_M *hotTwoM = self.dataSource[indexPath.row];
        ShowDownloadVC *showDVC = [segue destinationViewController];
        showDVC.hotTwoM = hotTwoM;
    }
}

@end
