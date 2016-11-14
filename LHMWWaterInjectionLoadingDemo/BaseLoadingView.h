//
//  BaseLoadingView.h
//  EmployeeAssistant
//
//  Created by LiHaomiao on 2016/10/10.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

//触发重新加载的按钮的block
typedef void(^BaseLoadingViewReloadBlock)( id result );

@interface BaseLoadingView : UIView

@property (nonatomic, readwrite, copy) BaseLoadingViewReloadBlock reloadBlock;

/**
 * 开始加载，同时动画开始
 */
- (void)startLoading;

/**
 * 记载失败，网络出错后的显示
 */
- (void)networkLoadFailure;
- (void)networkLoadFailureWithImage:(UIImage *)image;

/**
 * 数据为空时，需要显示
 */
- (void)noMessageWithMessage:(NSString *)message image:(UIImage *)image;

/**
 * 当数据加载成功后，removeFromSuperView
 */
- (void)loadingDataSuccess;

@end
