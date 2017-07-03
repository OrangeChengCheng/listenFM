//
//  C_Listen_M.h
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C_Listen_M : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *contentTitle;
@property (copy, nonatomic) NSString *image_url;
@property (copy, nonatomic) NSString *user_image_url;
@property (copy, nonatomic) NSString *user_name;
@property (copy, nonatomic) NSString *audio_64_url; // 播放链接
@property (assign, nonatomic) NSInteger ID; // 进去播放界面的参数
@property (copy, nonatomic) NSString *album_id;
@property (copy, nonatomic) NSString *sub_title;


@property (copy, nonatomic) NSString *singer;
@property (copy, nonatomic) NSString *singerImg;
@property (copy, nonatomic) NSString *singerIcon;
@property (copy, nonatomic) NSString *url;


@property (assign, nonatomic) BOOL isValue;
@end

