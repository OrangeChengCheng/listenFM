//
//  NetManager.m
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "NetManager.h"
#import "AFNetworking.h"

@implementation NetManager

+ (NetManager *)shareInstance {
    static NetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetManager alloc] init];
    });
    return manager;
}

- (void)getRequstWithURL:(NSString *)urlStr withType:(NSString *)type withSuccess:(SuccessBlock)successBlock withError:(ErrorBlock)errorBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 指定支持的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:type, nil];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // 用block将请求成功的结果回调出去
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        // 用block将请求失败的结果回调出去
        errorBlock(error); 
    }];
}

@end
