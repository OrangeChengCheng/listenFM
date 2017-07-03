//
//  FileHelper.h
//  ListenFM
//
//  Created by lanouhn on 16/3/19.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface FileHelper : NSObject

+ (FileHelper *) shareInstance;

#pragma mark - ----用户信息-----
// 同步
- (void)synchronize;

// 设置用户信息
- (void)setLoginState:(BOOL)isLogin;
- (void)setUserName:(NSString *)userName; // 用户名
- (void)setPassword:(NSString *)password; // 密码
- (void)setEmail:(NSString *)email; // 邮箱
- (void)setPhoneNumber:(NSString *)phone; // 电话
- (void)setImage:(NSData *)image; // 图片


// 获取用户信息
- (BOOL)loginState;
- (NSString *)userName;
- (NSString *)password;
- (NSString *)emailAddress;
- (NSString *)phoneNumber;
- (NSData *)image;


- (User *)user;

#pragma mark ----数据库缓存-----
// 数据库存储路径
- (NSString *)dataBaseFilePath:(NSString *)dataBaseName;
// 将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;
// 反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key;

@end
