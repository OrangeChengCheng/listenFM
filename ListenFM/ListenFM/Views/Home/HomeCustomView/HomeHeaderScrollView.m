//
//  HomeHeaderScrollView.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "HomeHeaderScrollView.h"
#import "Header.pch"

@implementation HomeHeaderScrollView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
    }
    return self;
}
- (SDCycleScrollView *)scrollView {
    if (!_scrollView) {
        self.scrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 3 + 68)];
        _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _scrollView.placeholderImage = nil;
    }
    return _scrollView;
}

- (void)getHeaderImages:(NSMutableArray *)images {
    self.scrollView.imageURLStringsGroup = images;
}
@end
