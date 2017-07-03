//
//  C_Rank_M.h
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C_Rank_M : NSObject
@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *title; // 标题
@property (copy, nonatomic) NSString *play_num; // 播放量

@property (assign, nonatomic) BOOL isValue; // 判断给定cell

@end
