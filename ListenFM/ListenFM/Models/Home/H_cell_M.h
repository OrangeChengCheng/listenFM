//
//  H_cell_M.h
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface H_cell_M : NSObject
@property (assign, nonatomic) NSInteger ID; // cell的ID
@property (copy, nonatomic) NSString *title; //标题
@property (copy, nonatomic) NSString *item_value; // 跳转播放界面的参数
@property (copy, nonatomic) NSString *sub_title; // 小标题
@property (copy, nonatomic) NSString *image_url; // 图片
@end
