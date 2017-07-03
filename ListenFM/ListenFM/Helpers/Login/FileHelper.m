//
//  FileHelper.m
//  ListenFM
//
//  Created by lanouhn on 16/3/19.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "FileHelper.h"
#import "User.h"

@implementation FileHelper
+ (FileHelper *)shareInstance {
    static FileHelper *fileHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileHelper = [[FileHelper alloc] init];
    });
    return fileHelper;
}

#pragma mark ----用户信息-----
// 同步
- (void)synchronize {
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 设置用户信息
- (void)setLoginState:(BOOL)isLogin {
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLogin"];
}


- (void)setUserName:(NSString *)userName {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
}
- (void)setPassword:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
}
- (void)setEmail:(NSString *)email {
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
}
- (void)setPhoneNumber:(NSString *)phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
}
- (void)setImage:(NSData *)image {
    [[NSUserDefaults standardUserDefaults] setObject:image forKey:@"image"];
}


//获取用户信息
- (BOOL)loginState {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}
- (NSString *)userName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}
- (NSString *)password {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}
- (NSString *)emailAddress {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
}
- (NSString *)phoneNumber {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}
- (NSData *)image {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"image"];
}

- (User *)user {
    User *user = [[User alloc] init];
    user.userName = [self userName];
    user.password = [self password];
    user.emailAddress = [self emailAddress];
    user.phoneNumber = [self phoneNumber];
    user.image = [self image];
    return user;
}

#pragma mark ----数据库路径-----
- (NSString *)cachePah {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

// 数据库存储的路径
- (NSString *)dataBaseFilePath:(NSString *)dataBaseName {
    return [[self cachePah] stringByAppendingPathComponent:dataBaseName];
}

// 将对象归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key {
    NSMutableData *data = [NSMutableData data];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    return data;
}

// 反归档
- (id)unarchiverObject:(NSData *)data forKey:(NSString *)key {
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    id object = [unarchiver decodeObjectForKey:key];
    NSLog(@"--------%@", object);
    
    [unarchiver finishDecoding];
    
    return object;
}

@end
