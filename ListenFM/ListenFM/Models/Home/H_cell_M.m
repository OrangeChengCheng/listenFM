//
//  H_cell_M.m
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "H_cell_M.h"

@implementation H_cell_M
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}
@end
