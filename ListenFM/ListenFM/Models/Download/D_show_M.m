//
//  D_show_M.m
//  ListenFM
//
//  Created by lanouhn on 16/3/17.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "D_show_M.h"

@implementation D_show_M
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}
@end
