//
//  IsLoginVC.m
//  ListenFM
//
//  Created by lanouhn on 16/3/19.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "IsLoginVC.h"
#import "UMSocial.h"
#import "FileHelper.h"
#import "UIImageView+WebCache.h"

@interface IsLoginVC ()

@end

@implementation IsLoginVC
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[FileHelper shareInstance]loginState]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnAction:(UIButton *)sender {
    if (self.userTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        // 从沙盒中获取用户的信息
        NSString *userName = [[FileHelper shareInstance] userName];
        NSString *passswork = [[FileHelper shareInstance] password];
        
        // 验证登陆
        if ([self.userTextField.text isEqualToString:userName] && [self.passwordTextField.text isEqualToString:passswork]) {
            
            // 设置登陆状态
            [[FileHelper shareInstance] setLoginState:YES];
            [[FileHelper shareInstance] synchronize];
            
            // 退出登陆界面
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            // 登陆失败
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertC addAction:alertA1];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:alertA1];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}
- (IBAction)sinaLoginBtn:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self, [UMSocialControllerService defaultControllerService], YES, ^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            [[FileHelper shareInstance] setLoginState:YES];
            [[FileHelper shareInstance] synchronize];
            
            [[FileHelper shareInstance] setUserName:snsAccount.userName];
            
            NSString *strUrl = snsAccount.iconURL;
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
            
            [[FileHelper shareInstance] setImage:data];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    });
}
- (IBAction)tencentLoginAction:(UIButton *)sender {
}
- (IBAction)renrenLoginAction:(UIButton *)sender {
}




- (IBAction)backBtnAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}





- (IBAction)registerBtnAction:(UIBarButtonItem *)sender {
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
