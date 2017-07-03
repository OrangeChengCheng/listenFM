//
//  ShowViewController.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UIViewController
@property (nonatomic, assign) BOOL isScale; // 是否缩放
@property (nonatomic, strong) UIButton *clearBtn; // 透明btn
@property (strong, nonatomic) UIButton *musicBtn;


- (void)showLeftView; // 展示左边的视图
- (void)handleClearBtnToBack; // 点击透明btn返回

@end
