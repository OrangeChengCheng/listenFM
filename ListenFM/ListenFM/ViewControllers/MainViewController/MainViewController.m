//
//  MainViewController.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.musicBtn removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [self.mainTableView reloadData];
}


#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MainLoginCell *cellL = [tableView dequeueReusableCellWithIdentifier:@"cellForMainLogin" forIndexPath:indexPath];
        if ([[FileHelper shareInstance] loginState]) {
            cellL.loginLable.text = @"已经登录";
            cellL.contentLable.text = @"尊敬的用户欢迎您!";
            NSData *data = [[FileHelper shareInstance] image];
            cellL.userImage.image = [UIImage imageWithData:data];
        }else {
            cellL.loginLable.text = @"马上登录";
            cellL.contentLable.text = @"登陆后享受云同步和更多服务";
            cellL.userImage.image = [UIImage imageNamed:@"ic_default_bg.png"];
        }
        return cellL;
    }

    MainDownloadCell *cellD = [tableView dequeueReusableCellWithIdentifier:@"cellForMainDownload" forIndexPath:indexPath];
    NSArray *array = @[@"我的收藏", @"我的下载", @"关于我们"];
    NSArray *arr = @[@"collection", @"download", @"about"];
    cellD.title.text = array[indexPath.section - 1];
    cellD.image.image = [UIImage imageNamed:arr[indexPath.section - 1]];
    return cellD;
}
#pragma mark - Cell代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110 * RateHeight;
    }
    return 60 * RateHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        return 30 * RateHeight;
    }
    return 10 * RateHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 30 * RateHeight;
    }
    return 0;
}

#pragma mark - 点击cell操作
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([[FileHelper shareInstance] loginState]) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要退出当前登陆状态" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 用户注销，修改登陆状态
                [[FileHelper shareInstance] setLoginState:NO];
                [[FileHelper shareInstance] synchronize];
                [self performSegueWithIdentifier:@"123" sender:nil];
            }];
            UIAlertAction *alertA2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertC addAction:alertA1];
            [alertC addAction:alertA2];
            [self presentViewController:alertC animated:YES completion:nil];
        }else {
            [self performSegueWithIdentifier:@"123" sender:nil];
        }
        return indexPath;
    }
    if (indexPath.section == 1) {
        if ([[FileHelper shareInstance] loginState]) {
            [self performSegueWithIdentifier:@"1234" sender:nil];
        }else {
            [self performSegueWithIdentifier:@"123" sender:nil];
        }
        return indexPath;
    }
    if (indexPath.section == 2) {
        if ([[FileHelper shareInstance] loginState]) {
            [self performSegueWithIdentifier:@"12345" sender:nil];
        }else {
            [self performSegueWithIdentifier:@"123" sender:nil];
        }
        return indexPath;
    }
    if (indexPath.section == 3) {
        [self performSegueWithIdentifier:@"123456" sender:nil];
        return indexPath;
    }
    return nil;
}

@end
