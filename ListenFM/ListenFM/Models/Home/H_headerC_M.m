//
//  H_headerC_M.m
//  ListenFM
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "H_headerC_M.h"

@implementation H_headerC_M
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}
@end
