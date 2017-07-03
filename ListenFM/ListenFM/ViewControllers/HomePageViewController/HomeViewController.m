//
//  HomeViewController.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeViewController.h"
#import "Header.pch"
#import "NetManager.h" // 网络请求
#import "SDCycleScrollView.h" // 轮播图

@interface HomeViewController ()<SDCycleScrollViewDelegate, MBProgressHUDDelegate>

@property (strong, nonatomic) NSMutableDictionary *dataSource; // 字典存大数据
@property (strong, nonatomic) NSMutableArray *dataArrKey; // 存储字典键值
@property (strong, nonatomic) NSMutableArray *arrScrollData; // 轮播图的ID

@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation HomeViewController

#pragma mark - 懒加载
- (NSMutableDictionary *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _dataSource;
}
- (NSMutableArray *)dataArrKey {
    if (!_dataArrKey) {
        self.dataArrKey = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArrKey;
}
- (NSMutableArray *)arrScrollData {
    if (!_arrScrollData) {
        self.arrScrollData = [NSMutableArray arrayWithCapacity:0];
    }
    return _arrScrollData;
}

#pragma mark - 返回分区和cell的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArrKey.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 11) {
        return 8;
    }
    if (section != 0 && section != 2 && section != 11) {
        return 3;
    }
    return 0;
}
#pragma mark - Cell的样式代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenWidth, 0.1);
    }
    if (indexPath.section == 2) {
        return CGSizeMake(SecondCellWidth, SecondCellWidth * 0.45 + 50 * RateHeight);
    }
    if (indexPath.section == 11) {
        return CGSizeMake(SecondCellWidth, SecondCellWidth * 0.22);
    }
    if (indexPath.section != 0 && indexPath.section != 2 && indexPath.section != 11) {
        return CGSizeMake(FirstCellWidth, FirstCellWidth + Space10 + Space40);
    }
    return CGSizeZero;
}
#pragma mark - Cell的代理方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section == 2) {
        HomeViewCellThird *cellT = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell33" forIndexPath:indexPath];
        NSString *key = self.dataArrKey[indexPath.section];
        NSMutableDictionary *dic = self.dataSource[key];
        NSMutableArray *arr = dic[@"data_list"];
        H_cell_M *cellM = arr[indexPath.row];
        
        [cellT getModelForHomeViewCellThird:cellM];
        return cellT;
    }
    if (indexPath.section == 11) {
        HomeViewCellSecond *cellS = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell22" forIndexPath:indexPath];
        NSString *key = self.dataArrKey[indexPath.section];
        NSMutableDictionary *dic = self.dataSource[key];
        NSMutableArray *arr = dic[@"data_list"];
        H_cell_M *cellM = arr[indexPath.row];
        
        [cellS getModelForHomeViewCellSecond:cellM];
        return cellS;
    }
    if (indexPath.section == 10) {
        HomeViewCellFourth *cellF = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell44" forIndexPath:indexPath];
        NSString *key = self.dataArrKey[indexPath.section];
        NSMutableDictionary *dic = self.dataSource[key];
        NSMutableArray *arr = dic[@"data_list"];
        H_cell_M *cellM = arr[indexPath.row];
        
        [cellF getModelForHomeViewCellFourth:cellM];
        return cellF;
    }
    if (indexPath.section != 0 && indexPath.section != 2 && indexPath.section != 11  && indexPath.section != 10) {
        HomeViewCellFirst *cellF = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell11" forIndexPath:indexPath];
        NSString *key = self.dataArrKey[indexPath.section];
        NSMutableDictionary *dic = self.dataSource[key];
        NSMutableArray *arr = dic[@"data_list"];
        H_cell_M *cellM = arr[indexPath.row];
        
        [cellF getModelForHomeViewCellFirst:cellM];
        
        // 风火轮结束
        [self.HUD hide:YES];
        
        return cellF;
    }
    return nil;
}
#pragma mark - 区头的样式代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenWidth, ScreenWidth / 3 + 68);
    }else {
        return CGSizeMake(ScreenWidth, 50 * RateHeight);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, Space10, 0);
    }else {
        return UIEdgeInsetsMake(Space10, Space10, Space10, Space10);
    }
}
#pragma mark - Header的代理方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            HomeHeaderScrollView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
            NSString *key = self.dataArrKey[indexPath.section];
            NSMutableDictionary *dicF = self.dataSource[key];
            NSMutableArray *arrF = dicF[@"data_list"];
            NSMutableArray *arrTemp = [NSMutableArray arrayWithCapacity:0];
            for (H_cell_M *cellM in arrF) {
                if (!(cellM.item_value.length > 10)) {
                    [arrTemp addObject:cellM.image_url];
                    [self.arrScrollData addObject:cellM.item_value];
                }
            }
            header.scrollView.delegate = self;
            [header getHeaderImages:arrTemp];
            return header;
        }else {
            HomeHeaderFirstView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header11" forIndexPath:indexPath];
            // 取model
            NSString *key = self.dataArrKey[indexPath.section];
            NSMutableDictionary *dic = self.dataSource[key];
            NSMutableArray *arr = dic[@"column"];
            H_headerC_M *headerM = arr.firstObject;
            header.homeHeaderTitle.text = headerM.title;
            header.homeHeaderBtn.tag = indexPath.section + 100;
            return header;
        }
    }
    return nil;
}
#pragma mark - 设置轮播图代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    PlayerViewController *playerVC = [PlayerViewController shareWithPlayMusicViewController];
    NSString *ID = self.arrScrollData[index];
    [playerVC startNetWorkForMusicPlay:ID];
    [self presentViewController:playerVC animated:YES completion:nil];
}

#pragma mark - 更多按钮点击事件
- (IBAction)homeVCToHomeDetailVC:(UIButton *)sender {
    if (sender.tag == 101 || (sender.tag > 102 && sender.tag < 111)) {
        [self performSegueWithIdentifier:@"toHomeDetailVCF" sender:sender];
    }
    if (sender.tag == 102) {
        [self performSegueWithIdentifier:@"toHomeDetailVCS" sender:sender];
    }
    if (sender.tag == 111) {
        [self performSegueWithIdentifier:@"toHomeDetailVCT" sender:sender];
    }
}
#pragma mark - Cell的点击事件
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 11 || indexPath.section == 10) {
        return YES;
    }else {

        return YES;
    }
    return NO;
}
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册空cell
    [self.homeCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // 注册轮播图区头
    [self.homeCollectionView registerClass:[HomeHeaderScrollView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    // 开始首页网络请求
    [self startNetWorkHome]; 
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 网络请求
- (void)startNetWorkHome {
    
    // 风火轮
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.minShowTime = 3.0;
    self.HUD.delegate = self;
    [self.HUD show:YES];
    
    
    NetManager *manager = [NetManager shareInstance];
    __weak HomeViewController *mySelf = self;
    [manager getRequstWithURL:URL_Home withType:@"application/json" withSuccess:^(id successBlock) {
        [mySelf parseJSONDataForHome:successBlock];
    } withError:^(NSError *errorBlock) {
        NSLog(@"%@", errorBlock);
    }];
}
- (void)parseJSONDataForHome:(NSMutableDictionary *)successBlock {
    NSMutableArray *arr = successBlock[@"data"];
    for (NSMutableDictionary *dic1 in arr) {
        NSMutableDictionary *dicQ = dic1[@"column"];
        NSString *key = dicQ[@"title"]; // 取键值
        NSMutableDictionary *dicTemp = [NSMutableDictionary dictionaryWithCapacity:0]; // 存储临时数据
        NSMutableArray *arrHeaderTemp = [NSMutableArray arrayWithCapacity:0]; // 存储区头临时数据
        // 取区头内容
        H_headerC_M *headerM = [[H_headerC_M alloc] init];
        [headerM setValuesForKeysWithDictionary:dicQ];
        [arrHeaderTemp addObject:headerM];
        [dicTemp setObject:arrHeaderTemp forKey:@"column"];
        // 取cell和轮播图内容
        NSMutableArray *arrC = dic1[@"data_list"];
        NSMutableArray *arrT = [NSMutableArray arrayWithCapacity:0];
        for (NSMutableDictionary *dic2 in arrC) {
            NSMutableArray *arrCellTemp = [NSMutableArray arrayWithCapacity:0]; // 存储cell临时数据
            H_cell_M *cellM = [[H_cell_M alloc] init];
            [cellM setValuesForKeysWithDictionary:dic2];
            [arrCellTemp addObject:cellM];
            [arrT addObjectsFromArray:arrCellTemp];
        }
        [dicTemp setObject:arrT forKey:@"data_list"];
        [self.dataSource setObject:dicTemp forKey:key];
        [self.dataArrKey addObject:key];
    }
    [self.homeCollectionView reloadData];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toHomeDetailVCS"]) {
        UIButton *btn = sender;
        NSString *key = self.dataArrKey[btn.tag - 100];
        NSMutableDictionary *dicF = self.dataSource[key];
        NSMutableArray *arrF = dicF[@"column"];
        H_headerC_M *headerM = arrF.firstObject;
        HomeDetailCVCSecond *homeDVCS = [segue destinationViewController];
        homeDVCS.headerM = headerM;
    }
    if ([segue.identifier isEqualToString:@"toHomeDetailVCF"]) {
        UIButton *btn = sender;
        NSString *key = self.dataArrKey[btn.tag - 100];
        NSMutableDictionary *dicF = self.dataSource[key];
        NSMutableArray *arrF = dicF[@"column"];
        H_headerC_M *headerM = arrF.firstObject;
        HomeDetailViewController *homeDVCF = [segue destinationViewController];
        homeDVCF.headerM = headerM;
    }
    if ([segue.identifier isEqualToString:@"HomeVCSecondCellToDownVC"] || [segue.identifier isEqualToString:@"HomeVCThirdCellToShowDownload"] || [segue.identifier isEqualToString:@"cell44ToShowDownload"]) { // 热门播客、专题、相声剧场
        NSIndexPath *indexPath = [self.homeCollectionView indexPathForCell:sender];
        NSString *key = self.dataArrKey[indexPath.section];
        NSMutableDictionary *dic = self.dataSource[key];
        NSMutableArray *arr = dic[@"data_list"];
        H_cell_M *cellM = arr[indexPath.row];
        ShowDownloadVC *showDVC = [segue destinationViewController];
        showDVC.cellM = cellM;
    }
    if ([segue.identifier isEqualToString:@"666666"]) {
        NSIndexPath *indexPath = [self.homeCollectionView indexPathForCell:sender];
        NSString *key = self.dataArrKey[indexPath.section];
        NSMutableDictionary *dic = self.dataSource[key];
        NSMutableArray *arr = dic[@"data_list"];
        H_cell_M *cellM = arr[indexPath.row];
        
        TempPlayerTVC *tempPTVC = [segue destinationViewController];
        tempPTVC.cellM = cellM;
    }

}


@end
