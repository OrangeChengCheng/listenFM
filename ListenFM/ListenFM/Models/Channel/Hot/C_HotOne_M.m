//
//  C_HotOne_M.m
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "C_HotOne_M.h"

@implementation C_HotOne_M
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}
@end
