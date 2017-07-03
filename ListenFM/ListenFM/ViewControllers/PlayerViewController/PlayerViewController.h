//
//  PlayerViewController.h
//  ListenFM
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayerViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIButton *play_backBtn;
@property (strong, nonatomic) IBOutlet UIButton *play_nextBtn;
@property (strong, nonatomic) IBOutlet UIButton *play_preBtn;
@property (strong, nonatomic) IBOutlet UIButton *play_playOrPauseBtn;
@property (strong, nonatomic) IBOutlet UILabel *play_currentTime;
@property (strong, nonatomic) IBOutlet UILabel *play_durationTime;
@property (strong, nonatomic) IBOutlet UISlider *play_progressSlider;
@property (strong, nonatomic) IBOutlet UIScrollView *play_contentScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *play_image;
@property (strong, nonatomic) IBOutlet UIImageView *play_backgroudImage;
@property (strong, nonatomic) IBOutlet UILabel *play_title;

@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerItem *playerItem;

@property (nonatomic, strong)NSMutableArray *dataSource; //存储所有的音频数据
@property (nonatomic)NSInteger index; //存储当前需要播放的音频数据的下标


+ (PlayerViewController *)shareWithPlayMusicViewController;

- (void)startNetWorkForMusicPlay:(NSString *)ID;

- (void)playerMusicWithModelArr:(NSMutableArray *)modelArr withIndex:(NSInteger)index;

@end
