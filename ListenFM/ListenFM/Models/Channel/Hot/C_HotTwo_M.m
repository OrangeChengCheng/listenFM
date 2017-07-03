//
//  C_HotTwo_M.m
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "C_HotTwo_M.h"

@implementation C_HotTwo_M
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}
@end
