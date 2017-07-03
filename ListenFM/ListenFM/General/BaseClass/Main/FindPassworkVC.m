//
//  FindPassworkVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/23.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "FindPassworkVC.h"
#import "Header.pch"

@interface FindPassworkVC ()

@end

@implementation FindPassworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)findPassworkAction:(UIButton *)sender {
    
    NSString *str1 = [[FileHelper shareInstance] userName];
    NSString *str2 = [[FileHelper shareInstance] emailAddress];
    NSString *str3 = [[FileHelper shareInstance] phoneNumber];
    
    NSString *strT1 = self.userNameTextField.text;
    NSString *strT2 = self.eMainTextField.text;
    NSString *strT3 = self.phoneTextField.text;
    
    if (strT1.length > 0 && strT2.length > 0 && strT3.length > 0) {
        if ([strT1 isEqualToString:str1] && [strT2 isEqualToString:str2] && [strT3 isEqualToString:str3]) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入新密码" preferredStyle:UIAlertControllerStyleAlert];
            // 添加输入框
            [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            }];
            UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 获取输入框的文字
                NSString *str = alertC.textFields.firstObject.text;
                // 保存新密码
                [[FileHelper shareInstance] setPassword:str];
                [[FileHelper shareInstance] synchronize];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertAction *alertA2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertC addAction:alertA1];
            [alertC addAction:alertA2];
            [self presentViewController:alertC animated:YES completion:nil];
        }else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的信息错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertC addAction:alertA1];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"信息不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:alertA1];
        [self presentViewController:alertC animated:YES completion:nil];
    }
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
