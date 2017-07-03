//
//  User.h
//  ListenFM
//
//  Created by lanouhn on 16/3/19.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *emailAddress;
@property (copy, nonatomic) NSString *phoneNumber;

@property (strong, nonatomic) NSData *image;

@property (assign, nonatomic) BOOL isLogin;

@end
