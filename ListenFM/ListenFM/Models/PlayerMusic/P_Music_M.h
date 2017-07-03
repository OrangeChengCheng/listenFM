//
//  P_Music_M.h
//  ListenFM
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface P_Music_M : NSObject
@property (assign, nonatomic) NSString *album_id;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *audio_64_url;
@property (copy, nonatomic) NSString *image_url;

@end
