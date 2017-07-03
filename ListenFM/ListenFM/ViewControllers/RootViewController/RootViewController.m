//
//  RootViewController.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "RootViewController.h"
#import "Header.pch"

@interface RootViewController ()<LeftViewDelegate>
@property (strong, nonatomic) IBOutlet LeftView *leftView;
@property (strong, nonatomic) ShowViewController *showViewController;

@end

@implementation RootViewController

#pragma mark - 添加侧边栏控制器
- (void)addLeftViewController {
    UIStoryboard *mainS = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSArray *arr = @[@"HomeViewController", @"ChannelViewController", @"MainViewController"];
    int index = 0;
    for (NSString *str in arr) {
        UIViewController *viewC = [mainS instantiateViewControllerWithIdentifier:str];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:viewC];
        [self addChildViewController:navC];
        if (index != 0) {
            self.showViewController = navC.childViewControllers.firstObject;
            CGFloat zoomScale = (ScreenHeight - TopDistanceForRV * 2) / ScreenHeight;
            CGFloat maxMoveX = ScreenWidth - ScreenWidth * ZoomScaleRight;
            CGAffineTransform tt = CGAffineTransformMakeScale(zoomScale, zoomScale);
            self.showViewController.navigationController.view.transform = CGAffineTransformTranslate(tt, maxMoveX, 0);
        }
        index++;
    }
    [self.view insertSubview:self.leftView atIndex:1];
    self.leftView.delegate = self;
    //添加手势
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewAction:)];
    [self.view addGestureRecognizer:panG];
}

#pragma mark - 轻拍手势方法
- (void)handleViewAction:(UIPanGestureRecognizer *)sender {
    CGFloat moveX = [sender translationInView:self.view].x;
    //缩放的最终比例值
    CGFloat zoomScale = (ScreenHeight - TopDistanceForRV * 2) / ScreenHeight;
    //X最终偏移距离
    CGFloat maxMoveX = ScreenWidth - ScreenWidth * ZoomScaleRight;
    //没有缩放时，允许缩放
    if (self.showViewController.isScale == NO) {
        if (moveX <= maxMoveX + 5 && moveX >= 0) {
            //获取X偏移XY缩放的比例
            CGFloat scaleXY = 1 - moveX / maxMoveX * ZoomScaleRight;
            CGAffineTransform transform = CGAffineTransformMakeScale(scaleXY, scaleXY);
            self.showViewController.navigationController.view.transform = CGAffineTransformTranslate(transform, moveX / scaleXY, 0);
        }
        //当手势停止的时候,判断X轴的移动距离，停靠
        if (sender.state == UIGestureRecognizerStateEnded) {
            //计算剩余停靠时间
            if (moveX >= maxMoveX / 2) {
                CGFloat duration = 0.5 * (maxMoveX - moveX)/maxMoveX > 0 ? 0.5 * (maxMoveX - moveX)/maxMoveX : -(0.5 * (maxMoveX - moveX)/maxMoveX);
                if (duration <= 0.1) duration = 0.1;
                //直接停靠到停止的位置
                [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    CGAffineTransform tt = CGAffineTransformMakeScale(zoomScale, zoomScale);
                    self.showViewController.navigationController.view.transform = CGAffineTransformTranslate(tt, maxMoveX , 0);
                } completion:^(BOOL finished) {
                    //将状态改为已经缩放
                    self.showViewController.isScale = YES;
                    //手动点击按钮添加遮盖
                    [self.showViewController showLeftView];
                }];
            } else  {//X轴移动不够一半 回到原位,不是缩放状态
                [UIView animateWithDuration:0.2 animations:^{
                    self.showViewController.navigationController.view.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    self.showViewController.isScale = NO;
                }];
            }
        }
    }
    else if (self.showViewController.isScale == YES) {
        //已经缩放的情况下
        //计算比例
        CGFloat scaleXY = zoomScale - moveX / maxMoveX * ZoomScaleRight;
        if (moveX <= 5) {
            CGAffineTransform transform = CGAffineTransformMakeScale(scaleXY, scaleXY);
            self.showViewController.navigationController.view.transform = CGAffineTransformTranslate(transform, (moveX + maxMoveX), 0);
        }
        //当手势停止的时候,判断X轴的移动距离，停靠
        if (sender.state == UIGestureRecognizerStateEnded) {
            //计算剩余停靠时间
            if (-moveX >= maxMoveX / 2) {
                CGFloat duration = 0.5 * (maxMoveX + moveX)/maxMoveX > 0 ? 0.5 * (maxMoveX + moveX)/maxMoveX : -(0.5 * (maxMoveX + moveX)/maxMoveX);
                if (duration <= 0.1) duration = 0.1;
                //直接停靠到停止的位置
                [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    self.showViewController.navigationController.view.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    //将状态改为已经缩放
                    self.showViewController.isScale = NO;
                    //手动点击按钮添加遮盖
                    [self.showViewController handleClearBtnToBack];
                }];
            } else {//X轴移动不够一半 回到原位,不是缩放状态
                [UIView animateWithDuration:0.2 animations:^{
                    CGAffineTransform tt = CGAffineTransformMakeScale(zoomScale, zoomScale);
                    self.showViewController.navigationController.view.transform = CGAffineTransformTranslate(tt, maxMoveX, 0);
                } completion:^(BOOL finished) {
                    self.showViewController.isScale = YES;
                }];
            }
        }
    }
}

#pragma mark - 侧边栏的代理方法
- (void)leftMenuViewButtonClcikFromBtn:(NSInteger)formIndex to:(NSInteger)index {
    UINavigationController *newNB = self.childViewControllers[index];
    if (index == formIndex) {
        newNB = self.childViewControllers[formIndex];
    }
    UINavigationController *oldNB = self.childViewControllers[formIndex];
    [oldNB.view removeFromSuperview];
    [self.view addSubview:newNB.view];
    self.showViewController = newNB.childViewControllers[0];
    [self.showViewController handleClearBtnToBack];
}

#pragma mark - ----夜间模式开关的方法-----
- (IBAction)nightType:(UISwitch *)sender {
    if (sender.on == YES) {
        [[UIApplication sharedApplication].delegate window].alpha = 0.5;
    }else {
        [[UIApplication sharedApplication].delegate window].alpha = 1.0;
    }
}


#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftViewController];
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
