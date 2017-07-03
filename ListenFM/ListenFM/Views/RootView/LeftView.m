//
//  LeftView.m
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import "LeftView.h"
@interface LeftView ()
@property (strong, nonatomic) IBOutlet UIButton *homePageBtn;
@property (strong, nonatomic) IBOutlet UIButton *channelBtn;
@property (strong, nonatomic) IBOutlet UIButton *mainBtn;
@property (strong, nonatomic) IBOutlet UIButton *downloadBtn;

@property(nonatomic)NSInteger index;
@property (nonatomic)BOOL isplay;

@end

@implementation LeftView
#pragma mark - 点击按钮的方法
- (IBAction)handleBtnAction:(UIButton *)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.isplay == NO) {
        NSLog(@"1");
        if ([self.delegate respondsToSelector:@selector(leftMenuViewButtonClcikFromBtn:to:)]) {
            [self.delegate leftMenuViewButtonClcikFromBtn:0 to:(0)];
            self.index = 101;
        }
        self.isplay = YES;
    } else {
        NSLog(@"2");
        if ([self.delegate respondsToSelector:@selector(leftMenuViewButtonClcikFromBtn:to:)]) {
            [self.delegate leftMenuViewButtonClcikFromBtn:(self.index - 101) to:(btn.tag - 101)];
            self.index = btn.tag;
        }
    }
}
#pragma mark - 代理
- (void)setDelegate:(id<LeftViewDelegate>)delegate {
    _delegate = delegate;
    [self handleBtnAction:nil];
}


@end
