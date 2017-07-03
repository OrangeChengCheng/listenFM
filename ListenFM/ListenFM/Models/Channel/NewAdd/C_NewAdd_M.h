//
//  C_NewAdd_M.h
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface C_NewAdd_M : NSObject
@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString *title; // 标题
@property (copy, nonatomic) NSString *image_url; // 图片
@property (copy, nonatomic) NSString *created; // 时间

@end
