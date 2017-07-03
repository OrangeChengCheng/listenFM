//
//  C_HotOne_M.h
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C_HotOne_M : NSObject
@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *title; // 标题
@property (copy, nonatomic) NSString *describe; // 内容
@property (copy, nonatomic) NSString *image_url; // 图片
@property (copy, nonatomic) NSString *concern_num; // 看
@property (copy, nonatomic) NSString *comment_num; // 评论

@property (copy, nonatomic) NSString *album_id; // 跳转播放参数

@end
