//
//  LeftView.h
//  ListenFM
//
//  Created by lanouhn on 16/3/14.
//  Copyright © 2016年 Orange. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewDelegate <NSObject>
//左边按钮被点击时调用
- (void)leftMenuViewButtonClcikFromBtn:(NSInteger)formIndex to:(NSInteger)index;

@end

@interface LeftView : UIView
@property (nonatomic, assign) id <LeftViewDelegate> delegate;
@end
