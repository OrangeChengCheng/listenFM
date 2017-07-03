//
//  NetManager.h
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
// 定义成功网请求的block
typedef void(^SuccessBlock) (id successBlock);
// 定义失败的block
typedef void(^ErrorBlock)(NSError *errorBlock);

@interface NetManager : NSObject

// 单例
+ (NetManager *)shareInstance;

// 进行get封装
- (void)getRequstWithURL:(NSString *)urlStr withType:(NSString *)type withSuccess:(SuccessBlock)successBlock withError:(ErrorBlock)errorBlock;

@end
