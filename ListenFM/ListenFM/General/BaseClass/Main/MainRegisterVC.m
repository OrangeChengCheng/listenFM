//
//  MainRegisterVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/23.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "MainRegisterVC.h"
#import "FileHelper.h"

@interface MainRegisterVC ()

@end

@implementation MainRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)confirmBtnAction:(UIBarButtonItem *)sender {
    // 注册时用户名和密码不能为空
    NSString *str1 = self.userName.text;
    NSString *str2 = self.passwork.text;
    NSString *str3 = self.passworkAgain.text;
    NSString *str4 = self.eMail.text;
    NSString *str5 = self.phone.text;
    
    if (str1.length > 0 && str2.length > 0 && str3.length > 0 && str4.length > 0 && str5.length > 0) {
        // 注册时，两次输入的密码必须一致
        if ([str2 isEqualToString:str3]) {
            // 保存注册用户的信息
            [[FileHelper shareInstance] setUserName:self.userName.text];
            [[FileHelper shareInstance] setPassword:self.passwork.text];
            [[FileHelper shareInstance] setEmail:self.eMail.text];
            [[FileHelper shareInstance] setPhoneNumber:self.phone.text];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.ffpic.com/files/png/0223hy/ffpic1306125173179.png"]];
            [[FileHelper shareInstance] setImage:data];
            
            // 设置用户为登陆状态
            [[FileHelper shareInstance] setLoginState:YES];
            
            [[FileHelper shareInstance] synchronize];
            
            // 注册完成返回登陆界面
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次的密码输入不一致" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertC addAction:alertA1];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号和密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:alertA1];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
