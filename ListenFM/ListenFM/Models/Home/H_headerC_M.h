//
//  H_headerC_M.h
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface H_headerC_M : NSObject
@property (copy, nonatomic) NSString *title; // 区头标题
@property (assign, nonatomic) NSInteger ID; // 区头id用于调转更多界面参数
@property (copy, nonatomic) NSString *redirect_value; // 更多界面跳转参数
@end
