//
//  D_show_M.h
//  ListenFM
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface D_show_M : NSObject
@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *album_id;
@property (copy, nonatomic) NSString *audio_64_url;
@property (copy, nonatomic) NSString *play_num;
@property (copy, nonatomic) NSString *duration;
@property (copy, nonatomic) NSString *image_url;


@end
