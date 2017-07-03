//
//  HomeDetailCVCSecond.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeDetailCVCSecond.h"
#import "Header.pch"
#import "NetManager.h"

@interface HomeDetailCVCSecond ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation HomeDetailCVCSecond
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
    return CGSizeMake(SecondCellWidth, SecondCellWidth * 0.68);
}
#pragma mark - cell展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailCellSecond *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell222" forIndexPath:indexPath];
    H_More_ZT_M *moreM = self.dataSource[indexPath.row];
    
    [cell getModelForHomeDetailCellSecond:moreM];
    [self.HUD hide:YES];
    return cell;
}

#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkForHomeDSVCWithID:self.headerM.ID];
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
    __weak HomeDetailCVCSecond *mySelf = self;
    [manager getRequstWithURL:URL_Home_ZTmore(ID) withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForHomeDSVC:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForHomeDSVC:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableArray *arrF = dicF[@"data_list"];
    for (NSMutableDictionary *dicS in arrF) {
        H_More_ZT_M *moreZTM = [[H_More_ZT_M alloc] init];
        [moreZTM setValuesForKeysWithDictionary:dicS];
        [self.dataSource addObject:moreZTM];
    }
    [self.collectionView reloadData];
}




 #pragma mark - Navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"HomeDVCSecondCellToShowDownload"]) {
         NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
         H_More_ZT_M *moreM = self.dataSource[indexPath.row];
         ShowDownloadVC *showDVC = [segue destinationViewController];
         showDVC.moreZTM = moreM;
     }
 }


@end
