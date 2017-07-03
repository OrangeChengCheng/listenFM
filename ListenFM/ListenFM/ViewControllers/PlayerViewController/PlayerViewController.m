//
//  PlayerViewController.m
//  ListenFM
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "PlayerViewController.h"
#import "Header.pch"
#import "NetManager.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "CoreDataModel.h"
#import "FileHelper.h"

@interface PlayerViewController ()
@property (strong, nonatomic) NSMutableArray *arrMusicData;
@property (assign, nonatomic) CGFloat width;
@property (nonatomic, strong) UILabel *scrollLabel;
@property (copy, nonatomic) NSString *titleCopy;
@property (nonatomic, retain)NSTimer *time;//定时器
@property (nonatomic, retain)NSTimer *time1;//定时器

@property (strong, nonatomic) NSMutableArray *urlArr;
@property (strong, nonatomic) NSMutableArray *titleArr;
@property (assign, nonatomic) int indexUrl;
@property (copy, nonatomic) NSString *URL;

@property (assign, nonatomic) CGFloat totalTime;

@property (strong, nonatomic) NSManagedObjectContext *managerObjectContext;

@property (assign, nonatomic) BOOL isCollected;

@end

static CGFloat j;
@implementation PlayerViewController
#pragma mark - 单例
+ (PlayerViewController *)shareWithPlayMusicViewController {
    static PlayerViewController *playerVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerVC = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    });
    return playerVC;
}
- (void)viewDidAppear:(BOOL)animated {
    [self showSnowAnimation];
    [self.time1 invalidate];
    self.time1 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(showSnowAnimation) userInfo:AVPlayerItemFailedToPlayToEndTimeNotification repeats:YES];
    // 查询数据
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.managerObjectContext = delegate.managedObjectContext;
    
}
//懒加载常见音频播放器对象
- (AVPlayer *)player {
    if (_player == nil) {
        self.player = [[AVPlayer alloc] init];
        
    }
    return _player;
}
- (NSMutableArray *)arrMusicData {
    if (!_arrMusicData) {
        self.arrMusicData = [NSMutableArray arrayWithCapacity:0];
    }
    return _arrMusicData;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}
- (NSMutableArray *)urlArr {
    if (!_urlArr) {
        self.urlArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _urlArr;
}
- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        self.titleArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArr;
}
- (UILabel *)scrollLabel {
    if (!_scrollLabel) {
        self.scrollLabel = [[UILabel alloc] init];
        _scrollLabel.frame = CGRectMake(self.play_contentScrollView.frame.size.width, 0, self.width + 100 * RateWidth, self.play_contentScrollView.frame.size.height);
        _scrollLabel.font = [UIFont systemFontOfSize:17];
        _scrollLabel.textColor = [UIColor whiteColor];
        _scrollLabel.textAlignment = NSTextAlignmentCenter;
        [self.play_contentScrollView addSubview:self.scrollLabel];
    }
    return _scrollLabel;
}
#pragma mark - 返回上一层界面
- (IBAction)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 上一曲
- (IBAction)preAction:(UIButton *)sender {
    if (self.urlArr.count > 0) {
        [self stop];
        if (self.index != 0) {
            NSString *preStr = self.urlArr[self.index - 1];
            NSString *preTitle = self.titleArr[self.index - 1];
            [self playMusic:preStr withTitle:preTitle];
            self.index = self.index - 1;
        }
    }
}
#pragma mark - 下一曲
- (IBAction)nextAction:(UIButton *)sender {
    if (self.urlArr.count > 0) {
        [self stop];
        if (self.index != self.urlArr.count - 1) {
            NSString *nextStr = self.urlArr[self.index + 1];
            NSString *nextTitle = self.titleArr[self.index + 1];
            [self playMusic:nextStr withTitle:nextTitle];
            self.index = self.index + 1;
        }
    }
}
#pragma mark - 播放暂停
- (IBAction)playOrPauseAction:(UIButton *)sender {
    if (self.urlArr.count > 0) {
        //1:判断播放器的状态
        //播放状态
        if (self.player.rate == 1) {
            [self stop];
        }else {
            [self playing];
        }        
    }
}
#pragma mark - 播放进度
- (IBAction)progressAction:(UISlider *)sender {
    self.playerItem = self.player.currentItem;
    CGFloat currentValue = sender.value * CMTimeGetSeconds(self.playerItem.duration);
    //改变播放器的进度
    [self.player seekToTime:CMTimeMake(currentValue, 1.0)];
}
#pragma mark - 收藏下载操作
- (IBAction)playerVCMoreBtn:(UIButton *)sender {
    __weak PlayerViewController *mySelf = self;
 
    if ([[FileHelper shareInstance] loginState]) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"CoreDataModel"];
        NSArray *arr = [self.managerObjectContext executeFetchRequest:request error:nil];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        [tempArr addObjectsFromArray:arr];
        for (CoreDataModel *coreDataModel in tempArr) {
            if ([coreDataModel.url isEqualToString:self.urlArr[self.index]]) {
                self.isCollected = YES;
            }else {
                self.isCollected = NO;
            }
        }
        
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"更多操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 收藏操作
            if (mySelf.isCollected == NO) {
                CoreDataModel *model = [NSEntityDescription insertNewObjectForEntityForName:@"CoreDataModel" inManagedObjectContext:self.managerObjectContext];
                model.title = mySelf.titleArr[mySelf.index];
                model.url = mySelf.urlArr[mySelf.index];
                [mySelf.managerObjectContext save:nil];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertC addAction:alertA1];
                [mySelf presentViewController:alertC animated:YES completion:nil];
            }else {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经收藏过了！！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertC addAction:alertA1];
                [mySelf presentViewController:alertC animated:YES completion:nil];
            }
        }];
        UIAlertAction *alertA2 = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *alertA3 = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:alertA1];
        [alertC addAction:alertA2];
        [alertC addAction:alertA3];
        [self presentViewController:alertC animated:YES completion:nil];
    }else {
        IsLoginVC *loginVC = [mySelf.storyboard instantiateViewControllerWithIdentifier:@"IsLoginVC"];
        [self.navigationController pushViewController:loginVC animated:YES];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否前往登陆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertA1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIStoryboard *mainS = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *navC = [mainS instantiateViewControllerWithIdentifier:@"222"];
            [mySelf presentViewController:navC animated:YES completion:nil];
        }];
        UIAlertAction *alertA2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:alertA1];
        [alertC addAction:alertA2];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}


#pragma mark - ---------效果------------
#pragma mark - 为背景图片加奥斯模糊效果
- (void)addEffectForbackground {
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.frame = self.play_backgroudImage.frame;
    [self.play_backgroudImage addSubview:effectView];
}
#pragma mark - 雪花效果
- (void)showSnowAnimation {
    UIImageView *snow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"snowMusic"]];
    snow.alpha = (random() % 9) / 10.0 + 0.1;
    int xStart = random() % (int)ScreenWidth;
    int xStop = random() % (int)ScreenWidth;
    int size = random() % 30;
    int speed = 1;
    int width = random() % 30;
    snow.frame = CGRectMake(xStart, -width, width, width);
    [self.view addSubview:snow];
    __weak PlayerViewController *mySelf = self;
    [UIView animateWithDuration:10 * speed animations:^{
        snow.frame = CGRectMake(xStop, mySelf.view.frame.size.height, size, size);
    } completion:^(BOOL finished) {
        [snow removeFromSuperview];
    }];
}
#pragma mark - 滚动文字
- (void)setRollText:(NSString *)textStr {
    self.titleCopy = textStr;
    self.scrollLabel.text = textStr;
    CGSize size = CGSizeMake(600, self.play_contentScrollView.frame.size.height);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    self.width = [textStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.width;
    [self.time invalidate];
    self.time = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
    self.play_contentScrollView.contentSize = CGSizeMake(self.width, self.play_contentScrollView.frame.size.height);
    
}
- (void)moveAction {
    j = j + 3;
    if (j >= self.width + 250 * RateWidth) {
        j =- 195 * RateWidth;
    }
    self.play_contentScrollView.contentOffset = CGPointMake(j, 0);
}
#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // 5、监听播放进度
    [self addObserverForProgress];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 音乐
- (void)playerMusicWithModelArr:(NSMutableArray *)modelArr withIndex:(NSInteger)index {
    if (self.playerItem != nil) {
        [self stop];
    }
    if (modelArr != nil) {
        [self.urlArr removeAllObjects];
        [self.titleArr removeAllObjects];
        NSMutableArray *urlArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *titleArr = [NSMutableArray arrayWithCapacity:0];
        for (C_Listen_M *listenM in modelArr) {
            NSString *urlStr = listenM.audio_64_url;
            NSString *titleStr = listenM.title;
            [urlArr addObject:urlStr];
            [titleArr addObject:titleStr];
        }
        self.titleArr = titleArr;
        self.urlArr = urlArr;
        self.index = index;
        
        NSString *urlStr = self.urlArr[index];
        NSString *titleStr = self.titleArr[index];
        
        if (![self.URL isEqualToString:urlStr]) {
            self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlStr]];
            [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
            
            [self setRollText:titleStr];
            
            self.URL = urlStr;
            [self playing];
        }        
    }
}
#pragma mark - 内部播放
- (void)playMusic:(NSString *)string withTitle:(NSString *)title {


    if (![self.URL isEqualToString:string]) {
        self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:string]];
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        
        [self setRollText:title];
        
        self.URL = string;
        [self playing];
    }
}
//定义方法将播放界面的控件恢复为未播放的状态
- (void)stop {
    [self.player pause]; //暂停播放
    [self.play_playOrPauseBtn setImage:[UIImage imageNamed:@"playing_btn_play_n"] forState:UIControlStateNormal];//修改按钮显示的图片
    [self removeObserverFromPlayerItem:self.player.currentItem];
}
//定义方法将播放界面设置为播放状态
- (void)playing {
    [self.player play]; //启动播放器
    [self.play_playOrPauseBtn setImage:[UIImage imageNamed:@"playing_btn_pause_n"] forState:UIControlStateNormal];
    // 6、监听播放器的状态
    [self addObserverForState:self.playerItem];
}
#pragma mark - 监听播放进度
//监听播放进度
- (void)addObserverForProgress {

    //获取当前播放器的音频信息
//    AVPlayerItem *playItem = self.player.currentItem;
    //开始监听播放器播放进度的变化
    __weak PlayerViewController *mySelf = self;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //获取当前播放的进度
        float currentTime = CMTimeGetSeconds(time);

//        //获取音频文件的总时间

        mySelf.play_currentTime.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)currentTime / 3600, (int)currentTime / 60, (int)currentTime % 60];
        float timeXX = mySelf.totalTime - currentTime;
        mySelf.play_durationTime.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)timeXX / 3600, (int)timeXX / 60, (int)timeXX % 60];
        //改变进度条的进度
        mySelf.play_progressSlider.maximumValue = 1;
        [mySelf.play_progressSlider setValue:currentTime / mySelf.totalTime animated:YES];
        if (self.play_progressSlider.value == 1 || currentTime / mySelf.totalTime == 1) {
            [mySelf nextAction:nil];
        }
    }];
}
#pragma mark - 监听播放状态
//KVO监听当前播放器的播放状态
- (void)addObserverForState:(AVPlayerItem *)playItem {
    //添加监听者
    [playItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem {
    [playerItem removeObserver:self forKeyPath:@"status"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *item = object;
    if ([keyPath isEqualToString:@"status"]) {
        //获取当前的状态
        AVPlayerStatus statu = [change[@"new"] intValue];
        //如果状态是准备播放执行相应的操作
        if (statu == AVPlayerStatusReadyToPlay) {
            [self.play_playOrPauseBtn setImage:[UIImage imageNamed:@"playing_btn_pause_n"] forState:UIControlStateNormal];
            self.totalTime = CMTimeGetSeconds(item.duration);

        }
    }
}

@end
