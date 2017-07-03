//
//  ChannelDetailNewAddVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/15.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ChannelDetailNewAddVC.h"
#import "Header.pch"
#import "NetManager.h"

@interface ChannelDetailNewAddVC ()<MBProgressHUDDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MBProgressHUD *HUD;
@end

@implementation ChannelDetailNewAddVC
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
    return CGSizeMake(ThirdCellWidth, ThirdCellWidth);
}
#pragma mark - cell展示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChannelDetailNewAddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelDetailNewAddCell" forIndexPath:indexPath];
    C_NewAdd_M *newAddM = self.dataSource[indexPath.row];
    
    [cell getMedolForChannelDetailNewAddCell:newAddM];
    [self.HUD hide:YES];
    return cell;
}
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNetWorkForChannelNewAdd];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 网络请求
- (void)startNetWorkForChannelNewAdd {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.collectionView];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    NetManager * manager = [NetManager shareInstance];
    __weak ChannelDetailNewAddVC *mySelf = self;
    [manager getRequstWithURL:URL_ChannelNewAdd withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForChannelNewAdd:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForChannelNewAdd:(NSMutableDictionary *)successBlock {
    NSMutableDictionary *dicF = successBlock[@"data"];
    NSMutableArray *arr = dicF[@"data_list"];
    for (NSMutableDictionary *dicS in arr) {
        C_NewAdd_M *newAddM = [[C_NewAdd_M alloc] init];
        [newAddM setValuesForKeysWithDictionary:dicS];
        [self.dataSource addObject:newAddM];
    }
    [self.collectionView reloadData];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CDNewAddCellToShowD"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        C_NewAdd_M *newAddM = self.dataSource[indexPath.row];
        ShowDownloadVC *showDVC = [segue destinationViewController];
        showDVC.AddM = newAddM;
    }
}

@end
