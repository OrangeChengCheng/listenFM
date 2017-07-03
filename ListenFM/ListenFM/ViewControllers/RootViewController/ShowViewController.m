//
//  ShowViewController.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "ShowViewController.h"
#import "header.pch"

@interface ShowViewController ()
@property (strong, nonatomic) NSMutableArray *playerVCBtnArr;

@end

@implementation ShowViewController
- (NSMutableArray *)playerVCBtnArr {
    if (!_playerVCBtnArr) {
        self.playerVCBtnArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _playerVCBtnArr;
}
#pragma mark - 展示左边的视图
- (void)showLeftView {
    //添加遮盖,拦截用户操作
    self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clearBtn.frame = self.navigationController.view.bounds;
    [self.clearBtn addTarget:self action:@selector(handleClearBtnToBack) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:self.clearBtn];
    //缩放比例
    CGFloat zoomScale = (ScreenHeight - TopDistanceForRV * 2) / ScreenHeight;
    //X移动距离
    CGFloat moveX = ScreenWidth - ScreenWidth * ZoomScaleRight;
    
    [UIView animateWithDuration:AnimateTimeForRV animations:^{
        
        CGAffineTransform transform = CGAffineTransformMakeScale(zoomScale, zoomScale);
        
        self.navigationController.view.transform = CGAffineTransformTranslate(transform, moveX, 0);
        self.isScale = YES;
    }];

}
#pragma mark - 点击透明btn返回
- (void)handleClearBtnToBack {
    [UIView animateWithDuration:AnimateTimeForRV animations:^{
        self.navigationController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.clearBtn removeFromSuperview];
        self.clearBtn = nil;
        self.isScale = NO;
    }];
}
#pragma mark - 跳转播放界面
- (void)handleBtnToPlayerVC:(UIButton *)sender {
    
    PlayerViewController *playerVC = [PlayerViewController shareWithPlayMusicViewController];
    [self presentViewController:playerVC animated:YES completion:nil];
}
#pragma mark - 播放按钮动态
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (int i = 0; i < 22; i++) {
        NSString *imageN = nil;
        if (i < 10) {
            imageN = [NSString stringWithFormat:@"red_play0%d@2x", i];
        }else {
            imageN = [NSString stringWithFormat:@"red_play%d@2x", i];
        }
        UIImage *image = [UIImage imageNamed:imageN];
        [self.playerVCBtnArr addObject:image];
    }
    self.musicBtn.imageView.animationImages = self.playerVCBtnArr;
    self.musicBtn.imageView.animationDuration = 2.0;
    self.musicBtn.imageView.animationRepeatCount = 40000;
    
    if ([PlayerViewController shareWithPlayMusicViewController].player.rate == 1) {
        [self.musicBtn.imageView startAnimating];
    }else {
       [self.musicBtn.imageView stopAnimating];
    }
}
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"CK_LeftBtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
    
    
    self.musicBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 25, 10, 20, 20)];
    [self.musicBtn setImage:[UIImage imageNamed:@"red_play00@2x"] forState:UIControlStateNormal];
    [self.musicBtn addTarget:self action:@selector(handleBtnToPlayerVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:self.musicBtn];
 
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

@end
